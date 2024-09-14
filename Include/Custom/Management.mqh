//+------------------------------------------------------------------+
//|                                                   Management.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

// SETTINGS
double REWARD_RATIO = 3;
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
      
      if(Bid > STOP_RISK_BID_PRICE) {
      
         STOP_RISK_PIPS = Ask - STOP_RISK_BID_PRICE;
      }
      else {
         
         STOP_RISK_PIPS = STOP_RISK_BID_PRICE - Bid;
      }   
   }
      
   /*
   void UpdateTakeProfit(double SlBid) {   

      double SPREAD = Ask-Bid;
      
      //ObjectDelete(0, "TP_BID");
      //ObjectDelete(0, "TP_ASK");
      //ObjectDelete(0, "SL_ASK");
      
      //ChangeLineColor("SL_BID", clrRed);      
      STOP_RISK_BID_PRICE = SlBid;
      STOP_RISK_ASK_PRICE = STOP_RISK_BID_PRICE + SPREAD;
      
      Get_Risk_Pips();
      TAKE_PROFIT_PIPS = STOP_RISK_PIPS*REWARD_RATIO;
      
      if(Bid > SlBid) {
         
         //Get_Risk_Pips();
         
         //TAKE_PROFIT_PIPS = STOP_RISK_PIPS*REWARD_RATIO;
         OPERATION_TYPE = OP_BUY;
         
         TAKE_PROFIT_BID_PRICE = Bid + (STOP_RISK_PIPS*REWARD_RATIO) + SPREAD;
         TAKE_PROFIT_ASK_PRICE = TAKE_PROFIT_BID_PRICE + SPREAD;
         
         //PlotLine("SL_ASK", STOP_RISK_ASK_PRICE, clrIndigo);
         PlotLine("TP_BID", TAKE_PROFIT_BID_PRICE, clrGreen);
         //PlotLine("TP_ASK", TAKE_PROFIT_ASK_PRICE, clrIndigo);
         //ObjectDelete(0, "TP_ASK");
         //ObjectDelete(0, "SL_ASK");
         
         
      }
      else {
         
         //Get_Risk_Pips();
         //TAKE_PROFIT_PIPS = STOP_RISK_PIPS*REWARD_RATIO;
         OPERATION_TYPE = OP_SELL;
         
         TAKE_PROFIT_BID_PRICE = Ask - TAKE_PROFIT_PIPS - SPREAD;
         TAKE_PROFIT_ASK_PRICE = TAKE_PROFIT_BID_PRICE + SPREAD;
         
         ChangeLineColor("SL_BID", clrIndigo);
         //PlotLine("SL_ASK", STOP_RISK_ASK_PRICE, clrRed);
         PlotLine("TP_BID", TAKE_PROFIT_BID_PRICE, clrIndigo);
         //PlotLine("TP_ASK", TAKE_PROFIT_ASK_PRICE, clrGreen);        

      }
      
  }  
  ---*/
public:
                     Management();
                    ~Management();
                    
      
      void UpdateTakeProfit(double SlBid) {   
      
         double SPREAD = Ask-Bid;
         int TP_LINE_COLOR = clrGreen;
         
         if(GetLinePrice("TP_BID") == 0) {
         
            PlotLine("TP_BID", 0, TP_LINE_COLOR);   
         } 

         //ObjectDelete(0, "TP_BID");
         //ObjectDelete(0, "TP_ASK");
         //ObjectDelete(0, "SL_ASK");
         
         //ChangeLineColor("SL_BID", clrRed);      
         STOP_RISK_BID_PRICE = SlBid;
         STOP_RISK_ASK_PRICE = STOP_RISK_BID_PRICE + SPREAD;
         
         Get_Risk_Pips();
         TAKE_PROFIT_PIPS = STOP_RISK_PIPS*REWARD_RATIO;
         
         
         if(Bid > SlBid) {
            
            //Get_Risk_Pips();
            
            //TAKE_PROFIT_PIPS = STOP_RISK_PIPS*REWARD_RATIO;
            OPERATION_TYPE = OP_BUY;
            
            TAKE_PROFIT_BID_PRICE = Bid + (STOP_RISK_PIPS*REWARD_RATIO) + SPREAD;
            TAKE_PROFIT_ASK_PRICE = TAKE_PROFIT_BID_PRICE + SPREAD;
            
            
            //PlotLine("SL_ASK", STOP_RISK_ASK_PRICE, clrIndigo);
            ChangeLineColor("SL_BID", clrRed);
            //PlotLine("TP_BID", TAKE_PROFIT_BID_PRICE, clrGreen);
            //PlotLine("TP_ASK", TAKE_PROFIT_ASK_PRICE, clrIndigo);
            //ObjectDelete(0, "TP_ASK");
            //ObjectDelete(0, "SL_ASK");
            
            
         }
         else {
            
            //Get_Risk_Pips();
            //TAKE_PROFIT_PIPS = STOP_RISK_PIPS*REWARD_RATIO;
            OPERATION_TYPE = OP_SELL;
            
            TAKE_PROFIT_BID_PRICE = Ask - TAKE_PROFIT_PIPS - SPREAD;
            TAKE_PROFIT_ASK_PRICE = TAKE_PROFIT_BID_PRICE + SPREAD;
            
            ChangeLineColor("SL_BID", clrIndigo);
            TP_LINE_COLOR = clrIndigo;
            //PlotLine("SL_ASK", STOP_RISK_ASK_PRICE, clrRed);
            //PlotLine("TP_BID", TAKE_PROFIT_BID_PRICE, clrIndigo);
            //PlotLine("TP_ASK", TAKE_PROFIT_ASK_PRICE, clrGreen);        
   
         }
         
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
         
            PlotLine("TP_ASK", TpBid+SPREAD, clrGreen);
            PlotLine("SL_ASK", SlBid+SPREAD, clrRed);
         }
   
      }
      
      void PlotLevels(double OpenPrice, double TpBid, double SlBid) {
         
         double SPREAD = Ask-Bid;
         
         DeleteLevels();
         PlotLine("OPEN_PRICE", OpenPrice, clrWhite);
         
         
         if(SlBid > TpBid) { // <- SELL
            
            PlotLine("TP_BID", TpBid, clrIndigo);
            PlotLine("SL_BID", SlBid, clrIndigo);
         }
         else {
            
            PlotLine("TP_BID", TpBid, clrGreen);
            PlotLine("SL_BID", SlBid, clrRed);
         }
      }
      
      void MoveLevels(double OpenPrice, double TpBid, double SlBid) {
         
         MoveLine("OPEN_PRICE", OpenPrice);
         MoveLine("TP_BID", TpBid);
         MoveLine("SL_BID", SlBid);
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
   LoadValues();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Management::~Management()
  {
  }
//+------------------------------------------------------------------+
 