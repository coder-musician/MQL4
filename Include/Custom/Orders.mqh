//+------------------------------------------------------------------+
//|                                                       Orders.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

   bool IS_ORDER_ACTIVE = False;
   int ORDERS_LIST[10];
   int ORDER_TICKET = 0;
   
   string ORDER_DATE;
   string ORDER_TIME;
   
   double ORDER_OPEN_PRICE = 0;
   
   double ORDER_PROFIT_PRICE = 0;
   double ORDER_RISK_PRICE = 0;
   
   double ORDER_LOTS = 0;
   int ORDER_OPERATION = 0;


class Orders
  {
  
private:


public:

   Orders();   
   ~Orders();     
   
   void GetOrdersList() {
   
      for(int i=0; i<OrdersTotal(); i++) {
      
         bool openOrder = OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
         
         if(openOrder && OrderSymbol() == Symbol()){
            
            ORDERS_LIST[i] = OrderTicket();
         }
      }
   }
   
   void LoadOrderValues(int OrderId){ 

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
      
   bool checkForActiveOrders(string symbol) {
      
      bool isActive = False;
      
      for(int i=0; i<OrdersTotal(); i++) {
      
         bool openOrder = OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
         
         if(openOrder && OrderSymbol() == symbol){
            
            isActive = True;
            break;
         }
      }
     
      return isActive;      
   }
   
   int PlaceOrder() {
      
      int newOrder = OrderSend(Symbol(), ORDER_OPERATION, ORDER_LOTS, ORDER_OPEN_PRICE, 0, 
         ORDER_RISK_PRICE, ORDER_PROFIT_PRICE, DoubleToStr(ORDER_RISK_PRICE));
      
      if(newOrder != -1) {
      
         bool NewLine = ObjectCreate("OPEN_PRICE", OBJ_HLINE, 0, Time[0], ORDER_OPEN_PRICE, 0, 0);
         ObjectSetInteger(0,"OPEN_PRICE",OBJPROP_COLOR,clrWhite);
      }
      else {
      
         string summary = "ORDER_TICKET: " + IntegerToString(ORDER_TICKET) + "\n" +
         "ORDER_OPEN_PRICE: " + DoubleToString(ORDER_OPEN_PRICE) + "\n" +
         "ORDER_PROFIT_PRICE: " + DoubleToString(ORDER_PROFIT_PRICE) + "\n" +
         "ORDER_RISK_PRICE: " + DoubleToString(ORDER_RISK_PRICE) + "\n" +
         "ORDER_LOTS: " + DoubleToString(ORDER_LOTS) + "\n";
         
         MessageBox(summary);
      }
      
      return newOrder;
   }
   
   void UpdateOrder(int OrderId, double StopRisk, double TakeProfit) {
   
      bool OrderAdjust = OrderModify(OrderId,0, StopRisk, TakeProfit, 0, clrNONE); 
   }
   
   void CloseOrder(int ticket, double lots, double price) {
   
      bool closeSuccess = OrderClose(ticket,lots,price,3,clrNONE);
      
      ObjectDelete(0, "OPEN_PRICE");
      ObjectDelete(0, "TP_ASK");
      ObjectDelete(0, "TP_BID");
      ObjectDelete(0, "SL_ASK");
      ObjectDelete(0, "SL_BID");
   }
   
   void CloseAllOrders() {
   
      GetOrdersList();
      
      for(int i=0; i<ArraySize(ORDERS_LIST); i++) {
      
         if(ORDERS_LIST[i] == 0)
            break;
         
         double currentOrder = OrderSelect(ORDERS_LIST[i], SELECT_BY_TICKET, MODE_TRADES );
         CloseOrder(OrderTicket(), OrderLots(), OrderOpenPrice());
      }      
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