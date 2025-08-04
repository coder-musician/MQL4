//+------------------------------------------------------------------+
//|                                                  Rock Equity.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\Include\Custom\Management.mqh"
#include "..\Include\Custom\Orders.mqh"
#include "..\Include\Custom\Journal.mqh"

#include "..\Include\Custom\Indicators\Candlesticks.mqh"
#include "..\Include\Custom\Indicators\CustomVolume.mqh"

int HTF = 240;
int CANDLES_COUNT = Bars;


bool isNewCandle() {
   
   bool newCandle = false;
   
   if(CANDLES_COUNT < Bars) {
      
      newCandle = true;
      CANDLES_COUNT = Bars;
   }
   
   return newCandle;
}

void setHFTProperties() {

   if(ChartPeriod() != HTF) {
      
         ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, clrAqua);
         ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, clrRed);
         
         ChartSetInteger(0, CHART_COLOR_CHART_UP, clrTurquoise);
         ChartSetInteger(0, CHART_COLOR_CHART_DOWN, clrRed);
      }
      else {
         
         ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, clrLimeGreen);
         ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, clrCrimson);
         
         ChartSetInteger(0, CHART_COLOR_CHART_UP, clrGreen);
         ChartSetInteger(0, CHART_COLOR_CHART_DOWN, clrMaroon);
      }
}

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
      return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {         
      Management management = Management();
      Journal journal = Journal();
      
      Orders orders = Orders();
      orders.GetOrdersList();
      
      Candlesticks candlesticks = Candlesticks();
      candlesticks.UpdateCandlesIndicator();
      
      CustomVolume customVolume = CustomVolume();
      customVolume.PlotCustomVolume();
      
      setHFTProperties();
      
      bool areOrdersActive = orders.checkForActiveOrders(Symbol());
      
      if(!areOrdersActive) {
      
         management.UpdateTakeProfit(NormalizeDouble(ObjectGet("SL_BID", 1),Digits));  
         
         if(IS_ORDER_ACTIVE) {
            
            journal.CloseScreenshot(ORDERS_LIST[0]);
            IS_ORDER_ACTIVE = False;
            management.DeleteLevels();
         }
         
         if(isNewCandle())
            journal.MarketLTFScreenshot(ChartID());
      }
      else {
         
         if(!IS_ORDER_ACTIVE) {
         
            journal.OpenScreenshot(ORDERS_LIST[0]);
            IS_ORDER_ACTIVE = True;
         }
         
         if(isNewCandle())
            journal.TradeScreenshot(ORDERS_LIST[0]);
         
         management.LoadValues();
         
         string origTPSL[];         
         StringSplit(OrderComment(), ",", origTPSL);
         double origTP = StringToDouble(origTPSL[0]);
         double origSL = StringToDouble(origTPSL[1]);
          
         
         if((STOP_RISK_BID_PRICE < Bid && (STOP_RISK_BID_PRICE < origSL)) ||  
         (STOP_RISK_BID_PRICE > Bid && (STOP_RISK_BID_PRICE > origSL))) {
       
            management.MoveLevels(TAKE_PROFIT_BID_PRICE, origSL);
         }
         
         if(TAKE_PROFIT_BID_PRICE != 0 && STOP_RISK_BID_PRICE != 0) {
         
            orders.UpdateOrder(ORDERS_LIST[0], STOP_RISK_BID_PRICE, TAKE_PROFIT_BID_PRICE);
            
            if(GetLastError() == ERR_INVALID_STOPS) {
                        
               management.MoveLevels(OrderTakeProfit(), OrderStopLoss());
               management.AdjustAskLines(TAKE_PROFIT_BID_PRICE, STOP_RISK_BID_PRICE);
            }
         }
         else {
            
            management.DeleteLevels();
            management.PlotLevels(OrderOpenPrice(), OrderTakeProfit(), OrderStopLoss());            
         }
         
         management.AdjustAskLines(TAKE_PROFIT_BID_PRICE, STOP_RISK_BID_PRICE);
      }
  }
  

//+------------------------------------------------------------------+
      