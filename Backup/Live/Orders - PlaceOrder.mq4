//+------------------------------------------------------------------+
//|                                                         test.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\Include\Custom\Orders.mqh"
#include "..\Include\Custom\Management.mqh"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

void OnStart()
  {   
  
      Orders order = Orders();
      
  
      
      //double newOrder = OrderSend(Symbol(), OPERATION, order.getLots(), OPEN_PRICE, 0, 0, 0, "");     
      
      //ObjectCreate("Price", OBJ_HLINE, 0, Time[0], OPEN_PRICE, 0, 0);
      //ObjectSetInteger(0,"Price",OBJPROP_COLOR,clrWhite);
      
  }
//+------------------------------------------------------------------+