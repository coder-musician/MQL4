//+------------------------------------------------------------------+
//|                                          Orders - PlaceOrder.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

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
      //Management management = Management();      
      Orders NewOrder = Orders();
      
      double RISKED_PIPS = 0;
      
      ORDER_PROFIT_PRICE = NormalizeDouble(ObjectGet("TP_BID", 1),Digits); 
      ORDER_RISK_PRICE = NormalizeDouble(ObjectGet("SL_BID", 1),Digits);
      
      
      if(ORDER_RISK_PRICE < Bid) {
         
         ORDER_OPERATION = OP_BUY;
         ORDER_OPEN_PRICE = Ask;         
         
         RISKED_PIPS = (ORDER_OPEN_PRICE - ORDER_RISK_PRICE);
      }
      else {
         
         ORDER_OPERATION = OP_SELL;
         ORDER_OPEN_PRICE = Bid;
         
         RISKED_PIPS = (ORDER_RISK_PRICE - ORDER_OPEN_PRICE);
         
      }
      
      RISKED_PIPS = ((RISKED_PIPS+(Ask-Bid))*MULTIPLIER);
      
      double MarketPipValue = (STANDARD_LOT_VALUE*DECIMALS)/ORDER_OPEN_PRICE;
      
      double AmountRisked = AccountBalance() * ORDERS_RISK_PERCENTAGE;
      double RiskPipValue = AmountRisked / RISKED_PIPS;
      
      
      ORDER_LOTS = RiskPipValue/MarketPipValue;
      
      int newOrder = OrderSend(Symbol(), ORDER_OPERATION, ORDER_LOTS, ORDER_OPEN_PRICE, 0, 
         ORDER_RISK_PRICE, ORDER_PROFIT_PRICE, DoubleToStr(ORDER_RISK_PRICE));
      
      if(newOrder != -1) {
      
         bool NewLine = ObjectCreate("OPEN_PRICE", OBJ_HLINE, 0, Time[0], ORDER_OPEN_PRICE, 0, 0);
         ObjectSetInteger(0,"OPEN_PRICE",OBJPROP_COLOR,clrSienna);
      } 
      else {
      
         string summary = "ORDER_TICKET: " + IntegerToString(ORDER_TICKET) + "\n" +
            "ORDER_OPEN_PRICE: " + DoubleToString(ORDER_OPEN_PRICE) + "\n" +
            "ORDER_PROFIT_PRICE: " + DoubleToString(ORDER_PROFIT_PRICE) + "\n" +
            "ORDER_RISK_PRICE: " + DoubleToString(ORDER_RISK_PRICE) + "\n" +
            "ORDER_LOTS: " + DoubleToString(ORDER_LOTS) + "\n" + 
            "AMOUNT_RISKED: " + DoubleToString(ORDER_LOTS) + "\n" +
            "ERROR: " + IntegerToString(GetLastError()) + "\n";
            
         MessageBox(summary);
   }
}

