//+------------------------------------------------------------------+
//|                                                      JOrders.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

int ORDERS_TICKET_NUMBER = 0;
int ORDERS_OPERATION = OP_SELL;
double ORDERS_LOTS = 0;
double ORDERS_SPREAD = Ask-Bid;
string ORDERS_COMMENT = "";

double ORDERS_PRICE_BID = Bid;
double ORDERS_PRICE_ASK = Ask;

double ORDERS_PRICE_TP_BID = 0;
double ORDERS_PRICE_TP_ASK = 0;
double ORDERS_PRICE_SL_BID = 0;
double ORDERS_PRICE_SL_ASK = 0;

double ORDERS_RISK_PERCENTAGE = 1;

class JOrders
  {

public:

   JOrders();
  ~JOrders();
  
   void placeMarketOrder() {
   
      fetchOrderValues();
      
      sendOrder(ORDERS_OPERATION, ORDERS_PRICE_BID, 
            ORDERS_PRICE_TP_BID, ORDERS_PRICE_SL_BID);
            
      ObjectDelete(0, "Price");
   }
   
   void placePendingOrder() {
      
      fetchOrderValues();
      
      ORDERS_PRICE_BID = NormalizeDouble(ObjectGet("Price", 1),Digits);
      ORDERS_PRICE_ASK = getAskPrice(ORDERS_PRICE_BID);
      
      double pipsRisked = 0;
      
      if(ORDERS_OPERATION == OP_BUY) {
      
         ORDERS_OPERATION = OP_BUYSTOP;
         pipsRisked = priceToPips(ORDERS_PRICE_ASK-ORDERS_PRICE_SL_BID);
      
      } else {      

         ORDERS_OPERATION = OP_SELLSTOP;
         pipsRisked = priceToPips(ORDERS_PRICE_SL_ASK-ORDERS_PRICE_BID);
      }
      
      ORDERS_LOTS = getLots(pipsRisked);
       
      sendOrder(ORDERS_OPERATION, ORDERS_PRICE_BID, 
               ORDERS_PRICE_TP_BID, ORDERS_PRICE_SL_BID);
   }
   
   void modifyOrder() {
      
      fetchOrderValues();
      
      bool isChanged = false;
      double tp = 0;
      double sl = 0;
      
      if(ORDERS_OPERATION == OP_SELL || ORDERS_OPERATION == OP_SELLSTOP) {
         
         if(tp != ORDERS_PRICE_TP_ASK || sl != ORDERS_PRICE_SL_ASK) {
         
            isChanged = true;
            tp = getBidPrice(NormalizeDouble(ObjectGet("TP", 1),Digits));
            sl = getBidPrice(NormalizeDouble(ObjectGet("SL", 1),Digits));
         }  
                
      } else if(ORDERS_OPERATION == OP_BUY || ORDERS_OPERATION == OP_BUYSTOP) {
      
         if(tp != ORDERS_PRICE_TP_BID || sl != ORDERS_PRICE_SL_BID) {
            
            isChanged = true;
            tp = NormalizeDouble(ObjectGet("TP", 1),Digits);
            sl = NormalizeDouble(ObjectGet("SL", 1),Digits);
         }      
      }
      
      if(isChanged) {
      
         bool isSuccessful = OrderModify(ORDERS_TICKET_NUMBER,
                        ORDERS_PRICE_BID,sl, tp,0,0);
      } 
   }
   
   void closeOrders() {
      
      if(ORDERS_OPERATION == OP_BUY) {
         
         bool closeSuccess = OrderClose(ORDERS_TICKET_NUMBER,
                                 ORDERS_LOTS,Ask,3,clrNONE);
      } else if(ORDERS_OPERATION == OP_SELL) {
         
         bool closeSuccess = OrderClose(ORDERS_TICKET_NUMBER,
                                 ORDERS_LOTS,Bid,3,clrNONE);
      } else {
      
         bool closeSuccess = OrderDelete(ORDERS_TICKET_NUMBER);
      }
   }
                    
private:
   
   void sendOrder(int operation, double price, double tp, double sl) {
   
      if(ORDERS_TICKET_NUMBER == 0) {
      
         ORDERS_TICKET_NUMBER = OrderSend(Symbol(), operation, 
                                 ORDERS_LOTS, price, 0, 
                                 sl, tp, ORDERS_COMMENT);
         PlaySound("ok.wav");
         
      } else {
      
         MessageBox("Order " + IntegerToString(ORDERS_TICKET_NUMBER) +
                     " is open for " + Symbol());
      }
   }
   
   void fetchOrderValues() { 
      
      // POPULATING VARIABLES - OPEN ORDER
      // CHECKING WHETHER OR NOT THERE IS AN OPEN ORDER
      ORDERS_TICKET_NUMBER = 0;
      
      int totalOrders=OrdersTotal();
      
      for(int i=0; i<totalOrders; i++) {
      
         bool openOrder = OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
         
         if(OrderSymbol() == Symbol()){
            
            ORDERS_TICKET_NUMBER = OrderTicket();
            ORDERS_OPERATION = OrderType();
            ORDERS_LOTS = OrderLots();
            ORDERS_PRICE_BID = OrderOpenPrice();
            
            ORDERS_PRICE_TP_BID = OrderTakeProfit();
            ORDERS_PRICE_TP_ASK = getAskPrice(ORDERS_PRICE_TP_BID);
            
            ORDERS_PRICE_SL_BID = OrderStopLoss();
            ORDERS_PRICE_SL_ASK = getAskPrice(ORDERS_PRICE_SL_BID);
         }
      }

      if(ORDERS_TICKET_NUMBER == 0) {
            
         ORDERS_PRICE_BID = Bid;
         ORDERS_PRICE_ASK = Ask;
         
         ORDERS_OPERATION = OP_BUY;
            
         ORDERS_PRICE_TP_BID = NormalizeDouble(ObjectGet("TP", 1),Digits);
         ORDERS_PRICE_TP_ASK = getAskPrice(ORDERS_PRICE_TP_BID);         
         ORDERS_PRICE_SL_BID = NormalizeDouble(ObjectGet("SL", 1),Digits);
         ORDERS_PRICE_SL_ASK = getAskPrice(ORDERS_PRICE_SL_BID);
         
         double pipsRisked = priceToPips(ORDERS_PRICE_ASK-ORDERS_PRICE_SL_BID);
         
         // CHANGE IF SELL ORDER
         if(ORDERS_PRICE_BID < ORDERS_PRICE_SL_ASK) {
         
            ORDERS_OPERATION = OP_SELL;
            
            ORDERS_PRICE_TP_ASK = NormalizeDouble(ObjectGet("TP", 1),Digits);
            ORDERS_PRICE_TP_BID = getBidPrice(ORDERS_PRICE_TP_ASK);            
            ORDERS_PRICE_SL_ASK = NormalizeDouble(ObjectGet("SL", 1),Digits);
            ORDERS_PRICE_SL_BID = getBidPrice(ORDERS_PRICE_SL_ASK);
            
            pipsRisked = priceToPips(ORDERS_PRICE_SL_ASK-ORDERS_PRICE_BID);          
         }
         
         ORDERS_LOTS = getLots(pipsRisked);
      }
   }
   

   
   double getLots(double pipsInRisk) {
   
      double amountRisked = AccountEquity()*(ORDERS_RISK_PERCENTAGE/100);
      
       return amountRisked/pipsInRisk;
   }
   
   double getAskPrice(double bidPrice) {
   
      return bidPrice + ORDERS_SPREAD;
   }
   
   double getBidPrice(double askPrice) {
      
      return askPrice - ORDERS_SPREAD;
   }
   
   double priceToPips(double pips) {
   
      string mult = "1";
      int myDigits = Digits;
      
      for(int i=0; i < myDigits; i++) {
         
         mult = mult + "0";
      }
      
      int multiplier = StrToInteger(mult);
      
      return NormalizeDouble((pips*multiplier),2);    
   }
   
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
JOrders::JOrders()
  {   
      fetchOrderValues();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
JOrders::~JOrders()
  {
  }
//+------------------------------------------------------------------+
