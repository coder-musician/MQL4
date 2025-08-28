//+------------------------------------------------------------------+
//|                                                    Analytics.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\\Utils.mqh"

class Analytics
  {
private:
   
public:

   Analytics();
   ~Analytics();
   
      static void WriteStats(string TradeDetails) {
      
      string Filename = Utils::GetDate() + "-ANALYTICS.csv";
      int Filehandle;
      
      string Header = "ORDER_DATE," + 
      "ORDER_TIME," + 
      "SYMBOL," + 
      "ORDER_OPERATION," + 
      "ORDER_TICKET," + 
      "ORDER_OPEN_PRICE," + 
      "ORDER_PROFIT_PRICE," + 
      "CLOSED_TAKE_PROFIT," + 
      "ORDER_RISK_PRICE," + 
      "CLOSED_RISK_PRICE," + 
      "PROFIT";
                  
      if(!FileIsExist(Filename, 0)) {
        
        Filehandle = FileOpen(Filename,FILE_READ|FILE_WRITE|FILE_CSV, ',');
        FileWrite(Filehandle, Header); // HeaderS
        FileSeek(Filehandle, 0, SEEK_END);
        FileWrite(Filehandle, TradeDetails);
        FileClose(Filehandle);
        
      }
      else {
         Filehandle = FileOpen(Filename,FILE_READ|FILE_WRITE|FILE_CSV, ',');
         FileSeek(Filehandle, 0, SEEK_END);
         FileWrite(Filehandle, TradeDetails + "\n");
         FileClose(Filehandle);
      }
   }
   
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Analytics::Analytics()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Analytics::~Analytics()
  {
  }
//+------------------------------------------------------------------+
