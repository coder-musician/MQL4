//+------------------------------------------------------------------+
//|                                                   Management.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


#include ".\Utils\Utils.mqh"

   // SETTINGS
   double RISK_REWARD_RATIO = 3;
   // ----------
   
   double OPEN_BID_PRICE = 0;
   double OPEN_ASK_PRICE = 0;
   
   double TAKE_PROFIT_BID_PRICE = 0;
   double TAKE_PROFIT_ASK_PRICE = 0;
   
   double STOP_RISK_BID_PRICE = 0;
   double STOP_RISK_ASK_PRICE = 0;
   
   double TAKE_PROFIT_PIPS = 0;
   double STOP_RISK_PIPS = 0;
   
   int OPERATION_TYPE = 0;

class Management
  {
private:

   void PlotLine(string LineName, double Price, int Color) {
      
      bool NewLine = ObjectCreate(LineName, OBJ_HLINE, 0, Time[0], Price, 0, 0);
      ObjectSetInteger(0,LineName,OBJPROP_COLOR,Color);
   }
   
   void MoveLine(string LineName, double Price) {
   
      bool MoveLine = ObjectSetDouble(0, LineName, OBJPROP_PRICE1, Price);
   }
   
   void ChangeLineColor(string LineName, int Color) {
   
      bool LineColor = ObjectSetInteger(0,LineName,OBJPROP_COLOR,Color);
   }
   
   double GetLinePrice(string LineName) {
   
      double LinePrice = NormalizeDouble(ObjectGet(LineName, 1),Digits); 
      
      return LinePrice;
   }
   
   void Get_Risk_Pips() { 
      
      STOP_RISK_BID_PRICE = NormalizeDouble(ObjectGet("SL_BID", 1),Digits);
      
      if(Bid > STOP_RISK_BID_PRICE) 
         STOP_RISK_PIPS = Ask - STOP_RISK_BID_PRICE;
      
      else 
         STOP_RISK_PIPS = STOP_RISK_BID_PRICE - Bid;
         
   }
     
public:

      Management();
     ~Management();                    
      
      void UpdateTakeProfit(double SlBid) {  
         
         double SPREAD = Ask-Bid;
         
         int TP_LINE_COLOR = clrAqua;  
                
         if(GetLinePrice("TP_BID") == 0) {
         
            PlotLine("TP_BID", 0, TP_LINE_COLOR);   
         } 
         
         STOP_RISK_BID_PRICE = NormalizeDouble(ObjectGet("SL_BID", 1),Digits);
         STOP_RISK_ASK_PRICE = STOP_RISK_BID_PRICE + SPREAD;
         
         Get_Risk_Pips();
         
         if(Bid > SlBid) {
            
            OPERATION_TYPE = OP_BUY;
            
            TAKE_PROFIT_BID_PRICE = Bid + (STOP_RISK_PIPS*RISK_REWARD_RATIO) + (SPREAD);
            
            ChangeLineColor("SL_BID", clrRed);
                        
         }
         else {

            OPERATION_TYPE = OP_SELL;
            
            TAKE_PROFIT_BID_PRICE = Ask - (STOP_RISK_PIPS*RISK_REWARD_RATIO) - (SPREAD);           
            
            ChangeLineColor("SL_BID", clrIndigo);
            TP_LINE_COLOR = clrIndigo;
         }
         
         
         TAKE_PROFIT_ASK_PRICE = TAKE_PROFIT_BID_PRICE + SPREAD;
         ChangeLineColor("TP_BID", TP_LINE_COLOR);
         MoveLine("TP_BID", TAKE_PROFIT_BID_PRICE);
            
         AdjustAskLines(TAKE_PROFIT_BID_PRICE, STOP_RISK_BID_PRICE);
     }     
      
      void LoadValues() {
         
         OPEN_BID_PRICE = GetLinePrice("OPEN_PRICE");
         
         TAKE_PROFIT_BID_PRICE = GetLinePrice("TP_BID");
         TAKE_PROFIT_ASK_PRICE = GetLinePrice("TP_ASK");
         
         STOP_RISK_BID_PRICE = GetLinePrice("SL_BID");
         STOP_RISK_ASK_PRICE = GetLinePrice("SL_ASK");
         
         Get_Risk_Pips();
      }
      
      void AdjustAskLines(double TpBid, double SlBid) {   
         
         double SPREAD = Ask-Bid;
         
         ObjectDelete(0, "SL_ASK");
         ObjectDelete(0, "TP_ASK");
         
         if(SlBid > TpBid) { // <- SELL
         
            PlotLine("TP_ASK", (TpBid-SPREAD), clrAqua);
            PlotLine("SL_ASK", (SlBid-SPREAD), clrRed);
         }
   
      }
      
      void PlotLevels(double OpenPrice, double TpBid, double SlBid) {
         
         double SPREAD = Ask-Bid;
         
         DeleteLevels();
         PlotLine("OPEN_PRICE", OpenPrice, clrSienna);
         
         
         if(SlBid > TpBid) { // <- SELL
            
            PlotLine("TP_BID", TpBid, clrIndigo);
            PlotLine("SL_BID", SlBid, clrIndigo);
         }
         else {
            
            PlotLine("TP_BID", TpBid, clrAqua);
            PlotLine("SL_BID", SlBid, clrRed);
         }
      }
      
      void MoveLevels(double TpBid, double SlBid) {
         
         MoveLine("TP_BID", TpBid);
         MoveLine("SL_BID", SlBid);
      }
      
      void SetLevels() {
      
         ObjectCreate("SL_BID", OBJ_HLINE, 0, Time[0], (Bid - ((Ask-Bid)*5)));
         ObjectSetInteger(0,"SL_BID",OBJPROP_COLOR,clrRed);
      }
      
      void DeleteLevels() {
   
         ObjectDelete(0, "OPEN_PRICE");
         ObjectDelete(0, "TP_ASK");
         ObjectDelete(0, "TP_BID");
         ObjectDelete(0, "SL_ASK");
         ObjectDelete(0, "SL_BID");
      }
     
      string GetSummary() {
      
         string summary = "OPERATION_TYPE: " +  IntegerToString(OPERATION_TYPE) + "\n" +
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
 