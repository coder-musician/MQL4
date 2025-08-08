//+------------------------------------------------------------------+
//|                                                      Journal.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

   int IMAGE_XPIX = 615;
   int IMAGE_YPIX = 882;

class Journal
  {
private:
   
   
   
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
   
   string GetTime() {
   
      string hour = IntegerToString(Hour());
      string minutes = IntegerToString(Minute());      
      string seconds = IntegerToString(Seconds());
      
      if(Hour() < 10) {
         
         hour = "0" + IntegerToString(Hour());
      }
      
      if(Minute() < 10) {
      
         minutes = "0" + IntegerToString(Minute());
      }
      
      if(Seconds() < 10) {
      
         seconds = "0" + IntegerToString(Seconds());
      }
      
      string time = hour + minutes + seconds;
      
      return time;
   }
   
   string GetImagePath() {
   
      string path = GetDate() + "\\" + Symbol() + "\\";  
      
      return path;
   }
   
   string GetImageName(string desc) {
      
      string image = Symbol() + "-" + GetDate() + "-" + GetTime() + "-" + desc + ".png";
                        
      return image;
   }
   
   void TakeSnapshot(long chartid, string desc) {
      
      bool snapSuccess;
      string fullpath;
      string image;      
      
      image = Symbol() + "-" + GetDate() + "-" + GetTime() + "-" + desc + ".png";      
      fullpath = GetImagePath() + "LTF\\" + GetImageName(desc);           
    
      snapSuccess = ChartScreenShot(chartid, fullpath, 
         IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);
      
      chartid = (ChartNext(chartid));      
      
      fullpath = GetImagePath() + "HTF\\" + GetImageName(desc);           
      
      snapSuccess = ChartScreenShot(chartid, fullpath, 
         IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);
   }
   
public:

   Journal();
  ~Journal();

   void MarketSnapshot(long chartid) {
      
      string desc = "Market";      
      TakeSnapshot(chartid, desc);
   }
   
   void CustomSnapshot(long chartid) {
      
      string desc = "Custom";      
      TakeSnapshot(chartid, desc);
   }
   
   void OpenSnapshot(long chartid, int orderid) {
      
      string desc = "Trade-1-Open-" + orderid + "-" + OPEN_TRADE_SUFFIX;      
      TakeSnapshot(chartid, desc);      
   }
   
   void TradeSnapshot(long chartid, int orderid) {
      
      string desc = "Trade-2-Next-" + orderid;      
      TakeSnapshot(chartid, desc);
   }
   
   void CloseSnapshot(long chartid, int orderid) {  
      string desc = "Trade-3-Close-" + orderid;
      
      TakeSnapshot(chartid, desc);
   }
   
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Journal::Journal()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Journal::~Journal()
  {
  }
//+------------------------------------------------------------------+