//+------------------------------------------------------------------+
//|                                                  ValueAreaEA.mq5 |
//|                                            Copyright 2025, JoeyT |
//|                         https://github.com/jtokovics/ValueAreaEA |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, JoeyT"
#property link      "https://github.com/jtokovics/ValueAreaEA"
#property version   "1.00"

// === INPUTS ===
input bool   UseValueArea      = true;
input ENUM_TIMEFRAMES ValueAreaPeriod = PERIOD_D1;
input bool   UseSwingHL        = true;
input int    SwingLookbackBars = 100;
input double RiskPerTrade      = 1.0;
input int    MaxOpenTrades     = 3;
input bool   LogTrade         = true;

// === VARIABLES ===
datetime lastActionTime;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   //set the current bar time by min tf
   datetime mainTFBarDate = iTime(NULL, ValueAreaPeriod, 0);
   //run if new candle appear in the main time frame
   if(mainTFBarDate != lastActionTime)
     {
      lastActionTime = mainTFBarDate;
     }
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
