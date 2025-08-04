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

int HTF = 240;
  
void OnStart()
  {   
      
      if(ChartPeriod() != HTF) {
      
         ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, clrAqua);
         ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, clrRed);
         
         ChartSetInteger(0, CHART_COLOR_CHART_UP, clrBlack);
         ChartSetInteger(0, CHART_COLOR_CHART_DOWN, clrBlack);
      }
      else {
         
         ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, clrLimeGreen);
         ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, clrCrimson);
         
         ChartSetInteger(0, CHART_COLOR_CHART_UP, clrGreen);
         ChartSetInteger(0, CHART_COLOR_CHART_DOWN, clrMaroon);
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