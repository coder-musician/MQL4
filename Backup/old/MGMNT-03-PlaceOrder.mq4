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
int OPERATION = OP_BUY;
double SPREAD = Ask - Bid;

int getMultiplier() {
   
   string multiplier = "1";
      
      for(int i=1; i < Digits; i++) {
         
         multiplier = multiplier + "0";
      }
     
   return multiplier;
}

double getPipsInPoints(double slBid) {

   double pipsInDecimals = 0;
   
   
   if(slBid < Bid) {
      
         pipsInDecimals = Ask - slBid;
         
      }
      else{
         OPERATION = OP_SELL;
         pipsInDecimals = slBid - Ask + SPREAD;
      }  
      
   double pipsInPoints = pipsInDecimals * getMultiplier();
   
   return pipsInPoints;
}



void OnStart()
  {   

      double ORDERS_RISK_PERCENTAGE = 1;
      double AMOUNT_RISKED = (AccountEquity()*(ORDERS_RISK_PERCENTAGE/100));        
      
      double SL_BID = NormalizeDouble(ObjectGet("SL", 1),Digits);      
      double SL_PIPS_RISKED = getPipsInPoints(SL_BID);
      
      double PIPS_VALUE_PER_LOT = 10; // <-- FIND OUT
      double LOT = (AMOUNT_RISKED/SL_PIPS_RISKED)/PIPS_VALUE_PER_LOT;
      
      OrderSend(Symbol(), OPERATION, LOT, Bid, 0, 0, 0, "");
  }
//+------------------------------------------------------------------+
      // double PIP_VALUE = (AMOUNT_RISKED / SL_PIPS_RISKED);
      //double ORDER_LOTS = ((PIP_VALUE*SL_PIPS_RISKED)/AMOUNT_RISKED);
      //double ORDER_LOTS = (AMOUNT_RISKED/SL_PIPS_RISKED/PIPS_VALUE_PER_LOT);
            //MessageBox(LOT);
      //MessageBox((AMOUNT_RISKED/SL_PIPS_RISKED/PIPS_VALUE_PER_LOT));