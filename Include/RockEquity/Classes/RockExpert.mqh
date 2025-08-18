//+------------------------------------------------------------------+
//|                                                   RockExpert.mqh |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property library

#include "..\Utils.mqh"
#include "..\Constants.mqh"

class RockExpert
  {
private:

public:
               RockExpert();
              ~RockExpert();                   
   
   static bool isNewCandle() {

      bool newCandle = false;
      
      if(CANDLES_COUNT < Bars) {
         
         newCandle = true;
         CANDLES_COUNT = Bars;
      }
      
      return newCandle;
   }
      
   static void setLTFColors() {
   
      if(ChartPeriod() == LTF) {
      
         ChartSetInteger(ChartID(), CHART_COLOR_CANDLE_BULL, CANDLE_BULL_LTF_BODY_COLOR);
         ChartSetInteger(ChartID(), CHART_COLOR_CANDLE_BEAR, CANDLE_BEAR_LTF_BODY_COLOR);
         
         ChartSetInteger(ChartID(), CHART_COLOR_CHART_UP, CANDLE_BULL_LTF_WICK_COLOR);
         ChartSetInteger(ChartID(), CHART_COLOR_CHART_DOWN, CANDLE_BEAR_LTF_WICK_COLOR);
      }
      else {
         
         ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, CANDLE_BULL_HTF_BODY_COLOR);
         ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, CANDLE_BEAR_HTF_BODY_COLOR);
         
         ChartSetInteger(0, CHART_COLOR_CHART_UP, CANDLE_BULL_HTF_WICK_COLOR);
         ChartSetInteger(0, CHART_COLOR_CHART_DOWN, CANDLE_BEAR_HTF_WICK_COLOR);
      }
   }
   
   
   
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
RockExpert::RockExpert()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
RockExpert::~RockExpert()
  {
  }
//+------------------------------------------------------------------+
