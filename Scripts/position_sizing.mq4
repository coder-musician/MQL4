//+------------------------------------------------------------------+
//|                                              position_sizing.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

double ORDERS_RISK_PERCENTAGE = 0.01;
int STANDARD_LOT_VALUE = 100000;
int STANDARD_LOT_SIZE = 1;
double DECIMALS = 0.0001;
double PRICE = Bid;
double PIPS_RISKED = 27;

void OnStart()
  {
//--- 
      
      
      int CurrentOrderTicket = 0;
      bool IS_ORDER_ACTIVE = False;
      
      for(int i=0; i<OrdersTotal(); i++) {
      
         bool openOrder = OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
         
         if(openOrder && OrderSymbol() == Symbol()){
            
            CurrentOrderTicket = OrderTicket(); 
            break;
         }
      
      
      /*
      // 0.0001 = $79
      
      
      double actualPipValue = pipValue * AccountLeverage();
      double Lot = lotValue * actualPipValue;
      */
      
      
      //double actualRisk = 
      //double PipValueWithoutLeverage = actualLotValue/pipsRisked;
      
      //double RegulaPipValue = PipValueWithoutLeverage / AccountLeverage();
      
      //double pipValue = actualLotValue
      
      
      //
      //double actualLeveragedRisk = AmountRisked * AccountLeverage();
      
      //lot = actualLeveragedRisk/pipsRisked
      
      
      
      
      // 1 - 11163
      // 
      
      //double actualPipValue = actualLeveragedRisk/pipsRisked;
      
      
      
      //double LeveragedPipValue = LeveragedRisk / pipsRisked;
      
      //MessageBox(DoubleToString(LeveragedRisk) + " - " + DoubleToString(leveragedPIPValue));
      
      
      
      
      
      
      //double amountPerLot = 100000; 
      
           
      //double actualPipValue = Bid * pipValuePerStandardLot;
      
      //
      //double amountRiskedStandardLot = actualPipValue * pipsRisked;
      
      //double AmountRisked = AccountBalance() * ORDERS_RISK_PERCENTAGE;
      
      
      
      // 1 - actualPipValue
      //     750
      
           
      //double pipValue = AmountPerLot/pipsRisked;
       
      
      
      // 1 lot  -  111.000 - 1 pip 
      // ?  -  Amount Risked
         
      
      
  }
//+------------------------------------------------------------------+
