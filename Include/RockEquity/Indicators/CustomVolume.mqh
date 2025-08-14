//+------------------------------------------------------------------+
//|                                                 CustomVolume.mqh |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\\Constants.mqh"

class CustomVolume
  {
private:

public:
   
   CustomVolume();
   ~CustomVolume();
   
   void PlotCustomVolume() {
  
      
      ChartTimePriceToXY(0,0,TimeCurrent(),Bid,x,y);
      
      long right = ChartGetInteger(0,CHART_WIDTH_IN_PIXELS);
      long up = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);
      
      double averageVolume = 0;
      long currentVolume = iVolume(Symbol(),Period(),1);
            
      for(int i=2; i < timeframe; i++) {
      
         averageVolume = averageVolume + iVolume(Symbol(),Period(),i);
      }
      
      averageVolume = averageVolume/(timeframe-2);
            
      double volumeRate = (currentVolume / averageVolume)*100;
      volumeRate = NormalizeDouble(volumeRate, 0);
            
      ObjectDelete(0,"CustomVolume");
      ObjectCreate(0,"CustomVolume",OBJ_LABEL,0,0,0);   
      ObjectSet("CustomVolume", OBJPROP_XDISTANCE, right-setx);
      ObjectSet("CustomVolume", OBJPROP_YDISTANCE, up-sety);
      ObjectSetText("CustomVolume", DoubleToString(volumeRate) + "%", font, "Arial", clrCornflowerBlue);
   
   }
   
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CustomVolume::CustomVolume()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CustomVolume::~CustomVolume()
  {
  }
//+------------------------------------------------------------------+
