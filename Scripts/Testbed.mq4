//+------------------------------------------------------------------+
//|                                                      Testbed.mq4 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\\Include\\RockEquity\\Classes\\Orders.mqh";
#include "..\\Include\\RockEquity\\Classes\\Management.mqh";
#include "..\\Include\\RockEquity\\Utils.mqh";
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

string PairSymbol = ChartSymbol();

void OnStart()
  {
      bool IsOrderLoaded = False;
      bool IsOrderActive = False;
  
      for(int i=0; i < OrdersTotal(); i++) {
   
         IsOrderLoaded = OrderSelect(i, SELECT_BY_POS);
      
         if(OrderSymbol() != PairSymbol)
            continue;
         
         Alert(OrderTicket() + " - " + OrderSymbol() + " - " + OrderCloseTime());
         
         IsOrderActive = True;
         break;
      }   
 }
   /*
      
      for (int i = OrdersTotal() - 1; i >= 0; i--)
    {
        Alert(OrderSymbol());
    }
   */   
  
           
//+------------------------------------------------------------------+