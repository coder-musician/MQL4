//+------------------------------------------------------------------+
//|                                            ORDERS-CloseOrder.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
#include "..\Include\Custom\Orders.mqh"
#include "..\Include\Custom\Management.mqh"

void OnStart()
  {
//---
      Orders order = Orders();
      order.GetOrdersList();
      
      for(int i=0; i<ArraySize(ORDERS_LIST); i++) {
         
         if(ORDERS_LIST[i] == 0)
            break;
            
         double currentOrder = OrderSelect(ORDERS_LIST[i], SELECT_BY_TICKET, MODE_TRADES );
         order.CloseOrder(OrderTicket(), OrderLots(), OrderOpenPrice());
         
      }
  }
//+------------------------------------------------------------------+