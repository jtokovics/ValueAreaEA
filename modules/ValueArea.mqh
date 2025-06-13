//+------------------------------------------------------------------+
//|                                                    ValueArea.mqh |
//|                                            Copyright 2025, JoeyT |
//|                         https://github.com/jtokovics/ValueAreaEA |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, JoeyT"
#property link      "https://github.com/jtokovics/ValueAreaEA"

// Struct to hold volume profile bin data
struct Bin
{
    double priceStart; // Start price of the bin
    double priceEnd;   // End price of the bin
    long volume;    // Volume of trades in this bin
}

// Create a volume profile for a given day
bool CreateVolumeProfileBin(datetime dayStart, datetime dayEnd, double binSize, CArrayOby &bins)
{
    int totalBars = iBars(_Symbol, PERIOD_M1);
    if(totalBars <= 0) return false;

    bins.Clear();
    
    // Calculate the lowest and highest prices within the day
    double lowest = DBL_MAX, highest = DBL_MIN;

    for(int i = totalBars - 1; i >= 0; i--)
    {
        datetime t = iTime(_Symbol, PERIOD_M1, i);
        if(t < dayStart) break;
        if(t >= dayStart && t < dayEnd)
        {
            double high = iHigh(_Symbol, PERIOD_M1, i);
            double low = iLow(_Symbol, PERIOD_M1, i);
            if(high > highest) highest = high;
            if(low < lowest) lowest = low;
        }
    }

    if(lowest == DBL_MAX || highest == DBL_MIN) return false;
    int binCount = (int)MathCeil((highest - lowest) / binSize);
    for(int i = 0; i < binCount; i++)
    {
        Bin *b = new Bin;
        b.priceStart = lowest + i * binSize;
        b.priceEnd = b.priceStart + binSize;
        b.volume = 0;
        bins.Add(b);
    }

    // Populate the bins with volume data
    for(int i = totalBars - 1; i >= 0; i--)
    {
        datetime t = iTime(_Symbol, PERIOD_M1, i);
        if(t < dayStart) break;
        if(t >= dayStart && t < dayEnd)
        {
            double close = iClose(_Symbol, PERIOD_M1, i);
            long volume = (long)iVolume(_Symbol, PERIOD_M1, i);

            int binIndex = (int)MathFloor((close - lowest) / binSize);
            if(binIndex >= 0 && binIndex < bins.Total())
                {
                    Bin *b = (Bin *)bins.At(binIndex);
                    b.volume += volume;
                }
        }
    }

    return true;
}













bool CalculateValueArea(datetime day, double binSize, int percent, double &vah, double &val, double &poc)
    {
    // Calculate the start and end of the day
    }
