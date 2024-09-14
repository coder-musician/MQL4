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
   double SPREAD = Ask-Bid;
   int DEFAULT_PIPS = 10;
   double SL_BID = Bid - (SPREAD*DEFAULT_PIPS);
   
   ObjectDelete(0, "TP");
   ObjectDelete(0, "SL");
      
   ObjectCreate("SL", OBJ_HLINE, 0, Time[0], SL_BID, 0, 0);
   ObjectSetInteger(0,"SL",OBJPROP_COLOR,clrRed);   
}
/*

//+------------------------------------------------------------------+
//|                                                1- Draw Lines.mq4 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include "classes\JOrders.mqh"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

double SPREAD = Ask-Bid;
double 

void drawSL(double mySpread, bool isBull, int pipsNumber) {
   
   double pipsSL = mySpread * pipsNumber;
   
   if (isBull) {
      
      ObjectCreate("SL", OBJ_HLINE, 0, Time[0], Bid-pipsSL, 0, 0);
      ObjectSetInteger(0,"SL",OBJPROP_COLOR,clrRed);
      
   } else {
      
      ObjectCreate("SL", OBJ_HLINE, 0, Time[0], Bid-(SPREAD*3), 0, 0);
      ObjectSetInteger(0,"SL",OBJPROP_COLOR,clrRed);
   }
   
   double slPrice = ObjectGet("SL", OBJPROP_PRICE1);   
   double slPips = 0;
   
   double tpPips = 0;
   double tpPrice = 0;
   int tpIsSLTimes = 3;
   
   if (isBull) {
                        
         slPips = Bid - slPrice;
         tpPrice = Bid + (slPips * tpIsSLTimes);
   }
   else {
   
         slPips = slPrice - Bid;
         tpPrice = Bid - (slPips * tpIsSLTimes);
   }
   
   ObjectCreate("TP", OBJ_HLINE, 0, Time[0], tpPrice, 0, 0);
   ObjectSetInteger(0,"TP",OBJPROP_COLOR,clrGreen);     
}



void OnStart()
  {   
      ObjectDelete(0, "TP");
      ObjectDelete(0, "SL");
      
      double mySpread = Ask-Bid;
      int pipsNumber = 8;
      
      int intResult = MessageBox("Buy - " + Symbol(), "Trade Type", MB_YESNOCANCEL);
      
      
      if(intResult == 6) {
         
            drawSL(mySpread, True, pipsNumber);
            
      }
      else if(intResult == 7) {
      
            drawSL(mySpread, False, pipsNumber);
      }  
   
} 
//+------------------------------------------------------------------+
*/