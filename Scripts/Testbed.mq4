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
//|                                                                  |
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
         ORDER_RISK_PRICE, ORDER_PROFIT_PRICE, DoubleToStr(ORDER_RISK_PRICE));
      
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
  
//+------------------------------------------------------------------+

      /*
      ChartSetInteger(0, CHART_COLOR_CHART_DOWN, clrBlack);
      ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, clrLightSalmon);
      */
   /*
   
         //averageVolume = (averageVolume / (timeframe - 2);
      //double volumeRate = (currentVolume / averageVolume)*100;
      
      //MessageBox(averageVolume + " -- " + currentVolume + " -- " + volumeRate);
      
      /*
      int timeframe = 10; // last 10 bars
      int x;
      int y;
      
      int font = 9;
      int sety = 25;
      int setx = 34;   
      
      ChartTimePriceToXY(0,0,TimeCurrent(),Bid,x,y);
      
      long right = ChartGetInteger(0,CHART_WIDTH_IN_PIXELS);
      long up = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);
      
      long barCustomVolume = 0;
      
      for(int i=2; i < timeframe; i++) {
      
         barCustomVolume = barCustomVolume + iVolume(Symbol(),Period(),i);
      }
      
      long averageCustomVolume = barCustomVolume/timeframe;
      long currentCustomVolume = iVolume(Symbol(),Period(),1);   
      
      double test = (currentCustomVolume / averageCustomVolume)*100;// / averageCustomVolume;
      MessageBox(currentVolume
      
      
      ObjectDelete(0,"CustomVolume");
      ObjectCreate(0,"CustomVolume",OBJ_LABEL,0,0,0);   
      ObjectSet("CustomVolume", OBJPROP_XDISTANCE, right-setx);
      ObjectSet("CustomVolume", OBJPROP_YDISTANCE, up-sety);
      ObjectSetText("CustomVolume", IntegerToString(test) + "%", font, "Arial", clrCornflowerBlue);
      
      
      
      ------
   ChartTimePriceToXY(0,0,TimeCurrent(),Bid,x,offsety_v);
   
   ObjectDelete(0,"Volume");
   ObjectCreate(0,"Volume",OBJ_LABEL,0,0,0);
   ObjectSet("Volume", OBJPROP_XDISTANCE, offsetx_v);
   ObjectSet("Volume", OBJPROP_YDISTANCE, offsety_v + 200);
   ObjectSetText("Volume", test + "%", fontSize_v, "Arial", clrCornflowerBlue);
   */
   
   
   
   //MessageBox(x);
   
    
//--- 
      /*
      Candlesticks candlesticks = Candlesticks();
      candlesticks.UpdateCandlesIndicator();
      
      int x;
      int offsety_v;
      
      ChartTimePriceToXY(0,0,TimeCurrent(),Bid,x,offsety_v);
      offsetx_v = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS)-offsetx_v;
      
      int startHour = 7; // -> 7am
      int bars = Hour() - startHour;
      MessageBox(Hour());
      long current = iVolume(Symbol(),Period(),1);
      double average = 0;
      double ratio;
           
      
      for(int j=2; j <= bars; j++){
      
         average = average + iVolume(Symbol(),Period(),j);         
      }
      /*
      average = average / bars;
      ratio = (current / average)*100;
      
      ObjectDelete(0,"Volume");
      ObjectCreate(0,"Volume",OBJ_LABEL,0,0,0);
      ObjectSet("Volume", OBJPROP_XDISTANCE, offsetx_v);
      ObjectSet("Volume", OBJPROP_YDISTANCE, offsety_v);
      
          
      if(iVolume(Symbol(),Period(),3) < iVolume(Symbol(),Period(),2)  && 
         iVolume(Symbol(),Period(),2) < iVolume(Symbol(),Period(),1)) {
         
            ObjectSetText("Volume", "v." + DoubleToStr(ratio,0) + "%", fontSize_v, "Arial", clrCornflowerBlue);
            
            
      } else if(iVolume(Symbol(),Period(),3) > iVolume(Symbol(),Period(),2)  && 
         iVolume(Symbol(),Period(),2) > iVolume(Symbol(),Period(),1)) {
            
            ObjectSetText("Volume", "v." + DoubleToStr(ratio,0) + "%", fontSize_v, "Arial", clrHotPink);
      }
      else {
      
         ObjectSetText("Volume", "v." + DoubleToStr(ratio,0) + "%", fontSize_v, "Arial", clrGray);
      }
      */