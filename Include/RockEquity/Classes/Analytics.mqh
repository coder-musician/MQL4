//+------------------------------------------------------------------+
//|                                                    Analytics.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property library

#include "..\\Utils.mqh"

#import
   string GetDate();
#import

class Analytics
  {
private:
   
   static void WriteStats(string tradeDetails) {
      
      string filename = Utils::GetDate() + "-ANALYTICS.csv";
      int filehandle;
      
      string header = "ORDER_DATE," + 
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
                  
      if(!FileIsExist(filename, 0)) {
        
        filehandle = FileOpen(filename,FILE_READ|FILE_WRITE|FILE_CSV, ',');
        FileWrite(filehandle, header); // HEADERS
        FileSeek(filehandle, 0, SEEK_END);
        FileWrite(filehandle, tradeDetails);
        FileClose(filehandle);
        
      }
      else {
         filehandle = FileOpen(filename,FILE_READ|FILE_WRITE|FILE_CSV, ',');
         FileSeek(filehandle, 0, SEEK_END);
         FileWrite(filehandle, tradeDetails + "\n");
         FileClose(filehandle);
      }
   }
   
public:

   Analytics();
   ~Analytics();
   
   static void WriteTrade(string details) {
   
      WriteStats(details);
      
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
