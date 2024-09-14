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
      Orders order = Orders();
      order.fetchOrder();
      
      Management trade = Management();
      trade.refresh();
      
      
      if(!IS_ORDER_ACTIVE) {
      
         if(ObjectFind(0, "TP") == -1) {
            
            ObjectCreate("TP", OBJ_HLINE, 0, Time[0], Bid, 0, 0);
            ObjectSetInteger(0,"TP",OBJPROP_COLOR,clrGreen);
         }
         
      }
      else {
      
         
         if (TAKE_PROFIT_PRICE != ORDER_PROFIT_PRICE || STOP_LOSS_PRICE != ORDER_RISK_PRICE) {
            
            if(OPERATION_TYPE != OP_BUY) {
            
               ORDER_PROFIT_PRICE = TAKE_PROFIT_PRICE + SPREAD;
               ORDER_RISK_PRICE = STOP_LOSS_PRICE + SPREAD;               
            
            } else {
               
               ORDER_PROFIT_PRICE = TAKE_PROFIT_PRICE;
               ORDER_RISK_PRICE = STOP_LOSS_PRICE;
            }
            
            double openOrder = OrderModify(ORDER_TICKET,0, ORDER_RISK_PRICE, ORDER_PROFIT_PRICE, 0, clrNONE); 
            
            if(Bid == ORDER_PROFIT_PRICE || Bid == ORDER_RISK_PRICE) {trade.deleteLines();}
       }                 
     }
  }
  
//+------------------------------------------------------------------+
