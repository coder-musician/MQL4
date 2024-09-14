//+------------------------------------------------------------------+
//|                                              2- Delete Lines.mq4 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+


 
void OnStart()
  {
      ObjectDelete(0, "OPEN_PRICE");
      ObjectDelete(0, "TP_ASK");
      ObjectDelete(0, "TP_BID");
      ObjectDelete(0, "SL_ASK");
      ObjectDelete(0, "SL_BID");
  }
//+------------------------------------------------------------------+
