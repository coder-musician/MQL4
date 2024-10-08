//+------------------------------------------------------------------+
//|                                                 tpCalculator.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\Include\Custom\Management.mqh"
#include "..\Include\Custom\Orders.mqh"
#include "..\Include\Custom\Journal.mqh"



//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
      return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {   
      
      Management management = Management();
      Orders orders = Orders();
      Journal journal = Journal();
      
      string snapshotName = IntegerToString(OrderTicket()) + "-" + 
         IntegerToString(Period()) + "-" + IntegerToString(Bars);
      
      orders.GetOrdersList();
      bool areOrdersActive = orders.checkForActiveOrders(Symbol());
      
      if(!areOrdersActive) {
      
         management.UpdateTakeProfit(NormalizeDouble(ObjectGet("SL_BID", 1),Digits));  
         CANDLES_COUNT = 0;
         
         if(IS_ORDER_ACTIVE) {
            
            snapshotName = snapshotName + "-close";
            journal.takeScreenshot(snapshotName);
            IS_ORDER_ACTIVE = False;
            management.DeleteLevels();
         }
      }
      else {
         
         if(!IS_ORDER_ACTIVE) {
         
            snapshotName = snapshotName + "-open";
            journal.takeScreenshot(snapshotName);
            IS_ORDER_ACTIVE = True;
         }
         
         if(CANDLES_COUNT < Bars) {
                     
            journal.takeScreenshot(snapshotName);
            
            CANDLES_COUNT = Bars;
         }
         
         management.LoadValues();
         
         double origSL = StringToDouble(OrderComment());
         //Alert(ORDER_OPERATION + " -- " + OP_BUY);
         if((STOP_RISK_BID_PRICE < Bid && (STOP_RISK_BID_PRICE < origSL)) ||  
         (STOP_RISK_BID_PRICE > Bid && (STOP_RISK_BID_PRICE > origSL))) {
       
            management.MoveLevels(TAKE_PROFIT_BID_PRICE, origSL);
         }
         
         if(TAKE_PROFIT_BID_PRICE != 0 && STOP_RISK_BID_PRICE != 0) {
         
            orders.UpdateOrder(ORDERS_LIST[0], STOP_RISK_BID_PRICE, TAKE_PROFIT_BID_PRICE);
            
            if(GetLastError() == ERR_INVALID_STOPS) {
                        
               management.MoveLevels(OrderTakeProfit(), OrderStopLoss());
               management.AdjustAskLines(TAKE_PROFIT_BID_PRICE, STOP_RISK_BID_PRICE);
            }
         }
         else {
            
            management.DeleteLevels();
            management.PlotLevels(OrderOpenPrice(), OrderTakeProfit(), OrderStopLoss());            
         }
         
         management.AdjustAskLines(TAKE_PROFIT_BID_PRICE, STOP_RISK_BID_PRICE);
      }
  }
  

//+------------------------------------------------------------------+
      
  