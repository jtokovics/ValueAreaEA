//+------------------------------------------------------------------+
//|                                                  ValueAreaEA.mq5 |
//|                                            Copyright 2025, JoeyT |
//|                         https://github.com/jtokovics/ValueAreaEA |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, JoeyT"
#property link      "https://github.com/jtokovics/ValueAreaEA"
#property version   "1.00"

// === INCLUDES ===
//#include <Trade\Trade.mqh> // Trade functions
//CTrade trade; // Trade object

#include "gui/Panel.mqh" //GUI for buttons and labels
#include "modules/Utils.mqh" // Utility functions for logging
#include "modules/SwingHL.mqh" // Swing High/Low calculations
#include "modules/ValueArea.mqh" // Value Area calculations
//+------------------------------------------------------------------+

// === INPUTS ===
input int             Magic             = 1;                        // Magic Number
input ENUM_TIMEFRAMES ValueAreaPeriod   = PERIOD_D1;                // Timeframe for Value Area calculation
input bool            LogTrade          = true;

//=== TEMP INPUTS === (in progress)
//va calc
input double BinSize = 0.01; // Size of each bin for Value Area calculation
input int ValueAreaPercent = 80; // Percentage of volume to consider for Value Area

//entry inputs
input int RequiredBarsToEnter = 2; // Number of bars required to enter a trade
input ENUM_TIMEFRAMES EnterTimeframe = PERIOD_M30; // Timeframe for entry signals

//swing inputs
input int SwingLookback = 20; // Lookback period for swing high/low calculations

const string Desc = "ValueAreaEA (" + IntegerToString(Magic) + ")";
// === VARIABLES ===
datetime lastActionTime;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
    // Set the magic number for the expert advisor
    //trade.SetExpertMagicNumber(Magic);
   
    // Make the EA visible in the terminal
    CreateGui();
    SetExpertName(Desc);
    SetTime(TimeToString(TimeCurrent(), TIME_SECONDS));
    SetTrend("Neutral");

    Log(TimeToString(TimeCurrent(), TIME_MINUTES) + " : [" + _Symbol + "] ValueAreaEA initialized with Magic Number: " + IntegerToString(Magic));

    ValueAreaProcess(ValueAreaPeriod, BinSize, ValueAreaPercent);

    return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
    Log(TimeToString(TimeCurrent(), TIME_MINUTES) + " : [" + _Symbol + "] ValueAreaEA deinitialized with Magic Number: " + IntegerToString(Magic));

    // Delete GUI elements
    DeleteGui();
    // Remove Value Area lines from the chart
    RemoveValueAreaLines();
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

    // Update the GUI with the current time
    SetTime(TimeToString(TimeCurrent(), TIME_SECONDS));
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
