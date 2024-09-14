//+------------------------------------------------------------------+
//|                                                pips_function.mq4 |
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
   double CalculateNormalizedDigits()
{
   // If there are 3 or fewer digits (JPY, for example), then return 0.01, which is the pip value.
   if (Digits <= 3){
      return(0.01);
   }
   // If there are 4 or more digits, then return 0.0001, which is the pip value.
   else if (Digits >= 4){
      return(0.0001);
   }
   // In all other cases, return 0.
   else return(0);
}

void OnStart()
  {
      double nDigits = CalculateNormalizedDigits();
      Print("Number of Digits ", Digits, " - Stop Loss ", Ask - (StopLoss * nDigits));

  }
//+------------------------------------------------------------------+
