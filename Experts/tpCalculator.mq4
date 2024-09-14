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
      Orders orders = Orders();
      
      orders.GetOrdersList();
      
      //if(ORDERS_LIST[0] == 0) {
      if(OrdersTotal() == 0) {
      
         management.UpdateTakeProfit(NormalizeDouble(ObjectGet("SL_BID", 1),Digits));         
      }
      else {
         
         management.LoadValues();
         
         if(OPEN_BID_PRICE != 0 && TAKE_PROFIT_BID_PRICE != 0 && STOP_RISK_BID_PRICE != 0) {
         
            orders.UpdateOrders(ORDERS_LIST[0], STOP_RISK_BID_PRICE, TAKE_PROFIT_BID_PRICE);
            
            if(GetLastError() == ERR_INVALID_STOPS) {
                        
               management.MoveLevels(OPEN_BID_PRICE, OrderTakeProfit(), OrderStopLoss());
               //management.AdjustAskLines(TAKE_PROFIT_BID_PRICE, STOP_RISK_BID_PRICE);
            }
         }
         else {
            
            management.DeleteLevels();
            management.PlotLevels(OrderOpenPrice(), OrderTakeProfit(), OrderStopLoss());            
         }
         
         //management.AdjustAskLines(TAKE_PROFIT_BID_PRICE, STOP_RISK_BID_PRICE);
      }
  }
  

//+------------------------------------------------------------------+
      
               /*

         
         if(OPERATION_TYPE == OP_BUY) {           
            
            if(Ask <= STOP_RISK_ASK_PRICE+halfSpread || Ask >= TAKE_PROFIT_ASK_PRICE-halfSpread) {
                  
                  management.DeleteLevels();
            }
         }
         else if (OPERATION_TYPE == OP_SELL) {
            
            if(Bid >= STOP_RISK_BID_PRICE-halfSpread || Bid <= TAKE_PROFIT_BID_PRICE+halfSpread) {
            
               management.DeleteLevels();
            }
         }
         
         
         
         */
         
         
         //Alert(ORDER_TICKET + " -- " + TAKE_PROFIT_BID_PRICE + " - " + OrderTakeProfit() + " ** " + STOP_RISK_BID_PRICE + " - " + OrderStopLoss());
      
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