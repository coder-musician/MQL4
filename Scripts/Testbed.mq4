//+------------------------------------------------------------------+
//|                                                      Testbed.mq4 |
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
void OnStart()
  {
//---

   ObjectSetString(0,"SL_BID", OBJPROP_TEXT, DoubleToStr(Ask));
   
  }
//+------------------------------------------------------------------+
