//+------------------------------------------------------------------+
//|                                                    Analytics.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

int ANALYTICS_TICKET = 0;
double ANALYTICS_LOTS = 0;
int ANALYTICS_OPERATION;

string ANALYTICS_OPEN_DATETIME;
double ANALYTICS_OPEN_PRICE = 0;

string ANALYTICS_CLOSE_DATETIME;
double ANALYTICS_CLOSE_PRICE = 0;

class Analytics
  {
private:
   /*
   string CreateFolder() {
   
      string folder = Symbol() + "\\" + IntegerToString(Year()) + "." + IntegerToString(Month());   
      bool result = FolderCreate(folder,0);
      
      return folder;
   }
   */
   string GetDate() {
      
      string year = IntegerToString(Year());
      string month = IntegerToString(Month());
      string day = IntegerToString(Day());
      
      if(Month() < 10) {
         
         month = "0" + IntegerToString(Month());
      }
   
      return year+month;
   }
   
   void WriteStats(string tradeDetails) {
   
      //string folder = CreateFolder();
      //string yearmonth = IntegerToString(Year()) + "." + IntegerToString(Month());
      string filename = GetDate() + "-ANALYTICS.csv";
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
        FileWrite(filehandle, header + "\n"); // HEADERS
        FileSeek(filehandle, 0, SEEK_END);
        FileWrite(filehandle, tradeDetails + "\n");
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
                     
   
   

   
   void writeTradeDetails(string msg) {
   
      WriteStats(msg);
      
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
