//+------------------------------------------------------------------+
//|                                                 CustomVolume.mqh |
//|                                  CopyRight 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
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
   
   void PlotCustomVolume(long ChartId) {
      
      int X_Cordinate;
      int Y_Cordinate;
      
      ChartTimePriceToXY(0,0,TimeCurrent(),Bid, X_Cordinate, Y_Cordinate);
      
      long RightWidth = ChartGetInteger(ChartId, CHART_WIDTH_IN_PIXELS);
      long HeigthWidth = ChartGetInteger(ChartId, CHART_HEIGHT_IN_PIXELS);
      
      double AverageVolume = 0;
      long CurrentVolume = iVolume(Symbol(),Period(),1);
            
      for(int i=2; i < BARS_INCLUDED; i++) {
      
         AverageVolume = AverageVolume + iVolume(Symbol(),Period(),i);
      }
      
      AverageVolume = AverageVolume/(BARS_INCLUDED - 2);
            
      double VolumeRate = (CurrentVolume / AverageVolume)*100;
      VolumeRate = NormalizeDouble(VolumeRate, 0);
            
      ObjectDelete(0,"CustomVolume");
      ObjectCreate(0,"CustomVolume",OBJ_LABEL,0,0,0);   
      ObjectSet("CustomVolume", OBJPROP_XDISTANCE, RightWidth - X_POSITION);
      ObjectSet("CustomVolume", OBJPROP_YDISTANCE, HeigthWidth - Y_POSITION);
      ObjectSetText("CustomVolume", DoubleToString(VolumeRate) + "%", VOLUMES_FONT_SIZE, "Arial", VOLUMES_FONT_COLOR);
   
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
