//+------------------------------------------------------------------+
//|                                                      Testbed.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\Include\Custom\Management.mqh"
#include "..\Include\Custom\Orders.mqh"
#include "..\Include\Custom\Journal.mqh"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
  
   string GetDate() {
   
      string year = IntegerToString(Year());
      string month = IntegerToString(Month());
      string day = IntegerToString(Day());      
      string date = year + "." + month + "." + day;
      
      return date;
   }
   
   string CreateFolder() {
   
      string folder = Symbol() + "\\" + IntegerToString(Year()) + "." + IntegerToString(Month()) + "\\" +  GetDate();      
      bool result = FolderCreate(folder,0);
      
      return folder;
   }
   
   void TakeShot(long chartid, string desc) {
      
      string folder = CreateFolder();
      
      string fullpath = folder + "\\" + 
         StringSubstr(IntegerToString(TimeCurrent()),5,0) + "-" + 
         Symbol() + "-" + GetDate() + "-" + desc + extension;      
    
      bool snapSuccess = ChartScreenShot(chartid, fullpath, 
         IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);
   }
  
  void MarketScreenshot() {
            
         TakeShot(ChartID(), "Market");
   }
   
   void MarketHTFScreenshot() {
            
         TakeShot(ChartNext(ChartID()), "Market-HTF");
   }
   
   void CustomScreenshot() {
  
         TakeShot(ChartID(), "Custom");
         TakeShot(ChartNext(ChartID()), "Custom-HTF");
   }
   
   void OpenScreenshot(int orderid) {
   
         string name = "ORDER." + IntegerToString(orderid);
         string ltf = name + "LTF-Open";
         string htf = name + "HTF-Open";
  
         TakeShot(ChartID(),ltf);
         TakeShot(ChartNext(ChartID()), htf);
   }
   
   void CloseScreenshot(int orderid) {
  
         string name = "ORDER." + IntegerToString(orderid);
         string ltf = name + "LTF-Close";
         string htf = name + "HTF-Close";
  
         TakeShot(ChartID(),ltf);
         TakeShot(ChartNext(ChartID()), htf);
   }
    
void OnStart()
  {
//---
      TakeShot(123,"est");
   
  }
//+------------------------------------------------------------------+
