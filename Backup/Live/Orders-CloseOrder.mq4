//+------------------------------------------------------------------+
//|                                            ORDERS-CloseOrder.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

int totalOrders=OrdersTotal();
      

void OnStart()
  {
//---
   
   int ORDERS_TICKET_NUMBER = 0;
   double ORDERS_LOTS = 0;
   bool openOrder = False;
   
   for(int i=0; i<OrdersTotal(); i++) {

      openOrder = OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
   
      if(OrderSymbol() == Symbol()){
         
         ORDERS_TICKET_NUMBER = OrderTicket();
         ORDERS_LOTS = OrderLots();
      
         if(OrderType() == OP_BUY) {
            
            bool closeSuccess = OrderClose(ORDERS_TICKET_NUMBER,
                                    ORDERS_LOTS,Ask,3,clrNONE);
         } else if(OrderType() == OP_SELL) {
            
            bool closeSuccess = OrderClose(ORDERS_TICKET_NUMBER,
                                    ORDERS_LOTS,Bid,3,clrNONE);
         } else {
            
            // FOR PENDING ORDERS
            bool closeSuccess = OrderDelete(ORDERS_TICKET_NUMBER);
         }
      }
    }
    
   ObjectDelete(0, "Price");
   ObjectDelete(0, "TP");
   ObjectDelete(0, "SL");
   ObjectDelete(0, "Pending");
  }
//+------------------------------------------------------------------+
