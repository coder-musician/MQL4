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

int CANDLES_COUNT = 0;

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
  
      //if(IntegerToString(ChartID()) == ObjectGetString(0,"SL_BID", OBJPROP_TEXT,0)) {
      //if(ChartID() == StringToInteger(ObjectGetString(0,"SL_BID", OBJPROP_TEXT,0))) {
      
      Management management = Management();
      Journal journal = Journal();
      
      if(CANDLES_COUNT < Bars) {
         
         journal.MarketScreenshot(Symbol());
         CANDLES_COUNT = Bars;
      }
      
      string snapshotName = IntegerToString(OrderTicket()) + "-" + 
         IntegerToString(Period()) + "-" + IntegerToString(Bars);      
         
      Orders orders = Orders();         
      
      orders.GetOrdersList();
      bool areOrdersActive = orders.checkForActiveOrders(Symbol());
      
      if(!areOrdersActive) {
      
         management.UpdateTakeProfit(NormalizeDouble(ObjectGet("SL_BID", 1),Digits));  
         
         if(IS_ORDER_ACTIVE) {
            
            journal.CloseScreenshot(Symbol(), ORDERS_LIST[0]);
            IS_ORDER_ACTIVE = False;
            management.DeleteLevels();
         }
      }
      else {
         
         if(!IS_ORDER_ACTIVE) {
         
            journal.OpenScreenshot(Symbol(), ORDERS_LIST[0]);
            IS_ORDER_ACTIVE = True;
         }
         
         management.LoadValues();
         
         double origSL = StringToDouble(OrderComment());
         
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
      
  