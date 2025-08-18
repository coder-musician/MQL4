//+------------------------------------------------------------------+
//|                                                         test.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\\Include\\RockEquity\\Constants.mqh";
#include "..\\Include\\RockEquity\\Utils.mqh";

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//--- 
      Utils::DeleteLevels();
      SPREAD = Ask-Bid;      
      double STOP_RISK_PIPS = 5;
      
      ORDER_OPERATION = OP_BUY;
      
      STOP_RISK_PIPS = (SPREAD*STOP_RISK_PIPS);       
      
      STOP_RISK_BID_PRICE = Ask - STOP_RISK_PIPS;     
      STOP_RISK_ASK_PRICE = STOP_RISK_BID_PRICE + SPREAD;
         
      TAKE_PROFIT_BID_PRICE = Bid + (STOP_RISK_PIPS*RISK_REWARD_RATIO);
      TAKE_PROFIT_ASK_PRICE = TAKE_PROFIT_BID_PRICE + SPREAD;
      
      Utils::PlotLine("SL_BID", STOP_RISK_BID_PRICE, SR_BID_LINE_COLOR);
      Utils::PlotLine("TP_BID", TAKE_PROFIT_BID_PRICE, TP_BID_LINE_COLOR);
      
      /*
      if(Bid > STOP_RISK_BID_PRICE) {
         
         ORDER_OPERATION = OP_BUY;
         
         STOP_RISK_BID_PRICE = Ask - STOP_RISK_PIPS;     
         STOP_RISK_ASK_PRICE = STOP_RISK_BID_PRICE + SPREAD;
         
         TAKE_PROFIT_BID_PRICE = Bid + (STOP_RISK_PIPS*RISK_REWARD_RATIO);
      }
      else {
         
         ORDER_OPERATION = OP_SELL;
         TAKE_PROFIT_BID_PRICE = Bid + (STOP_RISK_PIPS*RISK_REWARD_RATIO);
         TAKE_PROFIT_ASK_PRICE = TAKE_PROFIT_BID_PRICE + SPREAD;
      }*/
   
  }
//+------------------------------------------------------------------+
