

// ---------------------------------- <CONFIG> --------------------------------- 
double RISK_REWARD_RATIO = 3;


// --------------------------------- <CLASSES> --------------------------------- 


// --------------------------- MANAGEMENT
   
   double OPEN_BID_PRICE = 0;
   double OPEN_ASK_PRICE = 0;
   
   double TAKE_PROFIT_BID_PRICE = 0;
   double TAKE_PROFIT_ASK_PRICE = 0;
   
   double STOP_RISK_BID_PRICE = 0;
   double STOP_RISK_ASK_PRICE = 0;
   
   double TAKE_PROFIT_PIPS = 0;
   double STOP_RISK_PIPS = 0;

// --------------------------- JOURNAL
   int IMAGE_XPIX = 615;
   int IMAGE_YPIX = 882;


// --------------------------- ORDERS

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


// --------------------------------- <INDICATORS> --------------------------------- 


// --------------------------- CANDLESTICKS

   string candles[3] = {"CANDLE0", "CANDLE1", "CANDLE2"};
   int offsetx[3] = {20, 27, 34};
   
   int fontSize = 27;
   int offsety = 40;
   
   
// --------------------------- VOLUME

   int timeframe = 10; // last 10 bars
   int x;
   int y;
   
   int font = 9;
   int sety = 25;
   int setx = 40;   