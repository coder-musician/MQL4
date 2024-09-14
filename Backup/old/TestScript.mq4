//+------------------------------------------------------------------+
//|                                                         Test.mq4 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include "classes\JOrders.mqh"
#include "classes\JCharts.mqh"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

JOrders myOrder;
JCharts myChart;

string INDICATOR_CANDLEOPEN_NAME = "Candle1";

string dpSRNames[7] = {"DPP","DS1","DR1","DS2","DR2","DS3","DR3"};
double dpSRVal[7];

string dpSMedNames[6] = {"DMO","DM1","DM2","DM3","DM4","DM5"};
double dpMedVal[6];

string wpSRNames[7] = {"WPP","WS1","WR1","WS2","WR2","WS3","WR3"};
double wpSRVal[7];

string wpSMedNames[6] = {"WM0","WM1","WM2","WM3","WM4","WM5"};
double wpMedVal[6];


void plotTradeLines() {

   ObjectCreate("Pending", OBJ_HLINE, 0, Time[0], Bid+(ORDERS_SPREAD*12), 0, 0);
   ObjectSetInteger(0,"Pending",OBJPROP_COLOR,clrAqua); 

   ObjectCreate("SL", OBJ_HLINE, 0, Time[0], Bid+(ORDERS_SPREAD*8), 0, 0);
   ObjectSetInteger(0,"SL",OBJPROP_COLOR,clrRed);
   
   ObjectCreate("Price", OBJ_HLINE, 0, Time[0], Bid, 0, 0);
   ObjectSetInteger(0,"Price",OBJPROP_COLOR,clrBlue);     
   
   ObjectCreate("TP", OBJ_HLINE, 0, Time[0], Bid-(ORDERS_SPREAD*8), 0, 0);
   ObjectSetInteger(0,"TP",OBJPROP_COLOR,clrGreen);
}

void plotMinPrice() {

   if(ORDERS_PRICE_SL_BID == 0) {
      
      plotTradeLines();
   }
   //--- SELL (default)
   double totalPips = ORDERS_PRICE_SL_ASK - ORDERS_PRICE_TP_ASK;
   double tradeFraction = totalPips/4;
   double minumPrice = ORDERS_PRICE_SL_ASK-tradeFraction; //SELL --> ALL LINES ARE DRAWN USING BID - NO CHANGES ON PRICE LINE
   double pendingPrice = ORDERS_PRICE_SL_ASK+tradeFraction;
                                                          
   // <-- Change values to BUY if required
   if(ORDERS_PRICE_SL_ASK < Bid) {
   
      totalPips = ORDERS_PRICE_TP_BID - ORDERS_PRICE_SL_BID;
      tradeFraction = totalPips/4;
      minumPrice = ORDERS_PRICE_SL_BID+tradeFraction-ORDERS_SPREAD; //BUY --> DRAW PRICE LINE USING ASK
      pendingPrice = ORDERS_PRICE_SL_BID-tradeFraction;
   }
   
   ObjectSet("Price",OBJPROP_PRICE1,minumPrice);
   ObjectSet("Pending",OBJPROP_PRICE1,pendingPrice);
}

void deleteTradeLines() {

   ObjectDelete(0, "Price");
   ObjectDelete(0, "TP");
   ObjectDelete(0, "SL");
   ObjectDelete(0, "Pending");
}

void candleOpenUpdate(long chartID) { //--PRIVATE

   if(ObjectFind(chartID,INDICATOR_CANDLEOPEN_NAME) == -1) {
      
      bool result = ObjectCreate(chartID,INDICATOR_CANDLEOPEN_NAME,OBJ_TEXT,0,Time[0],Low[0]);
      result = ObjectSetText(INDICATOR_CANDLEOPEN_NAME,"0",8,"Arial Black",clrGray);
   }
  
   ObjectMove(chartID,INDICATOR_CANDLEOPEN_NAME,0,Time[0],Low[0]);
    
   if(Open[0] > Close[1]) {     
   
      ObjectSetInteger(chartID,INDICATOR_CANDLEOPEN_NAME,OBJPROP_COLOR,clrGreen);
   
   }else if (Open[0] == Close[1]) {
   
      ObjectSetInteger(chartID,INDICATOR_CANDLEOPEN_NAME,OBJPROP_COLOR,clrGray);
   
   }else if(Open[0] < Close[1]){
   
      ObjectSetInteger(chartID,INDICATOR_CANDLEOPEN_NAME,OBJPROP_COLOR,clrRed);
   }
}

