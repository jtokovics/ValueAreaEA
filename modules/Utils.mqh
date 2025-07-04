//+------------------------------------------------------------------+
//|                                                        Utils.mqh |
//|                                            Copyright 2025, JoeyT |
//|                         https://github.com/jtokovics/ValueAreaEA |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, JoeyT"
#property link      "https://github.com/jtokovics/ValueAreaEA"

//+------------------------------------------------------------------+
//| Functions                                                        |
//+------------------------------------------------------------------+
void Log(string message, bool alsoToTerminal = true) {
   string fileName = "ValueAreaEA/ValueAreaEA.log";
   int fileHandle = FileOpen(fileName, FILE_WRITE | FILE_TXT | FILE_ANSI | FILE_READ);
   
   if(fileHandle != INVALID_HANDLE) {
      FileSeek(fileHandle, 0, SEEK_END); // add to the end of the file
      FileWrite(fileHandle, TimeToString(TimeCurrent(), TIME_DATE | TIME_MINUTES), " - ", message);
      FileClose(fileHandle);
   }

   if(alsoToTerminal) {
      Print("[ValueAreaEA] ", message);
   }
}

void ErrorLog(string message, bool alsoToTerminal = true) {
   string fileName = "ValueAreaEA/ErrorLog.log";
   int fileHandle = FileOpen(fileName, FILE_WRITE | FILE_TXT | FILE_ANSI | FILE_READ);
   
   if(fileHandle != INVALID_HANDLE) {
      FileSeek(fileHandle, 0, SEEK_END); // add to the end of the file
      FileWrite(fileHandle, TimeToString(TimeCurrent(), TIME_DATE | TIME_MINUTES), " - ", message);
      FileClose(fileHandle);
   }

   if(alsoToTerminal) {
      Print("[ValueAreaEA] ", message);
   }
}

void TradeLog(double eValP, double eValN, double cVal, bool enabled = true) 
   {
    if(enabled)
     {
      string fileName = "ValueAreaEA/" + _Symbol + "_TradeStats.log";
      int fileHandle = FileOpen(fileName, FILE_WRITE | FILE_TXT | FILE_ANSI | FILE_READ);
   
      if(fileHandle != INVALID_HANDLE) 
         {
          FileSeek(fileHandle, 0, SEEK_END); // add to the end of the file
          string line = StringFormat(
               "%s; %s; MaxFloatingProfit=%.2f; MaxFloatingLoss=%.2f; Closed=%.2f\n",
               TimeToString(TimeCurrent(), TIME_DATE|TIME_SECONDS),
               _Symbol,
               eValP,
               eValN,
               eValN
               );
          FileWrite(fileHandle, line);
          FileClose(fileHandle);
         }
     }
   
   }
