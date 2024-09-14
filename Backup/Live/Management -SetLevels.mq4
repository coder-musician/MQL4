//+------------------------------------------------------------------+
//|                                                         test.mq4 |
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

   // --- SETTINGS -----
   int DEFAULT_PIPS = 10;
   // ------------------
   double SPREAD = Ask-Bid;
   double STOP_LOSS_PIPS = Bid - (SPREAD*DEFAULT_PIPS);
   
   ObjectDelete(0, "TP");
   ObjectDelete(0, "SL");
      
   ObjectCreate("SL", OBJ_HLINE, 0, Time[0], SL_BID, 0, 0);
   ObjectSetInteger(0,"SL",OBJPROP_COLOR,clrRed);   
}

//+------------------------------------------------------------------+
