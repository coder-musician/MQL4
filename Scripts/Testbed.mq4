//+------------------------------------------------------------------+
//|                                                      Testbed.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

   string GetDate() {
      
      string year = IntegerToString(Year());
      string month = IntegerToString(Month());
      string day = IntegerToString(Day());
      
      if(Month() < 10) {
         
         month = "0" + IntegerToString(Month());
      }
      
      if(Day() < 10) {
      
         day = "0" + IntegerToString(Day());
      }
   
      return year+month+day;
   }
 
void OnStart()
  {   
      MessageBox(GetDate());
      
  }
  