//+------------------------------------------------------------------+
//|                                                        Utils.mqh |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property library

#include "Constants.mqh"

class Utils
  {
private:
   
public:
  
   Utils();
  ~Utils();
  
// --------------------------- DATE / TIME  
  
   static string GetDate() {
      
      string YearString = IntegerToString(Year());
      string MonthString = IntegerToString(Month());
      string DayString = IntegerToString(Day());
      
      if(Month() < 10)         
         MonthString = "0" + IntegerToString(Month());
      
      if(Day() < 10) 
         DayString = "0" + IntegerToString(Day());
         
      return YearString + MonthString + DayString;
   }
   
   static string GetTime() {
   
      string HourString = IntegerToString(Hour());
      string MinutesString = IntegerToString(Minute());      
      string SecondsString = IntegerToString(Seconds());
      
      if(Hour() < 10)          
         HourString = "0" + IntegerToString(Hour());
            
      if(Minute() < 10) 
         MinutesString = "0" + IntegerToString(Minute());
      
      if(Seconds() < 10)
         SecondsString = "0" + IntegerToString(Seconds());
      
      string TimeString = HourString + MinutesString + SecondsString;
      
      return TimeString;
   }

   
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Utils::Utils()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Utils::~Utils()
  {
  }
//+------------------------------------------------------------------+
   /*
   static double GetLinePrice(string LineName) {

      double LinePrice = NormalizeDouble(ObjectGet(LineName, 1),Digits); 
      return LinePrice;
   }
   
   static void PlotLine(string LineName, double Price, int Color) {
   
      bool NewLine = ObjectCreate(LineName, OBJ_HLINE, 0, Time[0], Price, 0, 0);
      ObjectSetInteger(0,LineName,OBJPROP_COLOR,Color);
   }
   
   static void MoveLine(string LineName, double Price) {
   //Alert(LineName + " - "+ Price);
      static bool MoveLine = ObjectSetDouble(0, LineName, OBJPROP_PRICE1, Price);
   }
   
   static void DeleteLine(string LineName) {
      
      ObjectDelete(ChartID(), LineName);
   }
   
   static void ChangeLineColor(string LineName, int Color) {

      bool LineColor = ObjectSetInteger(0,LineName,OBJPROP_COLOR,Color);
   
   }
   
   static void DeleteLevels() {
      
         DeleteLine("OP");
         DeleteLine("TP");
         DeleteLine("SL");
   }
   
   static void CloseAllOrders() {
   
      GetOrdersList();
      
      for(int i=0; i<ArraySize(ORDERS_LIST); i++) {
      
         if(ORDERS_LIST[i] == 0)
            break;
         
         double currentOrder = OrderSelect(ORDERS_LIST[i], SELECT_BY_TICKET, MODE_TRADES );
         CloseOrder(OrderTicket(), OrderLots(), OrderOpenPrice());
      } 
      
      DeleteLevels();     
   }
   */