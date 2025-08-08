//+------------------------------------------------------------------+
//|                                                 Candlesticks.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

   string candles[3] = {"CANDLE0", "CANDLE1", "CANDLE2"};
   int offsetx[3] = {20, 27, 34};
   
   int fontSize = 27;
   int offsety = 40;


class Candlesticks
  {
private:

   void DeleteCandleDots() {
   
      for(int i=0; i<ArrayRange(candles,0); i++){
   
         ObjectDelete(0,candles[i]);
   
      }
   }
     
   void PlotCandlesDots() {
   
      int x;
      int y;
      
      ChartTimePriceToXY(0,0,TimeCurrent(),Bid,x,y);
   
      long right = ChartGetInteger(0,CHART_WIDTH_IN_PIXELS);
      long up = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);
   
      DeleteCandleDots();
   
      for(int i=0; i<ArrayRange(candles,0); i++) {
   
         ObjectCreate(0,candles[i],OBJ_LABEL,0,0,0);
         ObjectSet(candles[i], OBJPROP_XDISTANCE, right-offsetx[i]);
         ObjectSet(candles[i], OBJPROP_YDISTANCE, y-offsety);
         ObjectSetText(candles[i], ".", fontSize, "Arial", clrWhite);
   
      }
   }

public:

   Candlesticks();
  ~Candlesticks();
  
  void UpdateCandlesIndicator()
  {
     
      DeleteCandleDots();
      PlotCandlesDots();
   
      for(int j=1; j <= ArraySize(candles); j++) {
   
   
         if(Open[j] < Close[j]) {
         
            if(Open[j-1] > Close[j])         
               ObjectSetText(candles[j-1], ".", fontSize, "Arial", clrGreen);
            else                     
               ObjectSetText(candles[j-1], ".", fontSize, "Arial", clrRed);
         }      
         else {
         
            if(Open[j] > Close[j]) {
      
               if(Open[j-1] > Close[j])
                  ObjectSetText(candles[j-1], ".", fontSize, "Arial", clrGreen);
               else
                 ObjectSetText(candles[j-1], ".", fontSize, "Arial", clrRed);
            }
            else {
   
               if(Open[j-1] > Close[j])
                 ObjectSetText(candles[j-1], ".", fontSize, "Arial", clrGreen);
               else
                 ObjectSetText(candles[j-1], ".", fontSize, "Arial", clrRed);
   
               ObjectSetText(candles[j], ".", fontSize, "Arial", clrYellow);
   
               if(Close[j+1] < Open[j])
                 ObjectSetText(candles[j+1], ".", fontSize, "Arial", clrGreen);
               else
                 ObjectSetText(candles[j+1], ".", fontSize, "Arial", clrRed);
   
               break;
            }
         }
   
         //- ENGULFING/TWEEZER?
   
         double x1pips;
         double x2pips;
   
         int x1type;
         int x2type;
   
         if(Open[j+1] < Close[j+1]) {
   
            x2pips = Close[j+1] - Open[j+1]; //[x]Bull
            x2type = OP_BUY;   
         }
         else {
   
            x2pips = Open[j+1]-Close[j+1]; // [x]Bear
            x2type = OP_SELL;
         }
         
         if(Open[j] < Close[j]) {
   
            x1pips = Close[j]-Open[j]; //[x]Bull
            x1type = OP_BUY;
         }
         else {
   
            x1pips = Open[j]-Close[j]; // [x]Bear
            x1type = OP_SELL;
         }
           
   
         if((x2type - x1type) != 0) {
            
            /*
            if(x2pips < x1pips)
              {
                  //Engulfing
                  //ObjectSetText(candles[j], ".", fontSize, "Arial", clrWhite);
                  //ObjectSetText(candles[j+1], ".", fontSize, "Arial", clrWhite);
              }
            */  
            
            if(Close [2] == Open[1]) {
               //Tweezer
               ObjectSetText(candles[j], ".", fontSize, "Arial", clrYellow);
               ObjectSetText(candles[j+1], ".", fontSize, "Arial", clrYellow);
            } 
         }
      }
   }
  
  
  
  
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Candlesticks::Candlesticks()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Candlesticks::~Candlesticks()
  {
  }
//+------------------------------------------------------------------+
