//+------------------------------------------------------------------+
//|                                                    SetLevels.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\\Include\\RockEquity\\Classes\\Management.mqh";
#include "..\\Include\\RockEquity\\Constants.mqh";

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

void OnStart()
  {   
      Management::DeleteLevels(0);
      
      double Spread = (Ask-Bid);
      double Risk = Spread*SL_FACTOR;
      
      Management::DeleteLevels(0);
      
      int Result = MessageBox("Are you Buying this currency Pair?", 
         "Select Operation Type", MB_YESNOCANCEL | MB_ICONQUESTION);
     
      if (Result == IDYES)
         Management::PlotLine(0 ,"SL", Bid - Risk, STOP_LOSS_COLOR);
      if (Result == IDNO)
         Management::PlotLine(0 ,"SL", Bid + Risk, STOP_LOSS_COLOR);
         
         
      

//--- 

  }
//+------------------------------------------------------------------+
