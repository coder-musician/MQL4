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

void OnStart()
  {
//---

   
   Orders order = Orders();
   order.GetOrdersList();
   
   order.LoadOrderValues(ORDERS_LIST[0]);
   order.CloseOrder();
   
   ObjectDelete(0, "OPEN_PRICE");
   ObjectDelete(0, "TP_ASK");
   ObjectDelete(0, "TP_BID");
   ObjectDelete(0, "SL_ASK");
   ObjectDelete(0, "SL_BID");
   
  }
//+------------------------------------------------------------------+
