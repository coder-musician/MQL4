//+------------------------------------------------------------------+
//|                                                 Candlesticks.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\\Constants.mqh"

class Candlesticks
  {
private:

   static void DeleteCandleDots(long ChartId) {
   
      for(int i=0; i < ArrayRange(CANDLES_NAMES, 0); i++){
   
         ObjectDelete(ChartId, CANDLES_NAMES[i]);   
      }
   }
     
   static void PlotCandlesDots(long ChartId) {
   
      int X_Coordinate;
      int Y_Coordinate;
      
      ChartTimePriceToXY(ChartId, 0, TimeCurrent(), Bid, X_Coordinate, Y_Coordinate);
   
      long ChartWidth = ChartGetInteger(ChartId, CHART_WIDTH_IN_PIXELS);
   
      DeleteCandleDots(ChartId);
   
      for(int i=0; i < ArrayRange(CANDLES_NAMES, 0); i++) {
   
         ObjectCreate(ChartId, CANDLES_NAMES[i], OBJ_LABEL, 0,0,0);
         ObjectSet(CANDLES_NAMES[i], OBJPROP_XDISTANCE, ChartWidth - CANDLE_OFFSET_X[i]);
         ObjectSet(CANDLES_NAMES[i], OBJPROP_YDISTANCE, Y_Coordinate - CANDLE_OFFSET_Y);
         ObjectSetText(CANDLES_NAMES[i], ".", CANDLE_FONT_SIZE, "Arial", clrWhite);   
      }
   }

public:

   Candlesticks();
  ~Candlesticks();
  
  static void UpdateCandlesIndicator()
  {
     
      DeleteCandleDots(ChartID());
      PlotCandlesDots(ChartID());
   
      for(int j=1; j <= ArraySize(CANDLES_NAMES); j++) {
   
         if(Open[j] < Close[j]) {
         
            if(Open[j-1] > Close[j])         
               ObjectSetText(CANDLES_NAMES[j-1], ".", CANDLE_FONT_SIZE, "Arial", CANDLE_BULLISH_COLOR);
            
            else                     
               ObjectSetText(CANDLES_NAMES[j-1], ".", CANDLE_FONT_SIZE, "Arial", CANDLE_BEARISH_COLOR);
         }      
         else {
         
            if(Open[j] > Close[j]) {
      
               if(Open[j-1] > Close[j])
                  ObjectSetText(CANDLES_NAMES[j-1], ".", CANDLE_FONT_SIZE, "Arial", CANDLE_BULLISH_COLOR);
               
               else
                 ObjectSetText(CANDLES_NAMES[j-1], ".", CANDLE_FONT_SIZE, "Arial", CANDLE_BEARISH_COLOR);
                 
            } else {
            
               
               if(Open[j-1] > Close[j])
                 ObjectSetText(CANDLES_NAMES[j-1], ".", CANDLE_FONT_SIZE, "Arial", CANDLE_BULLISH_COLOR);
               
               else
                 ObjectSetText(CANDLES_NAMES[j-1], ".", CANDLE_FONT_SIZE, "Arial", CANDLE_BEARISH_COLOR);
   
               ObjectSetText(CANDLES_NAMES[j], ".", CANDLE_FONT_SIZE, "Arial", CANDLE_TWEEZER_COLOR);
   
               if(Close[j+1] < Open[j])
                 ObjectSetText(CANDLES_NAMES[j+1], ".", CANDLE_FONT_SIZE, "Arial", CANDLE_BULLISH_COLOR);
               
               else
                 ObjectSetText(CANDLES_NAMES[j+1], ".", CANDLE_FONT_SIZE, "Arial", CANDLE_BEARISH_COLOR);
   
               break;
            }
         }
   
         //- ENGULFING/TWEEZER?
   
         double X1_Pips;
         double X2_Pips;
   
         int X1_Operation;
         int X2_Operation;
   
         if(Open[j+1] < Close[j+1]) {
   
            X2_Pips = Close[j+1] - Open[j+1]; //[x]Bull
            X2_Operation = OP_BUY;   
         }
         else {
   
            X2_Pips = Open[j+1]-Close[j+1]; // [x]Bear
            X2_Operation = OP_SELL;
         }
         
         if(Open[j] < Close[j]) {
   
            X1_Pips = Close[j]-Open[j]; //[x]Bull
            X1_Operation = OP_BUY;
         }
         else {
   
            X1_Pips = Open[j]-Close[j]; // [x]Bear
            X1_Operation = OP_SELL;
         }
           
   
         if((X2_Operation - X1_Operation) != 0) {
            
            if(Close[2] == Open[1]) {
            
               //Tweezer
               ObjectSetText(CANDLES_NAMES[j], ".", CANDLE_FONT_SIZE, "Arial", CANDLE_TWEEZER_COLOR);
               ObjectSetText(CANDLES_NAMES[j+1], ".", CANDLE_FONT_SIZE, "Arial", CANDLE_TWEEZER_COLOR);
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
