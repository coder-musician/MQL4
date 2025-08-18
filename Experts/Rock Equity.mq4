//+------------------------------------------------------------------+
//|                                                  Rock Equity.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\\Include\\RockEquity\\Utils.mqh"
#include "..\\Include\\RockEquity\\Constants.mqh"

#include "..\\Include\\RockEquity\\Classes\\RockExpert.mqh"
#include "..\\Include\\RockEquity\\Classes\\Orders.mqh"
#include "..\\Include\\RockEquity\\Classes\\Management.mqh"


#import
   // UTILS
   //void LoadValues();
   //double GetLinePrice(string LineName) ;
   
   // ORDERS
   //bool checkForActiveOrders();
   
   //MANAGEMENT
   //void UpdateTakeProfit(double SlBid);
   
#import
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
      /*
      if(RockExpert::isNewCandle()) {
      
         Alert("SII");
      }*/
      
      RockExpert::setLTFColors();
      Orders::checkForActiveOrders();
      Management::LoadValues();
      
      if(!IS_ORDER_ACTIVE) {
         
         if(ChartPeriod() == LTF) {
         
            //Management::UpdateTakeProfit(double STOP_RISK_BID_PRICE);
            
         }
      }
      else {
         
         
      }
      
      
      /*

         if(IS_ORDER_ACTIVE) {
            
            IS_ORDER_ACTIVE = False;
            
            string tradeDetails = ORDER_DATE + "," + 
            ORDER_TIME + "," + 
            Symbol() + "," + 
            DoubleToString(ORDER_OPERATION) + "," + 
            DoubleToString(ORDER_TICKET) + "," + 
            DoubleToString(ORDER_OPEN_PRICE) + "," +
            DoubleToString(ORDER_PROFIT_PRICE) + "," +  
            DoubleToString(OrderTakeProfit()) + "," +
            DoubleToString(ORDER_RISK_PRICE) + "," + 
            DoubleToString(OrderStopLoss()) + "," + 
            DoubleToString(OrderProfit());
            
            if(ChartPeriod() != HTF) {
               
               journal.CloseSnapshot(ChartID(),ORDERS_LIST[0]);
               analytics.writeTradeDetails(tradeDetails);
            }
               
            management.DeleteLevels();
         }

         if(isNewCandle())
         
            if(ChartPeriod() != HTF)            
               journal.MarketSnapshot(ChartID());
      }
      else {
         
         if(!IS_ORDER_ACTIVE) {
         
            string date = utils.GetDate();
            string time = utils.GetTime();            
            
            IS_ORDER_ACTIVE = True;
            
            ORDER_TICKET = OrderTicket();
            ORDER_DATE = date;
            ORDER_TIME = time;
            ORDER_OPEN_PRICE = OrderOpenPrice();
            ORDER_PROFIT_PRICE = OrderTakeProfit();
            ORDER_RISK_PRICE = OrderStopLoss();
            
            if(ChartPeriod() != HTF)
               journal.OpenSnapshot(ChartID(),ORDERS_LIST[0]);
         }
         
         if(isNewCandle())
         
            journal.TradeSnapshot(ChartID(),ORDERS_LIST[0]);
            management.LoadValues();    
            
            if((STOP_RISK_BID_PRICE < Bid && (STOP_RISK_BID_PRICE < ORDER_RISK_PRICE)) ||  
            (STOP_RISK_BID_PRICE > Bid && (STOP_RISK_BID_PRICE > ORDER_RISK_PRICE))) 
               management.MoveLevels(OrderTakeProfit(), ORDER_RISK_PRICE);
            
            if(STOP_RISK_BID_PRICE != 0 && TAKE_PROFIT_BID_PRICE != 0)
            
               if(OrderTakeProfit() != TAKE_PROFIT_BID_PRICE || OrderStopLoss() != STOP_RISK_BID_PRICE) {
                  orders.UpdateOrder(ORDERS_LIST[0], STOP_RISK_BID_PRICE, TAKE_PROFIT_BID_PRICE);
            } 
            else {
               
               management.DeleteLevels();
               
               if(ChartPeriod() != HTF)  
                  management.PlotLevels(OrderOpenPrice(), OrderTakeProfit(), OrderStopLoss());            
            }
            
            management.AdjustAskLines(TAKE_PROFIT_BID_PRICE, STOP_RISK_BID_PRICE);
         }*/
  }
  

//+------------------------------------------------------------------+
      