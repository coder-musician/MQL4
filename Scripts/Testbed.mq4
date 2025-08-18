//+------------------------------------------------------------------+
//|                                                      Testbed.mq4 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\\Include\\RockEquity\\Classes\\Management.mqh";

#import
   void test();
#import
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
     Management::UpdateValues();   
  }
//+------------------------------------------------------------------+
