//+------------------------------------------------------------------+
//|                                                  Rock Equity.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\\Include\\RockEquity\\Classes\\RockExpert.mqh"
#include "..\\Include\\RockEquity\\Classes\\Orders.mqh"
#include "..\\Include\\RockEquity\\Classes\\Journal.mqh"
#include "..\\Include\\RockEquity\\Classes\\Analytics.mqh"
#include "..\\Include\\RockEquity\\Classes\\RockExpert.mqh"
//#include "..\\Include\\RockEquity\\Utils.mqh"
//#include "..\\Include\\RockEquity\\Constants.mqh"
//#include "..\\Include\\RockEquity\\Classes\\Management.mqh"


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
      RockExpert::SetLTFColors();
      
      if(RockExpert::IsNewCandle())
         Journal::MarketSnapshot(ChartID());
         
      ORDER_STOP_LOSS_PRICE = Management::GetLinePrice("SL");
      ORDER_OPERATION = OP_BUY;
      
      if(Bid < ORDER_STOP_LOSS_PRICE)
         ORDER_OPERATION = OP_SELL;
      
           
     if(Orders::PairHasActiveOrders(ChartSymbol())) {     
         
         Management::ReloadTradeLines(ChartID());
         
         if(!PAIR_HAS_ACTIVE_ORDERS) { // TRADE WAS JUST OPENED 
            
            PAIR_HAS_ACTIVE_ORDERS = True;                          
            Journal::OpenSnapshot(ChartID(), ORDER_TICKET);
            
         } else {
            
            if(RockExpert::IsNewCandle())
               Journal::TradeSnapshot(ChartID(), ORDER_TICKET);
         }
         
      } else {  
         
         if(PAIR_HAS_ACTIVE_ORDERS) { // TRADE WAS JUST CLOSED            
            
            PAIR_HAS_ACTIVE_ORDERS = False;
            Journal::CloseSnapshot(ChartID(), ORDER_TICKET);
            Analytics::WriteStats();
            Management::DeleteLevels(ChartID());
         
         } else
            Management::AdjustTakeProfit(ChartID()); 
      }
  }
  

//+------------------------------------------------------------------+
      
      
      
      
      