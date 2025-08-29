//+------------------------------------------------------------------+
//|                                                      Journal.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\\Constants.mqh"
#include "..\\Utils.mqh"

class Journal
  {
private:
   
   static string GetImagePath() {
   
      string Path = Utils::GetDate() + "\\" + Symbol() + "\\";  
      
      return Path;
   }
   
   static string GetImageName(string Description) {
      
      string ImageExtension = ".png";
      
      string Image = Symbol() + "-" + Utils::GetDate() + "-" + 
      Utils::GetTime() + "-" + Description + ImageExtension;
                        
      return Image;
   }
   
   static void TakeSnapshot(long ChartId, string Description) {
      
      bool SnapSuccess;
      string FullPath;
         
      FullPath = GetImagePath() + "LTF\\" + GetImageName(Description);           
    
      SnapSuccess = ChartScreenShot(ChartId, FullPath, 
         IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);
      
      ChartId = (ChartNext(ChartId));      
      
      FullPath = GetImagePath() + "HTF\\" + GetImageName(Description);           
      
      SnapSuccess = ChartScreenShot(ChartId, FullPath, 
         IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);
   }
   
public:

   Journal();
  ~Journal();

   static void MarketSnapshot(long ChartId) {
      
      string Description = "Market";      
      TakeSnapshot(ChartId, Description);
   }
   
   static void CustomSnapshot(long ChartId)  {
      
      string Description = "Custom";      
      TakeSnapshot(ChartId, Description);
   }
   
   static void OpenSnapshot(long ChartId, int OrderId) {
      
      string Description = "Trade-1-Open-" + IntegerToString(OrderId) + "-" + "1M";      
      TakeSnapshot(ChartId, Description);      
   }
   
   static void TradeSnapshot(long ChartId, int OrderId) {
      
      string Description = "Trade-2-Next-" + IntegerToString(OrderId);      
      TakeSnapshot(ChartId, Description);
   }
   
   static void CloseSnapshot(long ChartId, int OrderId) {  
      string Description = "Trade-3-Close-" + IntegerToString(OrderId);
      
      TakeSnapshot(ChartId, Description);
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