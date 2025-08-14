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
#include "..\Include\Custom\Analytics.mqh"

#include "..\Include\Custom\Indicators\Candlesticks.mqh"
#include "..\Include\Custom\Indicators\CustomVolume.mqh"

#include "..\Include\Custom\Utils\Utils.mqh"

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
   
   void setHFTColors() {

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
      
      Analytics analytics = Analytics();
      
      Candlesticks candlesticks = Candlesticks();
      candlesticks.UpdateCandlesIndicator();
      
      CustomVolume customVolume = CustomVolume();
      customVolume.PlotCustomVolume();
      
      Utils utils = Utils();
      
      setHFTColors();
      
      bool areOrdersActive = orders.checkForActiveOrders(Symbol());
      
      if(!areOrdersActive) {
         
         if(ChartPeriod() != HTF)  
            management.UpdateTakeProfit(NormalizeDouble(ObjectGet("SL_BID", 1),Digits));  
         
         if(IS_ORDER_ACTIVE) {
            
            IS_ORDER_ACTIVE = False;
            
            string tradeDetails = ORDER_DATE + "," + 
            ORDER_TIME + "," + 
            Symbol() + "," + 
            DoubleToString(ORDER_OPERATION) + "," + 
            DoubleToString(ORDER_TICKET) + "," + 
            DoubleToString(ORDER_OPEN_PRICE) + "," +
            DoubleToString(ORDER_PROFIT_PRICE) + "," +  
            DoubleToString(OrderTakeProfit()) + "," +
            DoubleToString(ORDER_RISK_PRICE) + "," + 
            DoubleToString(OrderStopLoss()) + "," + 
            DoubleToString(OrderProfit());
            
            if(ChartPeriod() != HTF) {
               
               journal.CloseSnapshot(ChartID(),ORDERS_LIST[0]);
               analytics.writeTradeDetails(tradeDetails);
            }
               
            management.DeleteLevels();
         }

         if(isNewCandle())
         
            if(ChartPeriod() != HTF)            
               journal.MarketSnapshot(ChartID());
      }
      else {
         
         if(!IS_ORDER_ACTIVE) {
         
            string date = utils.GetDate();
            string time = utils.GetTime();            
            
            IS_ORDER_ACTIVE = True;
            
            ORDER_TICKET = OrderTicket();
            ORDER_DATE = date;
            ORDER_TIME = time;
            ORDER_OPEN_PRICE = OrderOpenPrice();
            ORDER_PROFIT_PRICE = OrderTakeProfit();
            ORDER_RISK_PRICE = OrderStopLoss();
            
            if(ChartPeriod() != HTF)
               journal.OpenSnapshot(ChartID(),ORDERS_LIST[0]);
         }
         
         if(isNewCandle())
         
            journal.TradeSnapshot(ChartID(),ORDERS_LIST[0]);
            management.LoadValues();    
            
            if((STOP_RISK_BID_PRICE < Bid && (STOP_RISK_BID_PRICE < ORDER_RISK_PRICE)) ||  
            (STOP_RISK_BID_PRICE > Bid && (STOP_RISK_BID_PRICE > ORDER_RISK_PRICE))) 
               management.MoveLevels(OrderTakeProfit(), ORDER_RISK_PRICE);
            
            if(STOP_RISK_BID_PRICE != 0 && TAKE_PROFIT_BID_PRICE != 0)
            
               if(OrderTakeProfit() != TAKE_PROFIT_BID_PRICE || OrderStopLoss() != STOP_RISK_BID_PRICE) {
                  orders.UpdateOrder(ORDERS_LIST[0], STOP_RISK_BID_PRICE, TAKE_PROFIT_BID_PRICE);
            } 
            else {
               
               management.DeleteLevels();
               
               if(ChartPeriod() != HTF)  
                  management.PlotLevels(OrderOpenPrice(), OrderTakeProfit(), OrderStopLoss());            
            }
            
            management.AdjustAskLines(TAKE_PROFIT_BID_PRICE, STOP_RISK_BID_PRICE);
         }
  }
  

//+------------------------------------------------------------------+
      