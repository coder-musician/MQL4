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

public:

   Journal();
  ~Journal();
  
  
  void takeScreenshot(string ticket) {
         
         string snapshot = ticket + ".png";
         bool a = ChartScreenShot(0, snapshot + ".png", IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);
   }
   
  

   
   
   
           /*         
   bool createFolder(string folderName) {

      bool result = FolderCreate(folderName,0);
      
      return result;
   }
   
   void takeScreenshot(string name) {
   
      ChartScreenShot(0, , IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);
   }
      
      void CreateLabel(string LabelName, string LabelValue) {
      
         ObjectCreate(LabelName, OBJ_LABEL, 0, Time[0], 0, 0, 0);
         ObjectSetString(0,LabelName,OBJPROP_TEXT,LabelValue); 
         ObjectSetInteger(0,LabelName,OBJPROP_COLOR,clrNONE);
      }
      
      string GetValue(string LabelName) {
      
         string value = ObjectGetString(0,LabelName, OBJPROP_TEXT,0);
         
         return value;
      }*/
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
