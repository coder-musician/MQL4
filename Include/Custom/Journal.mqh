//+------------------------------------------------------------------+
//|                                                      Journal.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

long ORDER_ID = 0;
//datetime OPENPRICE = 

class Journal
  {
private:

public:
                     Journal();
                    ~Journal();
                    
      void CreateLabel(string LabelName, string LabelValue) {
      
         ObjectCreate(LabelName, OBJ_LABEL, 0, Time[0], 0, 0, 0);
         ObjectSetString(0,LabelName,OBJPROP_TEXT,LabelValue); 
         ObjectSetInteger(0,LabelName,OBJPROP_COLOR,clrNONE);
      }
      
      string GetValue(string LabelName) {
      
         string value = ObjectGetString(0,LabelName, OBJPROP_TEXT,0);
         
         return value;
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
