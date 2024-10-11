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
      order.CloseOrder();
      
      Management management = Management();
      management.DeleteLevels();   
  }
//+------------------------------------------------------------------+