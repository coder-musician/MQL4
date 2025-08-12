//+------------------------------------------------------------------+
//|                                                      Testbed.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\Include\Custom\Orders.mqh"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   
void OnStart()
  {
      Orders orders = Orders();
      
      orders.
      
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
  }
  