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
int STANDARD_LOT_SIZE = 1;

double DECIMALS = 0.0001;
double MULTIPLIER = 10000;

void OnStart()
  { 
      
/*      
 

double PositionSize = (tradePipValue * STANDARD_LOT_SIZE)/currentPipValue;

ORDER_LOTS = PositionSize;
*/
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
      
      // El 10 = 100.000 * 0.0001
      double PipValue = (STANDARD_LOT_VALUE*DECIMALS)/ORDER_OPEN_PRICE;
      
      double AmountRisked = AccountBalance() * ORDERS_RISK_PERCENTAGE;
      double RiskPipValue = AmountRisked / RISKED_PIPS;
      
      
      ORDER_LOTS = RiskPipValue/PipValue;
      
      
      NewOrder.PlaceOrder(); 
      
      /*
      string mensae = "Open Price: " + ORDER_OPEN_PRICE + "\n" + 
                      "Stop Loss: " + ORDER_RISK_PRICE + "\n" + 
                      "Spread: " + DoubleToStr(Ask-Bid) + "\n" + 
                      "\n" +
                      "Pips Loss: " + RISKED_PIPS + "\n" +
                      "Risk Pip Value: " + RiskPipValue + "\n" +
                      "\n" +
                      "Pip Market Value: " + PipValue + "\n" +
                      "\n" +
                      "Position: " + DoubleToStr(ORDER_LOTS);          
      MessageBox(mensae);
      

      //double PipValue = (STANDARD_LOT_SIZE*0.0001)/ORDER_OPEN_PRICE;
            //ORDER_LOTS = AmountRisked / (RiskPipValue*PipValue);
      //double p = (STANDARD_LOT_VALUE * ORDER_OPEN_PRICE)*DECIMALS;
      //double asd = RiskPipValue
      
            //double PipValue1 = (STANDARD_LOT_SIZE*STANDARD_LOT_VALUE)*(DECIMALS / ORDER_OPEN_PRICE);
      //double PipValue2 = (ORDER_OPEN_PRICE * STANDARD_LOT_VALUE * DECIMALS)/RISKED_PIPS;
      //double  PipValue = (DECIMALS*STANDARD_LOT_VALUE)/ORDER_OPEN_PRICE;
      //double PipValue = (ORDER_OPEN_PRICE * RISKED_PIPS)*0.001;
      //MessageBox(DoubleToString(PipValue1) + "--" + DoubleToString(PipValue));
      
      //double  PipValue = (DECIMALS*STANDARD_LOT_VALUE)/ORDER_OPEN_PRICE;
      
      
      
      ORDER_LOTS = (RiskPipValue * STANDARD_LOT_SIZE)/PipValue;
      
      
      //MessageBox(DoubleToString((RiskPipValue*RISKED_PIPS)) + " --- " +  DoubleToString(ORDER_LOTS));
      
      
      //
      */

   
}

/*
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
*/