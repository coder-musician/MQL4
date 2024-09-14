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
      
      Management management = Management();
         
      ORDER_TICKET = 0;
      
      for(int i=0; i<OrdersTotal(); i++) {
      
         bool openOrder = OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
         
         if(openOrder && OrderSymbol() == Symbol()){
            
            ORDER_TICKET = OrderTicket(); 
            
            break;
         }
      }
      
      if(ORDER_TICKET == 0) {
      
         management.UpdateValues();
      }
      else {
         
         management.LoadValues();
         
         if(TAKE_PROFIT_BID_PRICE != OrderTakeProfit() || STOP_RISK_BID_PRICE != OrderStopLoss()) {
            
            Orders order = Orders();
            order.UpdateOrder(ORDER_TICKET, STOP_RISK_BID_PRICE, TAKE_PROFIT_BID_PRICE);
            management.AdjustLines(TAKE_PROFIT_BID_PRICE, STOP_RISK_BID_PRICE);
         } 
         
         Alert(ORDER_TICKET + " -- " + TAKE_PROFIT_BID_PRICE + " - " + OrderTakeProfit() + " ** " + STOP_RISK_BID_PRICE + " - " + OrderStopLoss());
         
      }
  }
  

//+------------------------------------------------------------------+
      //Alert(ORDER_TICKET);
  /*
      Management management = Management();
      management.LoadValues();
      
      Orders order = Orders();
      IS_ORDER_ACTIVE = False;
      
      for(int i=0; i<OrdersTotal(); i++) {
      
         bool openOrder = OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
         
         if(openOrder && OrderSymbol() == Symbol()){
            
            ORDER_TICKET = OrderTicket(); 
            break;
         }
      }
   
      if (ORDER_TICKET != -1) {
         
         IS_ORDER_ACTIVE = True;
         ORDER_OPEN_PRICE = OrderOpenPrice();
         ORDER_PROFIT_PRICE = OrderTakeProfit();
         ORDER_RISK_PRICE = OrderStopLoss();
         ORDER_LOTS = OrderLots();
         
         if(TAKE_PROFIT_BID_PRICE != ORDER_PROFIT_PRICE || STOP_RISK_BID_PRICE != ORDER_RISK_PRICE) {
      
            order.UpdateOrder(ORDER_TICKET, STOP_RISK_BID_PRICE, TAKE_PROFIT_BID_PRICE);
         } 
      }
      else {
      
         management.UpdateValues();
      }
      
      
  
  */