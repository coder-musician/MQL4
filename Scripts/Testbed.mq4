//+------------------------------------------------------------------+
//|                                                      Testbed.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\Include\Custom\Journal.mqh"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   
void OnStart()
  {
      //Journal journal = Journal();
      
      //journal.CustomSnapshot(ChartID());
      //journal.MarketSnapshot(ChartID());
      //journal.OpenSnapshot(ChartID(),123456);
      //journal.TradeSnapshot(ChartID(),123456);
      //journal.CloseSnapshot(ChartID(),123456);+
      
      MessageBox(ACCOUNT_CURRENCY);
  }
  