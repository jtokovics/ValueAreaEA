//+------------------------------------------------------------------+
//|                                                    ValueArea.mqh |
//|                                            Copyright 2025, JoeyT |
//|                         https://github.com/jtokovics/ValueAreaEA |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, JoeyT"
#property link      "https://github.com/jtokovics/ValueAreaEA"

#include <Arrays\ArrayObj.mqh>

// Struct to hold volume profile bin data
struct Bin
{
   double priceStart;
   double priceEnd;
   long volume;
};


// Create a volume profile for a given day
bool CreateVolumeProfileBin(datetime dayStart, datetime dayEnd, double binSize, Bin &bins[])
    {
        int totalBars = iBars(_Symbol, PERIOD_M1);
        if (totalBars <= 0) return false;

        ArrayResize(bins, 0);  // Töröljük az előző elemeket

        // Legkisebb és legnagyobb ár keresése
        double lowest = DBL_MAX, highest = DBL_MIN;

        for (int i = 0; i < totalBars; i++)
        {
            datetime t = iTime(_Symbol, PERIOD_M1, i);
            if (t < dayStart) break;
            if (t >= dayStart && t < dayEnd)
            {
                double high = iHigh(_Symbol, PERIOD_M1, i);
                double low = iLow(_Symbol, PERIOD_M1, i);
                if (high > highest) highest = high;
                if (low < lowest) lowest = low;
            }
            
        }
        
        if (lowest == DBL_MAX || highest == DBL_MIN) return false;

        int binCount = (int)MathCeil((highest - lowest) / binSize);
        ArrayResize(bins, binCount);

        for (int i = 0; i < binCount; i++)
        {
            bins[i].priceStart = lowest + i * binSize;
            bins[i].priceEnd   = bins[i].priceStart + binSize;
            bins[i].volume     = 0;
        }

        // Volume hozzárendelése a binekhez
        for (int i = 0; i < totalBars; i++)
        {
            datetime t = iTime(_Symbol, PERIOD_M1, i);
            if (t < dayStart) break;
            if (t >= dayStart && t < dayEnd)
            {
                double close = iClose(_Symbol, PERIOD_M1, i);
                long volume = (long)iVolume(_Symbol, PERIOD_M1, i);

                int binIndex = (int)MathFloor((close - lowest) / binSize);
                if (binIndex >= 0 && binIndex < ArraySize(bins))
                {
                    bins[binIndex].volume += volume;
                }
            }
        }
Print(totalBars);
        return true;
    }

bool CalculateValueArea(Bin &bins[], int percent, double &vah, double &val, double &poc)
    {
        int size = ArraySize(bins);
        if(size == 0) return false;

        // Összes volume kiszámítása
        long totalVolume = 0;
        for(int i = 0; i < size; i++)
            totalVolume += bins[i].volume;
        if(totalVolume == 0) return false;

        // Legnagyobb volumenű bin (POC) megkeresése
        int pocIndex = 0;
        long maxVolume = bins[0].volume;
        for(int i = 1; i < size; i++)
        {
            if(bins[i].volume > maxVolume)
            {
                maxVolume = bins[i].volume;
                pocIndex = i;
            }
        }

        poc = (bins[pocIndex].priceStart + bins[pocIndex].priceEnd) / 2.0;

        // Kezdjük a value area-t a POC-kal
        int left = pocIndex, right = pocIndex;
        long areaVolume = bins[pocIndex].volume;

        while((100.0 * areaVolume / totalVolume) < percent)
        {
            long leftVol = (left > 0) ? bins[left - 1].volume : -1;
            long rightVol = (right < size - 1) ? bins[right + 1].volume : -1;

            if(leftVol >= rightVol)
            {
                if(left > 0) areaVolume += bins[--left].volume;
                else if(right < size - 1) areaVolume += bins[++right].volume;
                else break;
            }
            else
            {
                if(right < size - 1) areaVolume += bins[++right].volume;
                else if(left > 0) areaVolume += bins[--left].volume;
                else break;
            }
        }

        val = bins[left].priceStart;
        vah = bins[right].priceEnd;

        return true;
    }



void DrawValueAreaLines(double vah, double val, double poc)
    {
        string chartID = "ValueArea_";

        ObjectDelete(0, chartID + "VAH");
        ObjectDelete(0, chartID + "VAL");
        ObjectDelete(0, chartID + "POC");

        ObjectCreate(0, chartID + "VAH", OBJ_HLINE, 0, 0, vah);
        ObjectSetInteger(0, chartID + "VAH", OBJPROP_COLOR, clrGreen);
        ObjectSetInteger(0, chartID + "VAH", OBJPROP_WIDTH, 1);
        ObjectSetString(0, chartID + "VAH", OBJPROP_TEXT, "VAH");

        ObjectCreate(0, chartID + "VAL", OBJ_HLINE, 0, 0, val);
        ObjectSetInteger(0, chartID + "VAL", OBJPROP_COLOR, clrRed);
        ObjectSetInteger(0, chartID + "VAL", OBJPROP_WIDTH, 1);
        ObjectSetString(0, chartID + "VAL", OBJPROP_TEXT, "VAL");

        ObjectCreate(0, chartID + "POC", OBJ_HLINE, 0, 0, poc);
        ObjectSetInteger(0, chartID + "POC", OBJPROP_COLOR, clrYellow);
        ObjectSetInteger(0, chartID + "POC", OBJPROP_WIDTH, 2);
        ObjectSetString(0, chartID + "POC", OBJPROP_TEXT, "POC");
    }

void RemoveValueAreaLines() 
    {
        string chartID = "ValueArea_";
        ObjectDelete(0, chartID + "VAH");
        ObjectDelete(0, chartID + "VAL");
        ObjectDelete(0, chartID + "POC");
    }

bool ValueAreaProcess(ENUM_TIMEFRAMES vATf, double binSize, int percent)
    {
        Bin bins[];
        datetime startTime = iTime(_Symbol, vATf, 1);
        datetime endTime   = iTime(_Symbol, vATf, 0);
        if(CreateVolumeProfileBin(startTime, endTime, binSize, bins))
        {
            double vah, val, poc;
            if(CalculateValueArea(bins, percent, vah, val, poc))
                {
                    DrawValueAreaLines(vah, val, poc);
                    Print("VAL: ", val, "  VAH: ", vah, "  POC: ", poc);
                }
            else
                {
                    return false;
                }
        }
        else
        {
            return false;
        }

        return true;
    }

