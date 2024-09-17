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

//+ --- SETTINGS --------
double ORDERS_RISK_PERCENTAGE = 1;
double PIP_VALUE_PER_LOT = 10; //-> 1 LOT = $100.000 / 1 PIP = 0.0001 / VALUE PER PIP = 100.000 * 0.0001 = 10
//+----------------------
double AMOUNT_RISKED = 0;
double ORDER_RISKED_PIPS = 0;

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

int getMultiplier() {
   
   string multiplier = "1";
      
      for(int i=1; i < Digits; i++) {
         
         multiplier = multiplier + "0";
      }
     
   return StrToInteger(multiplier);
}

double  getLots() {
   
   double LOTS = AMOUNT_RISKED/ORDER_RISKED_PIPS;
   LOTS = LOTS / PIP_VALUE_PER_LOT;
   
   return LOTS;
}


void OnStart()
  {   
      Management TradeManagement = Management();
      Orders NewOrder = Orders();
      
      if(STOP_RISK_BID_PRICE < Bid) {
         
         ORDER_OPERATION = OP_BUY;
         ORDER_OPEN_PRICE = Ask;
      }
      else {
         
         ORDER_OPERATION = OP_SELL;
         ORDER_OPEN_PRICE = Bid;
      }
      
      ORDER_PROFIT_PRICE = TAKE_PROFIT_BID_PRICE;
      ORDER_RISK_PRICE = STOP_RISK_BID_PRICE;
         
      AMOUNT_RISKED = (AccountEquity()*(ORDERS_RISK_PERCENTAGE/100)); 
      ORDER_RISKED_PIPS = STOP_RISK_PIPS*getMultiplier();
      ORDER_LOTS =  getLots();
      
      
      NewOrder.PlaceOrder();
           
  }
//+------------------------------------------------------------------+
