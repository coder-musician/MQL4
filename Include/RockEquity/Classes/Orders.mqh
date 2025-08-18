//+------------------------------------------------------------------+
//|                                                       Orders.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property library

#include "..\Utils.mqh"
#include "..\Constants.mqh"

class Orders
  {
  
private:

   static double NormalizePrice(double price) {
   
      string priceString = DoubleToStr(price);
      int priceStringLength = StringLen(priceString);
      int priceEntire = StringFind(priceString,".", 0) + 1;   
      ORDER_PRICE_DECIMALS = priceStringLength - priceEntire;
      
      if(ORDER_PRICE_DECIMALS == 5 || ORDER_PRICE_DECIMALS == 3) {
         
         ORDER_PRICE_DECIMALS--;
         priceString = StringSubstr(priceString,0, (priceEntire+ORDER_PRICE_DECIMALS));
      }
      
      return StringToDouble(priceString);
   }
   
   static double GetPipValue() {
      
      string baseCurrency = StringSubstr(Symbol(), 0, 3);
      string singlePipString = "0.";
      
      for(int i=0; i < ORDER_PRICE_DECIMALS; i++) {
         
         if(i == (ORDER_PRICE_DECIMALS-1))            
            singlePipString = singlePipString + "1";
         else 
            singlePipString = singlePipString + "0";
      }
      
      double pipValue = StringToDouble(singlePipString) / Bid;
      
      if(baseCurrency != ACC_CURRENCY)
         pipValue = pipValue * ORDER_OPEN_PRICE;
      
      return (pipValue*ORDER_STANDARD_LOT);
   }
   
   static double GetRiskedPips(double RISKedPips) {
   
      string multiplier = "1";
      
      for(int i=1; i<=ORDER_PRICE_DECIMALS; i++)       
         multiplier = multiplier + "0";
      
      return (RISKedPips*StringToInteger(multiplier));
   }

public:

   Orders();   
   ~Orders();     
   
   static void LoadOrderValues(int OrderId){ 

      double currentOrder = OrderSelect(OrderId, SELECT_BY_TICKET, MODE_TRADES );
       
      ORDER_TICKET = OrderTicket(); 
      ORDER_OPEN_PRICE = OrderOpenPrice();
      ORDER_PROFIT_PRICE = OrderTakeProfit();
      ORDER_RISK_PRICE = OrderStopLoss();
      ORDER_LOTS = OrderLots();
      
      if(currentOrder != -1) {
      
         IS_ORDER_ACTIVE = True;
      }
   }
      
   static void checkForActiveOrders() {
      
      IS_ORDER_ACTIVE = False;
      ORDER_TICKET = 0;
            
      for(int i=0; i<OrdersTotal(); i++) {
      
         bool openOrder = OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
         
         if(openOrder && OrderSymbol() == Symbol()){
            
            IS_ORDER_ACTIVE = True;
            ORDER_TICKET = OrderTicket();
            break;
         }
      }      
   }
   
   static int PlaceOrder() {
      
      double accountBalance = AccountBalance();
      double RISKED_PIPS = 0;
      
      ORDER_PROFIT_PRICE = Utils::GetLinePrice("TP_BID");
      ORDER_RISK_PRICE = Utils::GetLinePrice("SL_BID");
      
      if(ORDER_RISK_PRICE < Bid) {
         
         ORDER_OPERATION = OP_BUY;
         ORDER_OPEN_PRICE = NormalizePrice(Ask); 
         RISKED_PIPS =  ORDER_OPEN_PRICE - ORDER_RISK_PRICE;
      } 
      else {
         
         ORDER_OPERATION = OP_SELL;
         ORDER_OPEN_PRICE = NormalizePrice(Bid);
         RISKED_PIPS = ORDER_RISK_PRICE - ORDER_OPEN_PRICE;
      }
      
      RISKED_PIPS = GetRiskedPips(RISKED_PIPS);
      
      double pipValue = GetPipValue();
      double riskedAmount = accountBalance * (CAPITAL_RISK_RATE)/100;
       
      ORDER_LOTS = (riskedAmount/pipValue)/RISKED_PIPS;
      
      int newOrder = OrderSend(Symbol(), ORDER_OPERATION, ORDER_LOTS, ORDER_OPEN_PRICE, 0, 
         ORDER_RISK_PRICE, ORDER_PROFIT_PRICE);
         
      ObjectDelete(0, "SL_ASK");
      ObjectDelete(0, "TP_ASK");
      
      if(newOrder != -1) {
      
         bool NewLine = ObjectCreate("OPEN_PRICE", OBJ_HLINE, 0, Time[0], ORDER_OPEN_PRICE, 0, 0);
         ObjectSetInteger(0,"OPEN_PRICE",OBJPROP_COLOR, OPEN_LINE_COLOR);   
      } 
      else {
      
         string summary = "ORDER_TICKET: " + DoubleToStr(ORDER_TICKET) + "\n" +
            "ORDER_OPEN_PRICE: " + DoubleToStr(ORDER_OPEN_PRICE) + "\n" +
            "ORDER_PROFIT_PRICE: " + DoubleToStr(ORDER_PROFIT_PRICE) + "\n" +
            "ORDER_RISK_PRICE: " + DoubleToStr(ORDER_RISK_PRICE) + "\n" +
            "ORDER_LOTS: " + DoubleToStr(ORDER_LOTS) + "\n"+ 
            "ERROR: " + IntegerToString(GetLastError()) + "\n Enable Auto Trading";
            
         MessageBox(summary);
      } 

      return newOrder;
   }
   
   void UpdateOrder(int OrderId, double StopRisk, double TakeProfit) {
   
      bool OrderAdjust = OrderModify(OrderId,0, StopRisk, TakeProfit, 0, clrNONE); 
   }
   
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Orders::Orders()
  {
      
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Orders::~Orders()
  {
  }
//+------------------------------------------------------------------+