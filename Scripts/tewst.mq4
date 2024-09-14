//+------------------------------------------------------------------+
//|                                                        tewst.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//#property show_inputs


string YEAR;
string MONTH;
string DAY;
string HOUR;
string MINUTES;

// --- SETTINGS 
// --- SNAPSHOTS
int IMAGE_XPIX = 615;
int IMAGE_YPIX = 882;
// --- ANALYTICS
string JOURNAL;
string OPEN_TIME;
string CLOSE_TIME;
string OPEN_PRICE;
string CLOSE_PRICE;
string TYPE;
string SIZE;
string PROFIT;
string ORDER_ID;
string TIMING;

string normalizeString(string myDigits) {

   if(StringLen(myDigits) < 2) { myDigits = "0" + myDigits; }

   return myDigits;
}
   
void syncClock() {



   YEAR = normalizeString(IntegerToString(Year()));
   MONTH = normalizeString(IntegerToString(Month()));
   DAY = normalizeString(IntegerToString(Day()));
   HOUR = normalizeString(IntegerToString(Hour()));
   MINUTES = normalizeString(IntegerToString(Minute()));
}

void takeSnapshot(string comment) {
   
   syncClock();
   
   datetime LOCALTIME = TimeLocal();
   MqlDateTime DATETIME;
   
   string name = Symbol() + "-" + YEAR+MONTH+DAY  + "-" + 
      HOUR+MINUTES  + "-" + IntegerToString(Period()) + "-" + TimeDayOfWeek(LOCALTIME) + comment + ".png";
   
   MessageBox(name);
   
   //ChartScreenShot(0, name, IMAGE_XPIX, IMAGE_YPIX, ALIGN_RIGHT);
   
}



void OnStart(){

   
   takeSnapshot("");
}
/*
   datetime LOCALTIME = TimeLocal();
   MqlDateTime DATETIME;
   
   TimeToStruct(LOCALTIME,DATETIME);
   
   MessageBox(IntegerToString(Year()) + IntegerToString(Month()) + IntegerToString(Day()));
*/



/*
string getDate() {

   string myYear = normalizeString(IntegerToString(dateStruct.year));
   string myMonth = normalizeString(IntegerToString(dateStruct.mon));
   string myDay = normalizeString(IntegerToString(dateStruct.day));

   return myYear + myMonth + myDay;
}

string getTime() {

   string myHour = normalizeString(IntegerToString(dateStruct.hour));
   string myMinutes = normalizeString(IntegerToString(dateStruct.min));
   string mySeconds = normalizeString(IntegerToString(dateStruct.sec));

   return myHour + "_" + myMinutes + "_" + mySeconds;
}

string getTimeStamp() {

   return getDate() + "-" + getTime() + "-" + getWeekDay();
}

void update() {

   myDate = TimeLocal();
   TimeToStruct(myDate,dateStruct);
}

string normalizeString(string myDigits) {

   if(StringLen(myDigits) < 2) { myDigits = "0" + myDigits; }

   return myDigits;
}

string getWeekDay() {

   string weekDay;

   if(dateStruct.day_of_week==0) {

      weekDay = "Sun";
   }
   else if(dateStruct.day_of_week==1){

      weekDay = "Mon";
   }
   else if(dateStruct.day_of_week==2){

      weekDay = "Tue";
   }
   else if(dateStruct.day_of_week==3){

      weekDay = "Wed";
   }
   else if(dateStruct.day_of_week==4){

      weekDay = "Thu";
   }
   else if(dateStruct.day_of_week==5){

      weekDay = "Fri";
   }
   else if(dateStruct.day_of_week==6){

      weekDay = "Sat";
   }

   return weekDay;
}
*/






/*
extern string LINK_TO_JOURNAL = "";

#include "..\Include\Custom\Journal.mqh"





//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
      
      Journal journal = Journal();
      journal.CreateLabel("LINK_TO_JOURNAL", LINK_TO_JOURNAL);
      
      
      //MessageBox(journal.GetValue("LINK_TO_JOURNAL"));
     
      
  }
//+------------------------------------------------------------------+
*/