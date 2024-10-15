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

   string GetDate() {
   
      string year = IntegerToString(Year());
      string month = IntegerToString(Month());
      string day = IntegerToString(Day());      
      string date = year + "." + month + "." + day;
      
      return date;
   }
   
   string CreateFolder() {
   
      string folder = Symbol() + "\\" + GetDate();      
      bool result = FolderCreate(folder,0);
      
      return folder;
   }
   
   void TakeShot(int chartid, string desc) {
      
      string folder = CreateFolder();
      
      string fullpath = folder + "\\" + 
         StringSubstr(IntegerToString(TimeCurrent()),5,0) + "-" + 
         Symbol() + "-" + GetDate() + "-" + desc + extension;      
    
      bool snapSuccess = ChartScreenShot(chartid, fullpath, 
         IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);
   }
   
public:

   Journal();
  ~Journal();
  
  void MarketScreenshot() {
            
         TakeShot(0, "Market");
   }
   
   void CustomScreenshot() {
  
         TakeShot(0, "Custom");
   }
   
   void OpenScreenshot(int orderid) {
   
         string name = "ORDER." + IntegerToString(orderid) + "-Open";
  
         TakeShot(0, name);
   }
   
   void CloseScreenshot(int orderid) {
  
         string name = "ORDER." + IntegerToString(orderid) + "-Close";
  
         TakeShot(0, name);
   }
   
   void HTFScreenshot(int orderid, int chartid) {
  
         string name = "ORDER." + IntegerToString(orderid) + "-HTF";
  
         TakeShot(chartid, name);
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