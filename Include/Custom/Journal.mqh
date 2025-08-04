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
      string date = year + "." + month + "." + day;
      
      return date;
   }
   
   string GetTime() {
   
      string hour = IntegerToString(Hour());
      string minutes = IntegerToString(Minute());      
      string seconds = IntegerToString(Seconds());
      string time = hour + "." + minutes + "." + seconds;
      
      return time;
   }
   
   string GetPairPath() {
   
      string path = IntegerToString(Year()) + "." + IntegerToString(Month()) + "\\" + GetDate() + "\\" + Symbol() + "\\";  
      
      return path;
   }
   
   string GetImageName(string desc) {
      
      string image = Symbol() + "-" + GetDate() + "-" + GetTime() + "-" + desc + ".png";
                        
      return image;
   }
   
   void TakeLTFShot(long chartid, string desc) {
      
      string fullpath = GetPairPath() + "LTF\\" + GetImageName(desc);           
    
      bool snapSuccess = ChartScreenShot(chartid, fullpath, 
         IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);
   }
   
   void TakeHTFShot(long chartid, string desc) {
      
      string fullpath = GetPairPath() + "HTF\\" + GetImageName(desc);           
    
      bool snapSuccess = ChartScreenShot(chartid, fullpath, 
         IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);
   }
   
public:

   Journal();
  ~Journal();
  
  void MarketLTFScreenshot(long chartid) {
            
      TakeLTFShot(ChartID(), "Market-LTF");
   }
   
   void MarketHTFScreenshot() {
            
      TakeHTFShot(ChartNext(ChartID()), "Market-HTF");
   }
   
   void CustomScreenshot() {
      
      string type = "Custom";
      
      TakeLTFShot(ChartID(), type);
      TakeHTFShot(ChartNext(ChartID()), type);
   }
   
   void OpenScreenshot(int orderid) {
      
      string desc = "Trade-1-Open-" + IntegerToString(orderid);
      
      TakeLTFShot(ChartID(), desc);
      TakeHTFShot(ChartNext(ChartID()), desc);
   }
   
   void TradeScreenshot(int orderid) {
      
      string desc = "Trade-2-Next-" + IntegerToString(orderid);
      
      TakeLTFShot(ChartID(), desc);
      TakeHTFShot(ChartNext(ChartID()), desc);
   }
   
   void CloseScreenshot(int orderid) {
  
      string desc = "Trade-3-Close-" + IntegerToString(orderid);
      
      TakeLTFShot(ChartID(), desc);
      TakeHTFShot(ChartNext(ChartID()), desc);
   }
   /*
   void GetSummary() {
   
      string message = "ImagePath: " + GetPairPath() + "LTF\\" + GetImageName();
      CustomScreenshot();
      MessageBox(message);
      
   }
   */
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