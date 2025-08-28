//+------------------------------------------------------------------+
//|                                                   Management.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property library

#include "..\\Constants.mqh"
#include "..\\Utils.mqh"

class Management
  {
private:
     
public:

   Management();
  ~Management();
  
   static double GetLinePrice(string LineName) {

      double LinePrice = NormalizeDouble(ObjectGet(LineName, 1),Digits); 
      
      return LinePrice;
   }
   
   static void PlotLine(long ChartId, string LineName, double Price, int Color)  {
   
      bool NewLine = ObjectCreate(ChartId, LineName, OBJ_HLINE, 0, Time[0], Price, 0);
      
      ObjectSetInteger(ChartId ,LineName,OBJPROP_COLOR, Color);
   }
   
   static void DeleteLevels(long ChartId) {
      
      ObjectDelete(ChartId, "OP");
      ObjectDelete(ChartId, "TP");
      ObjectDelete(ChartId, "SL");
   }
   
   static void MoveLine(long ChartId, string LineName, double Price) {
   
      bool MoveLine = ObjectSetDouble(0, LineName, OBJPROP_PRICE1, Price);
   }
     
   static void AdjustTakeProfit (long ChartId) {       
      
      if(ORDER_STOP_LOSS_PRICE != 0) {
      
         ORDER_SPREAD = (Ask - Bid);
         ORDER_OPERATION = OP_BUY;
         ORDER_STOP_LOSS_PRICE = GetLinePrice("SL");
         double Risk = ORDER_SPREAD*SL_FACTOR;
         
         if(Bid < ORDER_STOP_LOSS_PRICE)
            ORDER_OPERATION = OP_SELL;
            
         
         if(ORDER_OPERATION == OP_BUY) {
            
            ORDER_OPEN_PRICE = Ask;
            ORDER_CLOSE_PRICE = Bid;
   
            if(ORDER_STOP_LOSS_PRICE != 0)
               Risk = ORDER_OPEN_PRICE - ORDER_STOP_LOSS_PRICE;            
               
            ORDER_TAKE_PROFIT_PRICE = ORDER_OPEN_PRICE + (Risk*RISK_REWARD_RATIO);
            ORDER_STOP_LOSS_PRICE = ORDER_OPEN_PRICE - Risk;
            
         } else {
            
            ORDER_OPEN_PRICE = Bid;
            ORDER_CLOSE_PRICE = Ask;
            
            if(ORDER_STOP_LOSS_PRICE != 0)
               Risk = ORDER_STOP_LOSS_PRICE - ORDER_OPEN_PRICE;
               
            ORDER_STOP_LOSS_PRICE = ORDER_OPEN_PRICE + Risk;       
            ORDER_TAKE_PROFIT_PRICE = ORDER_OPEN_PRICE - (Risk*RISK_REWARD_RATIO);
         }
               
               
         if (GetLinePrice("TP") == 0)         
            PlotLine(ChartId, "TP", ORDER_TAKE_PROFIT_PRICE, TAKE_PROFIT_COLOR);
         else 
            MoveLine(ChartId, "TP", ORDER_TAKE_PROFIT_PRICE);
      }
   }
   
   };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Management::Management()
  {
   
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Management::~Management()
  {
  }
//+------------------------------------------------------------------+
 
 