void drawDSR() {
   
   for(int i=0;i<=6;i++) {
   
      dpSRVal[i] = iCustom(CHART_SYMBOL,PERIOD_M5,"Pivots_Daily",0,i,0);
      ObjectCreate(dpSRNames[i], OBJ_HLINE, 0, Time[0], dpSRVal[i], 0, 0);
      ObjectSetInteger(CHART_ID_LTF,dpSRNames[i],OBJPROP_COLOR,clrOlive);
      ObjectSetInteger(CHART_ID_LTF,dpSRNames[i],OBJPROP_STYLE,STYLE_DOT);
      ObjectSetInteger(CHART_ID_LTF,dpSRNames[i],OBJPROP_TIMEFRAMES,getObjectPeriod(CHART_PERIOD_LTF)|getObjectPeriod(CHART_PERIOD_HTF));
   }
}

void deleteDSR() {
   
   for(int i=0;i<=6;i++) {
   
      deletePivot(dpSRNames[i]);
      Alert(CHART_ID_LTF);
   }
}


   
   
      
      /*
      dpSRVal[0] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily",0,0,0);//DP
      dpSRVal[1] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily",0,1,0);//S1
      dpSRVal[2] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily",0,2,0);//R1
      dpSRVal[3] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily",0,3,0);//S2
      dpSRVal[4] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily",0,4,0);//R2
      dpSRVal[5] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily",0,5,0);//S3
      dpSRVal[6] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily",0,6,0);//R3
      
      dpMedVal[0] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily_Medians",0,0,0);
      dpMedVal[1] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily_Medians",0,1,0);
      dpMedVal[2] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily_Medians",0,2,0);
      dpMedVal[3] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily_Medians",0,3,0);
      dpMedVal[4] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily_Medians",0,4,0);
      dpMedVal[5] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily_Medians",0,5,0);
      dpMedVal[6] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily_Medians",0,6,0);
      */
   /*
   wpSRVal[0] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Weekly",0,3,0);
   wpSRVal[1] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Weekly",0,4,0);
   wpSRVal[2] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Weekly",0,2,0);
   wpSRVal[3] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Weekly",0,5,0);
   wpSRVal[4] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Weekly",0,1,0);
   wpSRVal[5] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Weekly",0,6,0);
   wpSRVal[6] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Weekly",0,0,0);
   
   wpMedVal[5] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Weekly_Medians",0,0,0);
   wpMedVal[4] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Weekly_Medians",0,1,0);
   wpMedVal[3] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Weekly_Medians",0,2,0);
   wpMedVal[2] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Weekly_Medians",0,3,0);
   wpMedVal[1] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Weekly_Medians",0,4,0);
   wpMedVal[0] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Weekly_Medians",0,5,0);
   */


