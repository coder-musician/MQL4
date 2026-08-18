//+------------------------------------------------------------------+
//|                                                        Utils.mqh |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


int HTF = 240;
string OPEN_TRADE_SUFFIX = "1M";
double RISK = 0.01;
string ACC_CURRENCY = "USD";

class Utils
  {
private:

public:
  
   Utils();
  ~Utils();
  
     string GetDate() {
      
      string year = IntegerToString(Year());
      string month = IntegerToString(Month());
      string day = IntegerToString(Day());
      
      if(Month() < 10)         
         month = "0" + IntegerToString(Month());
      
      if(Day() < 10) 
         day = "0" + IntegerToString(Day());
         
      return year+month+day;
   }
   
   string GetTime() {
   
      string hour = IntegerToString(Hour());
      string minutes = IntegerToString(Minute());      
      string seconds = IntegerToString(Seconds());
      
      if(Hour() < 10)          
         hour = "0" + IntegerToString(Hour());
            
      if(Minute() < 10) 
         minutes = "0" + IntegerToString(Minute());
      
      if(Seconds() < 10)
         seconds = "0" + IntegerToString(Seconds());
      
      string time = hour + minutes + seconds;
      
      return time;
   }
  
  
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Utils::Utils()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Utils::~Utils()
  {
  }
//+------------------------------------------------------------------+
