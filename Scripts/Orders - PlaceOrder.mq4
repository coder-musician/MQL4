//+------------------------------------------------------------------+
//|                                          Orders - PlaceOrder.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\Include\Custom\Management.mqh"
#include "..\Include\Custom\Orders.mqh"


double ORDERS_RISK_PERCENTAGE = 0.01;
int STANDARD_LOT_VALUE = 100000;

double DECIMALS = 0.0001;
double MULTIPLIER = 10000;

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

void OnStart()
  { 
      
      Management TradeManagement = Management();
      Orders NewOrder = Orders();
      
      double RISKED_PIPS = 0;
      
      if(STOP_RISK_BID_PRICE < Bid) {
         
         ORDER_OPERATION = OP_BUY;
         ORDER_OPEN_PRICE = Ask;
         ORDER_PROFIT_PRICE = TAKE_PROFIT_BID_PRICE;
         ORDER_RISK_PRICE = STOP_RISK_BID_PRICE;
         
         RISKED_PIPS = (ORDER_OPEN_PRICE - ORDER_RISK_PRICE);
         
         
      }
      else {
         
         ORDER_OPERATION = OP_SELL;
         ORDER_OPEN_PRICE = Bid;
         ORDER_PROFIT_PRICE = TAKE_PROFIT_ASK_PRICE;
         ORDER_RISK_PRICE = STOP_RISK_ASK_PRICE;
         
         RISKED_PIPS = (ORDER_RISK_PRICE - ORDER_OPEN_PRICE);
      }
      
      RISKED_PIPS = ((RISKED_PIPS+(Ask-Bid))*MULTIPLIER);
      
      double MarketPipValue = (STANDARD_LOT_VALUE*DECIMALS)/ORDER_OPEN_PRICE;
      
      double AmountRisked = AccountBalance() * ORDERS_RISK_PERCENTAGE;
      double RiskPipValue = AmountRisked / RISKED_PIPS;
      
      
      ORDER_LOTS = RiskPipValue/MarketPipValue;
      
      ObjectSetString(0,"SL_BID", OBJPROP_TEXT, DoubleToString(ORDER_RISK_PRICE));
      NewOrder.PlaceOrder();       
}
