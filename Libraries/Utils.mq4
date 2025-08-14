//+------------------------------------------------------------------+
//|                                                        Utils.mq4 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| My function                                                      |
//+------------------------------------------------------------------+
// int MyCalculator(int value,int value2) export
//   {
//    return(value+value2);
//   }
//+------------------------------------------------------------------+
void SetLevels export {
         
         ObjectCreate("SL_BID", OBJ_HLINE, 0, Time[0], (Bid - ((Ask-Bid)*5)));
         //ObjectSetInteger(0,"SL_BID",OBJPROP_COLOR, clrRed);
      }