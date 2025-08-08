//+------------------------------------------------------------------+
//|                                                      Journal.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


#include ".\Utils\Utils.mqh"
   
   Utils utils = Utils(); 
   
   int IMAGE_XPIX = 615;
   int IMAGE_YPIX = 882;
   
class Journal
  {
    
private:
   
   string GetImagePath() {
   
      string path = utils.GetDate() + "\\" + Symbol() + "\\";  
      
      return path;
   }
   
   string GetImageName(string desc) {
      
      string image = Symbol() + "-" + utils.GetDate() + "-" + utils.GetTime() + "-" + desc + ".png";
                        
      return image;
   }
   
   void TakeSnapshot(long chartid, string desc) {
      
      bool snapSuccess;
      string fullpath;
      string image;      
      
      image = Symbol() + "-" + utils.GetDate() + "-" + utils.GetTime() + "-" + desc + ".png";      
      
      fullpath = GetImagePath() + "LTF\\" + GetImageName(desc);           
    
      snapSuccess = ChartScreenShot(chartid, fullpath, 
         IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);      
      
      fullpath = GetImagePath() + "HTF\\" + GetImageName(desc);           
      
      snapSuccess = ChartScreenShot(ChartNext(chartid), fullpath, 
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
      
      string desc = "Trade-1-Open-" + IntegerToString(orderid) + "-" + OPEN_TRADE_SUFFIX;      
      TakeSnapshot(chartid, desc);      
   }
   
   void TradeSnapshot(long chartid, int orderid) {
      
      string desc = "Trade-2-Next-" + IntegerToString(orderid) ;      
      TakeSnapshot(chartid, desc);
   }
   
   void CloseSnapshot(long chartid, int orderid) {  
   
      string desc = "Trade-3-Close-" + IntegerToString(orderid);   
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