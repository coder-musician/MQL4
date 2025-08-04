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
   
   string CreateFolder() {
   
      string folder = Symbol() + "\\" + IntegerToString(Year()) + "." + IntegerToString(Month());   
      bool result = FolderCreate(folder,0);
      
      return folder;
   }
   
   string GetDate() {
   
      string year = IntegerToString(Year());
      string month = IntegerToString(Month());
      string day = IntegerToString(Day());      
      string date = year + "." + month;
      
      return date;
   }
   
public:
                     Analytics();
                    ~Analytics();
                     
   
   
   void WriteStats() {
   
      string folder = CreateFolder();
      string yearmonth = IntegerToString(Year()) + "." + IntegerToString(Month());
      string filename = folder + "\\" + Symbol() + "-" + yearmonth + "-ANALYTICS.csv";
      int filehandle;
      
     if(!FileIsExist(filename, 0)) {
        
        filehandle = FileOpen(filename,FILE_READ|FILE_WRITE|FILE_CSV, ',');
        FileWrite(filehandle, "SYMBOL", "DATE"); // HEADERS
        FileSeek(filehandle, 0, SEEK_END);
        FileWrite(filehandle, ANALYTICS_LOTS, ANALYTICS_CLOSE_PRICE);
        FileClose(filehandle);
        
     }
     else {
         filehandle = FileOpen(filename,FILE_READ|FILE_WRITE|FILE_CSV, ',');
         FileSeek(filehandle, 0, SEEK_END);
         FileWrite(filehandle, ANALYTICS_OPEN_PRICE, ANALYTICS_CLOSE_PRICE);
         FileClose(filehandle);
     }
      
      FileClose(filehandle);
   }
   
   void writeTradeDetails(string msg) {
   
      Alert(msg);
      
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
