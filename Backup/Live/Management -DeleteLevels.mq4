//+------------------------------------------------------------------+
//|                                              2- Delete Lines.mq4 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
int getOrderTicket(){ 

        int orderTicket = 0;

        for( int i = 0 ; i < OrdersTotal() ; i++ ) { 
         
         double currentOrder = OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
         
         if (OrderSymbol() == Symbol()) orderTicket = OrderTicket(); 
        } 
        
        return(orderTicket); 
} 
void OnStart()
  {
//---

   int ORDER_TICKET = getOrderTicket();
   bool IS_ORDER_ACTIVE = OrderSelect(ORDER_TICKET, SELECT_BY_TICKET);
   
   if(!IS_ORDER_ACTIVE) {
   
      ObjectDelete(0, "Price");
      ObjectDelete(0, "TP");
      ObjectDelete(0, "SL");
      ObjectDelete(0, "Pending");
   }
   

  }
//+------------------------------------------------------------------+