void plotDailyPivots() {
   /*
   for(int i=0; i>=6;i++){
   
      ObjectCreate(dpSRNames[i], OBJ_HLINE, 0, Time[0], dpSRVal[i], 0, 0);
      ObjectSetInteger(CHART_ID_LTF,dpSRNames[i],OBJPROP_COLOR,clrOlive);
      ObjectSetInteger(CHART_ID_LTF,dpSRNames[i],OBJPROP_STYLE,STYLE_DOT);
      ObjectSetInteger(CHART_ID_LTF,dpSRNames[i],OBJPROP_TIMEFRAMES,getObjectPeriod(CHART_PERIOD_LTF)|getObjectPeriod(CHART_PERIOD_HTF));
   }
   /*
   ObjectCreate(dpSRNames[0], OBJ_HLINE, 0, Time[0], dpSRVal[0], 0, 0);
   ObjectCreate(dpSRNames[1], OBJ_HLINE, 0, Time[0], dpSRVal[1], 0, 0);
   ObjectCreate(dpSRNames[2], OBJ_HLINE, 0, Time[0], dpSRVal[2], 0, 0);
   ObjectCreate(dpSRNames[3], OBJ_HLINE, 0, Time[0], dpSRVal[3], 0, 0);
   ObjectCreate(dpSRNames[4], OBJ_HLINE, 0, Time[0], dpSRVal[4], 0, 0);
   ObjectCreate(dpSRNames[5], OBJ_HLINE, 0, Time[0], dpSRVal[5], 0, 0);
   ObjectCreate(dpSRNames[6], OBJ_HLINE, 0, Time[0], dpSRVal[6], 0, 0);
   
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[0],OBJPROP_COLOR,clrOlive);
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[1],OBJPROP_COLOR,clrOlive);
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[2],OBJPROP_COLOR,clrOlive);
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[3],OBJPROP_COLOR,clrOlive);
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[4],OBJPROP_COLOR,clrOlive);
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[5],OBJPROP_COLOR,clrOlive);
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[6],OBJPROP_COLOR,clrOlive);
   
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[0],OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[1],OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[2],OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[3],OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[4],OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[5],OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[6],OBJPROP_STYLE,STYLE_DOT);   
   
   
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[0],OBJPROP_TIMEFRAMES,getObjectPeriod(CHART_PERIOD_LTF)|getObjectPeriod(CHART_PERIOD_HTF));
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[1],OBJPROP_TIMEFRAMES,getObjectPeriod(CHART_PERIOD_LTF)|getObjectPeriod(CHART_PERIOD_HTF));
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[2],OBJPROP_TIMEFRAMES,getObjectPeriod(CHART_PERIOD_LTF)|getObjectPeriod(CHART_PERIOD_HTF));
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[3],OBJPROP_TIMEFRAMES,getObjectPeriod(CHART_PERIOD_LTF)|getObjectPeriod(CHART_PERIOD_HTF));
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[4],OBJPROP_TIMEFRAMES,getObjectPeriod(CHART_PERIOD_LTF)|getObjectPeriod(CHART_PERIOD_HTF));
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[5],OBJPROP_TIMEFRAMES,getObjectPeriod(CHART_PERIOD_LTF)|getObjectPeriod(CHART_PERIOD_HTF));
   ObjectSetInteger(CHART_ID_LTF,dpSRNames[6],OBJPROP_TIMEFRAMES,getObjectPeriod(CHART_PERIOD_LTF)|getObjectPeriod(CHART_PERIOD_HTF));
   */
   
   ChartRedraw();   
}

void deletePivot(string name) {

   ObjectDelete(CHART_ID_LTF, name);
}

void OnStart()
  {      
      while(!IsExpertEnabled()){
      
         Comment("Please Enable Auto-Trading");
      }
      
      //deleteDailyPivots();
      
      //drawCustomDaily();
      deleteDSR();
      
      //ObjectSetInteger(0,"Pivots_Daily",OBJPROP_TIMEFRAMES,OBJ_PERIOD_M1);
      
      /* ObjectSetInteger(CHART_ID_LTF,dpSRNames[0],OBJPROP_TIMEFRAMES,getObjectPeriod(CHART_PERIOD_LTF)|getObjectPeriod(CHART_PERIOD_HTF));
      
      //dpSRVal[0] = iCustom(CHART_SYMBOL,PERIOD_H4,"Pivots_Daily",0,0,0);//DP
      
      //plotDailyPivots();
      //Alert(dpSRVal[1]);
      
      
      /*
      ObjectCreate(dpSRNames[0], OBJ_HLINE, 0, Time[0], dpSRVal[0], 0, 0);
      ObjectSetInteger(CHART_ID_LTF,dpSRNames[0],OBJPROP_COLOR,clrOlive);
      ObjectSetInteger(CHART_ID_LTF,dpSRNames[0],OBJPROP_STYLE,STYLE_DOT);
      ObjectSetInteger(CHART_ID_LTF,dpSRNames[0],OBJPROP_TIMEFRAMES,getObjectPeriod(CHART_PERIOD_LTF)|getObjectPeriod(CHART_PERIOD_HTF));
      ChartRedraw();
      */
      //{"DPP","DS1","DR1","DS2","DR2","DS3","DR3"};
  }
  
int getObjectPeriod(int period) {

   int objPeriod = 0;

   if(period == PERIOD_M1) objPeriod = OBJ_PERIOD_M1;
   if(period == PERIOD_M5) objPeriod = OBJ_PERIOD_M5;
   if(period == PERIOD_M15) objPeriod = OBJ_PERIOD_M15;
   if(period == PERIOD_M30) objPeriod = OBJ_PERIOD_M30;
   if(period == PERIOD_H1) objPeriod = OBJ_PERIOD_H1;
   if(period == PERIOD_H4) objPeriod = OBJ_PERIOD_H4;
   if(period == PERIOD_D1) objPeriod = OBJ_PERIOD_D1;
   if(period == PERIOD_W1) objPeriod = OBJ_PERIOD_W1;
   if(period == PERIOD_MN1) objPeriod = OBJ_PERIOD_M1;
   
   return objPeriod;   
}
  
//+------------------------------------------------------------------+
