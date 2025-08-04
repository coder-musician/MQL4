//+------------------------------------------------------------------+
//|                                          Orders - PlaceOrder.mq4 |
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

#include "..\Include\Custom\Orders.mqh"

int priceDecimals;
int standardLot = 100000;
double risk = 0.01;
string accountCurrency = "USD";

double NormalizePrice(double price) {

   string priceString = DoubleToStr(price);
   int priceStringLength = StringLen(priceString);
   int priceEntire = StringFind(priceString,".", 0) + 1;   
   priceDecimals = priceStringLength - priceEntire;
   
   if(priceDecimals == 5 || priceDecimals == 3) {
      
      priceDecimals--;
      priceString = StringSubstr(priceString,0, (priceEntire+priceDecimals));
   }
   
   return StringToDouble(priceString);
}

double valuePerPip() {
   
   string baseCurrency = StringSubstr(Symbol(), 0, 3);
   string singlePipString = "0.";
   
   for(int i=0; i < priceDecimals; i++) {
      
      if(i == (priceDecimals-1)) {
         
         singlePipString = singlePipString + "1";
      }
      else {
      
         singlePipString = singlePipString + "0";
      }
   }
   
   double pipValue = StringToDouble(singlePipString) / Bid;
   
   if(baseCurrency != accountCurrency) {
   
      pipValue = pipValue * ORDER_OPEN_PRICE;
   }
   
   return (pipValue*standardLot);
}

double getRiskedPips(double riskedPips) {

   string multiplier = "1";
   
   for(int i=1; i<=priceDecimals; i++) {
   
      multiplier = multiplier + "0";
   }
   
   return (riskedPips*StringToInteger(multiplier));
}
   
void OnStart()
  {   
      double accountBalance = 20034.51;
      double RISKED_PIPS = 0;
      
      ORDER_PROFIT_PRICE = NormalizePrice(NormalizeDouble(ObjectGet("TP_BID", 1),Digits)); 
      ORDER_RISK_PRICE = NormalizePrice(NormalizeDouble(ObjectGet("SL_BID", 1),Digits));
      
      if(ORDER_RISK_PRICE < Bid) {
         
         ORDER_OPERATION = OP_BUY;
         ORDER_OPEN_PRICE = NormalizePrice(Ask); 
         RISKED_PIPS =  ORDER_OPEN_PRICE - ORDER_RISK_PRICE;
      } 
      else {
         
         ORDER_OPERATION = OP_SELL;
         ORDER_OPEN_PRICE = NormalizePrice(Bid);
         RISKED_PIPS = ORDER_RISK_PRICE - ORDER_OPEN_PRICE;
      }
      
      RISKED_PIPS = getRiskedPips(RISKED_PIPS);
      
      double pipValue = valuePerPip();
      double riskedAmount = accountBalance * risk;
       
      ORDER_LOTS = (riskedAmount/pipValue)/RISKED_PIPS;
      
      int newOrder = OrderSend(Symbol(), ORDER_OPERATION, ORDER_LOTS, ORDER_OPEN_PRICE, 0, 
         ORDER_RISK_PRICE, ORDER_PROFIT_PRICE, DoubleToStr(ORDER_PROFIT_PRICE) + "," + DoubleToStr(ORDER_RISK_PRICE));
      
      if(newOrder != -1) {
      
         bool NewLine = ObjectCreate("OPEN_PRICE", OBJ_HLINE, 0, Time[0], ORDER_OPEN_PRICE, 0, 0);
         ObjectSetInteger(0,"OPEN_PRICE",OBJPROP_COLOR,clrSienna);
      } 
      else {
      
         string summary = "ORDER_TICKET: " + DoubleToStr(ORDER_TICKET) + "\n" +
            "ORDER_OPEN_PRICE: " + DoubleToStr(ORDER_OPEN_PRICE) + "\n" +
            "ORDER_PROFIT_PRICE: " + DoubleToStr(ORDER_PROFIT_PRICE) + "\n" +
            "ORDER_RISK_PRICE: " + DoubleToStr(ORDER_RISK_PRICE) + "\n" +
            "ORDER_LOTS: " + DoubleToStr(ORDER_LOTS) + "\n"+ 
            "AMOUNT_RISKED: " + DoubleToString(ORDER_LOTS) + "\n" +
            "ERROR: " + IntegerToString(GetLastError()) + "\n Enable Auto Trading";
            
         MessageBox(summary);
   }
      
  }