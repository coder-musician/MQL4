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
string extension = ".png";

class Journal
  {
private:

   bool takeScreenShot(string name) {
      
      long chartid = ChartID();
   
      bool snapSuccess = ChartScreenShot(chartid, name, 
            IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);
            
      return snapSuccess;
   }

public:

   Journal();
  ~Journal();
  
  
  void MarketScreenshot(string symbol) {
  
         string name = symbol + "-" + 
            IntegerToString(TimeCurrent()) + extension;
            
         takeScreenShot(name);
   }
   
   void CustomScreenshot(string symbol) {
  
         string name = symbol + "-" + 
            IntegerToString(TimeCurrent()) + "-" +
            "Custom" + extension;
            
         takeScreenShot(name);
   }
   
   void OpenScreenshot(string symbol, int orderid) {
  
         string name = symbol + "-" + 
            IntegerToString(TimeCurrent()) + "-" +
            IntegerToString(orderid) + "-Open" +
            extension;
            
         takeScreenShot(name);
   }
   
   void CloseScreenshot(string symbol, int orderid) {
  
         string name = symbol + "-" + 
            IntegerToString(TimeCurrent()) + "-" +
            IntegerToString(orderid) + "-Close" +
            extension;
            
         takeScreenShot(name);
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