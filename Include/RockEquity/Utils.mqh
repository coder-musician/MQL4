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

   static void DeleteLine(string lineName) {
   
      ObjectDelete(0, lineName);
   }
   
   
   static void GetOrdersList() {
   
      for(int i=0; i<OrdersTotal(); i++) {
      
         bool openOrder = OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
         
         if(openOrder && OrderSymbol() == Symbol()){
            
            ORDERS_LIST[i] = OrderTicket();
         }
      }
   }
   
   
   
   static void CloseOrder(int ticket, double lots, double price) {
   
      bool closeSuccess = OrderClose(ticket,lots,price,3,clrNONE);
   }
   

   
public:
  
   Utils();
  ~Utils();
  
     static string GetDate() {
      
      string year = IntegerToString(Year());
      string month = IntegerToString(Month());
      string day = IntegerToString(Day());
      
      if(Month() < 10)         
         month = "0" + IntegerToString(Month());
      
      if(Day() < 10) 
         day = "0" + IntegerToString(Day());
         
      return year+month+day;
   }
   
   static string GetTime() {
   
      string hour = IntegerToString(Hour());
      string minutes = IntegerToString(Minute());      
      string seconds = IntegerToString(Seconds());
      
      if(Hour() < 10)          
         hour = "0" + IntegerToString(Hour());
            
      if(Minute() < 10) 
         minutes = "0" + IntegerToString(Minute());
      
      if(Seconds() < 10)
         seconds = "0" + IntegerToString(Seconds());
      
      string time = hour + minutes + seconds;
      
      return time;
   }
   
   static double GetLinePrice(string LineName) {
   
      double LinePrice = NormalizeDouble(ObjectGet(LineName, 1),Digits); 
      
      return LinePrice;
   }
   
   static void DeleteLevels() {
      
         DeleteLine("OPEN_PRICE");
         DeleteLine("TP_ASK");
         DeleteLine("TP_BID");
         DeleteLine("SL_ASK");
         DeleteLine("SL_BID");
      
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
