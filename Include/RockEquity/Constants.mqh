
// ---------------------------------- <CONFIG> --------------------------------- 
string TRADING_ACCOUNT_CURRENCY = "USD";
double CAPITAL_RISK_RATE = 1;
double RISK_REWARD_RATIO = 3;
double SL_FACTOR = 5; // Multiplied by Spread Gives Number of Pips of Stop Loss (Opening Trade)
int ORDER_SLIPPAGE = 0;

// --------------------------- ROCK EXPERT
int LTF = 60;
int CANDLES_COUNT;

// --------------------------- MANAGEMENT  
   int OPEN_PRICE_COLOR = clrSienna;   
   int TAKE_PROFIT_COLOR = clrAqua;    
   int STOP_LOSS_COLOR = clrRed;
   
   int CANDLE_BULL_LTF_BODY_COLOR = clrAqua;
   int CANDLE_BEAR_LTF_BODY_COLOR = clrRed;
      
   int CANDLE_BULL_LTF_WICK_COLOR = clrTurquoise; 
   int CANDLE_BEAR_LTF_WICK_COLOR = clrRed;
   
   int CANDLE_BULL_HTF_BODY_COLOR = clrLimeGreen;
   int CANDLE_BEAR_HTF_BODY_COLOR = clrCrimson;
   
   int CANDLE_BULL_HTF_WICK_COLOR = clrGreen;
   int CANDLE_BEAR_HTF_WICK_COLOR = clrMaroon;
   
// --------------------------- JOURNAL
   int IMAGE_XPIX = 615;
   int IMAGE_YPIX = 882;

// --------------------------- ORDERS
   int ORDER_TICKET;
   string ORDER_DATE;
   int ORDER_OPERATION;
   double ORDER_LOTS;
      
   double ORDER_SPREAD;
   double ORDER_OPEN_PRICE;
   double ORDER_CLOSE_PRICE;
   double ORDER_TAKE_PROFIT_PRICE;
   double ORDER_STOP_LOSS_PRICE;   
   
   int ORDERS_LIST[100];
   bool PAIR_HAS_ACTIVE_ORDERS;   
   
   int ORDER_STANDARD_LOT = 100000;
   int ORDER_PRICE_DECIMALS;
   
// --------------------------------- <INDICATORS> --------------------------------- 

// --------------------------- CANDLESTICKS
   string CANDLES_NAMES[3] = {"CANDLE0", "CANDLE1", "CANDLE2"};
   
   int CANDLE_FONT_SIZE = 27;
   int CANDLE_OFFSET_X[3] = {20, 27, 34};
   int CANDLE_OFFSET_Y = 40;

   int CANDLE_BULLISH_OPEN_COLOR = clrGreen;
   int CANDLE_BEARISH_OPEN_COLOR = clrRed;
   int CANDLE_TWEEZER_COLOR = clrYellow;

   
// --------------------------- VOLUME
   int BARS_INCLUDED = 10; // last 10 bars
   int VOLUMES_FONT_SIZE = 9;
   int VOLUMES_FONT_COLOR = clrCornflowerBlue;
   int X_POSITION = 40;
   int Y_POSITION = 25;   
   