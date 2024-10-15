//+------------------------------------------------------------------+
//|                                                       Folder.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

string order;
int IMAGE_XPIX = 615;
int IMAGE_YPIX = 882;

void createFolder(string name) {

   bool result = FolderCreate(order,0);

}

void takeScreenshot(string order) {
      
      string  screenshotpath = order + ".png";
      bool a = ChartScreenShot(0, screenshotpath, IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);
}
   
void OnStart()
  {
//--- 
      order = "123345";
      takeScreenshot(order);
      
  }
//+------------------------------------------------------------------+
