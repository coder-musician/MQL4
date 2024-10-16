//+------------------------------------------------------------------+
//|                                                      Testbed.mq4 |
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
#include "..\Include\Custom\Analytics.mqh"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

void OnStart()
  {
//---
      Analytics analytics = Analytics();

      ANALYTICS_TICKET = 71837;
      ANALYTICS_LOTS = 10.75;
      ANALYTICS_OPERATION = OP_BUY;
      
      ANALYTICS_OPEN_DATETIME = IntegerToString(TimeCurrent());
      ANALYTICS_OPEN_PRICE = 1.456798;
      
      ANALYTICS_CLOSE_DATETIME = IntegerToString(TimeCurrent());
      ANALYTICS_CLOSE_PRICE = 1.556789;
            
      analytics.WriteStats();
   
  }
//+------------------------------------------------------------------+
