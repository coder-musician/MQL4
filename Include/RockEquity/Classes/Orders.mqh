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

#include "..\Constants.mqh"
#include "..\Classes\Management.mqh"

class Orders
  {
  
private:
   
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
   
   static double NormalizePrice(double Price) {
   
      string PriceString = DoubleToStr(Price);
      int PriceStringLength = StringLen(PriceString);
      int PriceEntire = StringFind(PriceString,".", 0) + 1;
      
      ORDER_PRICE_DECIMALS = PriceStringLength - PriceEntire;
      
      if(ORDER_PRICE_DECIMALS == 5 || ORDER_PRICE_DECIMALS == 3) {
         
         ORDER_PRICE_DECIMALS--;
         
         PriceString = StringSubstr(PriceString,0, 
            (PriceEntire + ORDER_PRICE_DECIMALS));
      }
      
      Price = StringToDouble(PriceString);
      
      return Price;
   }
 
   
   static double GetPipValue() {
      
      string SinglePipString = "0.";
      
      for(int i=0; i < ORDER_PRICE_DECIMALS; i++) {
         
         if(i == (ORDER_PRICE_DECIMALS-1))            
            SinglePipString = SinglePipString + "1";
         else 
            SinglePipString = SinglePipString + "0";
      }
      
      double PipValue = StringToDouble(SinglePipString) / Bid;
      
      if(AccountCurrency() != TRADING_ACCOUNT_CURRENCY)
         PipValue = PipValue * ORDER_OPEN_PRICE;
         
      PipValue = PipValue*ORDER_STANDARD_LOT;
      
      return PipValue;
   }
   
   static double FormatRiskedPips(double RiskedPips) {
   
      string Multiplier = "1";
      
      for(int i=1; i <= ORDER_PRICE_DECIMALS; i++)       
         Multiplier = Multiplier + "0";
         
      RiskedPips = RiskedPips*StringToInteger(Multiplier);
      
      return RiskedPips;
   }

public:

   Orders();   
   ~Orders();
      
   static bool PairHasActiveOrders(string PairSymbol) {
      
      bool IsOrderLoaded = False;
      bool IsOrderActive = False;
  
      for(int i=0; i < OrdersTotal(); i++) {
   
         IsOrderLoaded = OrderSelect(i, SELECT_BY_POS);
      
         if(OrderSymbol() != PairSymbol)
            continue;
         
         IsOrderActive = True;
         
         ORDER_TICKET = OrderTicket(); 
         ORDER_OPEN_PRICE = OrderOpenPrice();
         ORDER_TAKE_PROFIT_PRICE = OrderTakeProfit();
         ORDER_STOP_LOSS_PRICE = OrderStopLoss();
         ORDER_LOTS = OrderLots(); 
         
         break;
      }
      
      return IsOrderActive;
   }
      
   static int PlaceOrder(long ChartId) {
      
      double AccountBalance = AccountBalance();
      double RiskedPips = 0;
      
      ORDER_SPREAD = Ask-Bid;
      
      ORDER_TAKE_PROFIT_PRICE = Management::GetLinePrice("TP");
      ORDER_STOP_LOSS_PRICE = Management::GetLinePrice("SL");
      
      if(ORDER_STOP_LOSS_PRICE < Bid) {
         
         ORDER_OPERATION = OP_BUY;
         ORDER_OPEN_PRICE = NormalizePrice(Ask);
         ORDER_CLOSE_PRICE = NormalizePrice(Bid);
         
         RiskedPips =  ORDER_OPEN_PRICE - ORDER_STOP_LOSS_PRICE;
         
         ORDER_STOP_LOSS_PRICE = ORDER_STOP_LOSS_PRICE + ORDER_SPREAD;
         ORDER_TAKE_PROFIT_PRICE = ORDER_TAKE_PROFIT_PRICE + ORDER_SPREAD;
         
         Alert(ORDER_STOP_LOSS_PRICE);
         
         
      } 
      else {
         
         ORDER_OPERATION = OP_SELL;
         ORDER_OPEN_PRICE = NormalizePrice(Bid);
         ORDER_CLOSE_PRICE = NormalizePrice(Ask);
         
         RiskedPips = ORDER_STOP_LOSS_PRICE - ORDER_CLOSE_PRICE;
         
         ORDER_STOP_LOSS_PRICE = ORDER_STOP_LOSS_PRICE + ORDER_SPREAD;
         ORDER_TAKE_PROFIT_PRICE = ORDER_TAKE_PROFIT_PRICE + ORDER_SPREAD;
         
         
      }
      
      RiskedPips = FormatRiskedPips(RiskedPips);
      
      double PipValue = GetPipValue();
      double RiskedAmount = AccountBalance * (CAPITAL_RISK_RATE)/100;
       
      ORDER_LOTS = (RiskedAmount/PipValue)/RiskedPips;
      
      int NewOrder = OrderSend(Symbol(), ORDER_OPERATION, ORDER_LOTS, ORDER_OPEN_PRICE, 
         ORDER_SLIPPAGE, ORDER_STOP_LOSS_PRICE, ORDER_TAKE_PROFIT_PRICE);
      
      if(NewOrder != -1) {
      
         Management::PlotLine(ChartID(), "OP", ORDER_OPEN_PRICE, OPEN_PRICE_COLOR);
         PAIR_HAS_ACTIVE_ORDERS = True;  
      }      
   
      return NewOrder;
   }
   
   
   void UpdateOrder(int OrderId, double StopLoss, double TakeProfit) {
   
      bool OrderAdjust = OrderModify(OrderId,0, StopLoss, TakeProfit, 0, clrNONE); 
   }
   
   
   void GetTradeSummary(int Ticket) {
   
      string Summary = "ORDER_TICKET: " + DoubleToStr(ORDER_TICKET) + "\n" +
         "ORDER_OPEN_PRICE: " + DoubleToStr(ORDER_OPEN_PRICE) + "\n" +
         "ORDER_PROFIT_PRICE: " + DoubleToStr(ORDER_TAKE_PROFIT_PRICE) + "\n" +
         "ORDER_STOP_LOSS_PRICE: " + DoubleToStr(ORDER_STOP_LOSS_PRICE) + "\n" +
         "ORDER_LOTS: " + DoubleToStr(ORDER_LOTS) + "\n"+ 
         "ERROR: " + IntegerToString(GetLastError()) + "\n Enable Auto Trading";
         
      MessageBox(Summary);
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