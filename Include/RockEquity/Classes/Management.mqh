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
      
   static void PlotLine(string LineName, double Price, int Color) {
   
      bool NewLine = ObjectCreate(LineName, OBJ_HLINE, 0, Time[0], Price, 0, 0);
      ObjectSetInteger(0,LineName,OBJPROP_COLOR,Color);
   }
   
   static void MoveLine(string LineName, double Price) {
   
      static bool MoveLine = ObjectSetDouble(0, LineName, OBJPROP_PRICE1, Price);
   }
   
   static void ChangeLineColor(string LineName, int Color) {

      bool LineColor = ObjectSetInteger(0,LineName,OBJPROP_COLOR,Color);
   
   }
   
   static void SetLines() {
   

   if(TAKE_PROFIT_BID_PRICE == 0)     
      PlotLine("TP_BID", TAKE_PROFIT_BID_PRICE, TP_BID_LINE_COLOR);
   else
      MoveLine("TP_BID", TAKE_PROFIT_BID_PRICE);
      
      if(ORDER_OPERATION == OP_BUY) { 
         
         ChangeLineColor("TP_BID", TP_ASK_LINE_COLOR);       
         ChangeLineColor("SL_BID", SR_ASK_LINE_COLOR);
         
         PlotLine("TP_ASK", TAKE_PROFIT_ASK_PRICE, TP_BID_LINE_COLOR);
         PlotLine("SL_ASK", STOP_RISK_ASK_PRICE, SR_BID_LINE_COLOR);  
         
      }
      else {
      
         ChangeLineColor("TP_BID", TP_BID_LINE_COLOR);          
         ChangeLineColor("SL_BID", SR_BID_LINE_COLOR);
         
         Utils::DeleteLine("SL_ASK");
         Utils::DeleteLine("TP_ASK");
                  
      }
   }
     
   static void LoadValues() {
   /*
      bool NewLine = ObjectCreate(LineName, OBJ_HLINE, 0, Time[0], Price, 0, 0);
      ObjectSetInteger(0,LineName,OBJPROP_COLOR,Color);
      
      int DEFAULT_PIPS = 10;
      double SPREAD = Ask-Bid;
      
      double TAKE_PROFIT_BID_PRICE = Bid - (spread*DEFAULT_PIPS);
      
      TAKE_PROFIT_BID_PRICE = Utils::GetLinePrice("TP_BID");
      
      
      TAKE_PROFIT_ASK_PRICE = Utils::GetLinePrice("TP_ASK");
//MessageBox(TAKE_PROFIT_BID_PRICE); 
      STOP_RISK_ASK_PRICE = Utils::GetLinePrice("SL_ASK");
      TAKE_PROFIT_ASK_PRICE = Utils::GetLinePrice("TP_ASK");*/
   }
     
public:

   Management();
  ~Management();
     
   static void UpdateValues() {

      STOP_RISK_BID_PRICE = Utils::GetLinePrice("SL_BID");.
      LoadValues();
      
/*
      if(STOP_RISK_BID_PRICE != 0) {
      
         SPREAD = Ask-Bid;         
         double TAKE_PROFIT_DISTANCE;   

         if(Bid > STOP_RISK_BID_PRICE) {
  
            ORDER_OPERATION = OP_BUY;


            TAKE_PROFIT_DISTANCE = STOP_RISK_PIPS*RISK_REWARD_RATIO;
            TAKE_PROFIT_BID_PRICE = Bid - TAKE_PROFIT_DISTANCE;   
        
                     
         } else {
            
            ORDER_OPERATION = OP_SELL; 
            STOP_RISK_PIPS = Ask - STOP_RISK_BID_PRICE;
            TAKE_PROFIT_DISTANCE = STOP_RISK_PIPS*RISK_REWARD_RATIO;            
            TAKE_PROFIT_BID_PRICE = Ask + TAKE_PROFIT_DISTANCE;               
         }
      
         STOP_RISK_ASK_PRICE = STOP_RISK_BID_PRICE + SPREAD;
         TAKE_PROFIT_ASK_PRICE = TAKE_PROFIT_BID_PRICE + SPREAD;
         
         
         SetLines();
         
      }*/
      
      
   }    
   
   static string data() {
   
    string summary = 
         //"OPERATION_TYPE: " +  IntegerToString(OPERATION_TYPE) + "\n" +
         "TAKE_PROFIT_BID_PRICE: " + DoubleToString(TAKE_PROFIT_BID_PRICE) + "\n" +
         "TAKE_PROFIT_ASK_PRICE: " + DoubleToString(TAKE_PROFIT_ASK_PRICE) + "\n" +
         "STOP_RISK_BID_PRICE: " + DoubleToString(STOP_RISK_BID_PRICE) + "\n" +
         "STOP_RISK_ASK_PRICE: " + DoubleToString(STOP_RISK_ASK_PRICE) + "\n" +
         "STOP_RISK_PIPS: " + DoubleToString(STOP_RISK_PIPS) + "\n";
      
       return summary;
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
 
 