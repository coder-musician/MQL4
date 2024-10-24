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
#include "..\Include\Custom\Analytics.mqh"



//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

void OnStart()
  {
//---
          int obj_total=ObjectsTotal();
  string name;
  string desc;
  
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(i);
      desc = ObjectDescription(name);
     Alert(name + "-" + desc);
     
    }
   
   
      
  }
//+------------------------------------------------------------------+
/*

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
  
  */