//+------------------------------------------------------------------+
//|                                                  ValueAreaEA.mq5 |
//|                                            Copyright 2025, JoeyT |
//|                         https://github.com/jtokovics/ValueAreaEA |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, JoeyT"
#property link      "https://github.com/jtokovics/ValueAreaEA"
#property version   "1.00"

// === INCLUDES ===
#include <Trade\Trade.mqh> // Trade functions
CTrade trade; // Trade object

#include "gui/Panel.mqh" //GUI for buttons and labels
#include "modules/Utils.mqh" // Utility functions for logging
#include "modules/SwingHL.mqh" // Swing High/Low calculations
#include "modules/ValueArea.mqh" // Value Area calculations
//+------------------------------------------------------------------+

// === INPUTS ===
input int             Magic             = 1;                        // Magic Number
input ENUM_TIMEFRAMES ValueAreaPeriod   = PERIOD_D1;                // Timeframe for Value Area calculation
input int             SwingLookbackBars = 100;
input double          RiskPerTrade      = 1.0;
input int             MaxOpenTrades     = 3;
input bool            LogTrade          = true;

const string Desc = "ValueAreaEA (" + IntegerToString(Magic) + ")";

// === VARIABLES ===
datetime lastActionTime;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
    // Set the magic number for the expert advisor
    trade.SetExpertMagicNumber(Magic);
   
    // Make the EA visible in the terminal
    CreateGui();
    SetExpertName(Desc);
    SetTime(TimeToString(TimeCurrent(), TIME_SECONDS));
    SetTrend("Neutral");

    Log("ValueAreaEA initialized with Magic Number: " + IntegerToString(Magic));

    //test log here
    TradeLog(100.0, -50.0, 50.0, LogTrade);

    return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   DeleteGui();
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
    if(sparam != BtnName1)
      return;
    if(id != CHARTEVENT_OBJECT_CLICK)
      return;
    //On Btn
    if(sparam == BtnName1)
      {
        SetButtonState(ObjectGetInteger(0,BtnName1,OBJPROP_STATE,true));
      }
  }
//+------------------------------------------------------------------+
