//+------------------------------------------------------------------+
//|                                                         test.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\Include\Custom\Management.mqh"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+



void OnStart()
  {
       Management management = Management();
       management.DeleteLevels();
       management.SetLevels(IntegerToString(ChartID()));
  }

//+------------------------------------------------------------------+
