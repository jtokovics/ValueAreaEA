//+------------------------------------------------------------------+
//|                                                        Panel.mqh |
//|                                            Copyright 2025, JoeyT |
//|                         https://github.com/jtokovics/ValueAreaEA |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, JoeyT"
#property link      "https://github.com/jtokovics/ValueAreaEA"

// === VARIABLES ===
//Button data
const int      Corner       = CORNER_RIGHT_UPPER;
const string   Font         = "Arial Bold";
const int      FontSize     = 12;
const int      BtnHeight    = 30;
const int      BtnWidth     = 150;

const color    BtnFontClr   = clrBlack;
const color    BtnBgClrA    = clrTeal;
const color    BtnBgClrB    = clrMediumVioletRed;

const string   BtnName1     = "BTN1";

bool           BtnState     = false;

//Panel data
const string   L00Name      = "LINE00";
const string   L01Name      = "LINE01";
const string   L02Name      = "LINE02";
const string   L03Name      = "LINE03";

//Position
const int      NulXPos      = 200;              
const int      NulYPos      = 10;               
const int      SpaceXPos    = 200;              
const int      SpaceYPos    = 12;     
const int      BtnSpace     = 30; 

const color    PnlClr       = clrDarkOrange;

//On/Off Btn
void CreateRunBtn()
   {
    ObjectDelete(0, BtnName1);
    ObjectCreate(0, BtnName1, OBJ_BUTTON, 0, 0, 0);
    ObjectSetInteger(0, BtnName1, OBJPROP_XDISTANCE, NulXPos);
    ObjectSetInteger(0, BtnName1, OBJPROP_YDISTANCE, NulYPos + BtnSpace);
    ObjectSetInteger(0, BtnName1, OBJPROP_XSIZE, BtnWidth);
    ObjectSetInteger(0, BtnName1, OBJPROP_YSIZE, BtnHeight);
    ObjectSetInteger(0, BtnName1, OBJPROP_CORNER, Corner);
    ObjectSetString(0, BtnName1, OBJPROP_FONT, Font);
    ObjectSetInteger(0, BtnName1, OBJPROP_FONTSIZE, FontSize);
    ObjectSetInteger(0, BtnName1, OBJPROP_COLOR, BtnFontClr);
   
   SetButtonState(BtnState);
   }

//Set button on button click
void SetButtonState(bool state)
   {
    BtnState = state;
      
    ObjectSetInteger(0, BtnName1, OBJPROP_STATE, BtnState);
    ObjectSetString(0, BtnName1, OBJPROP_TEXT, (BtnState?"ON":"OFF"));
    ObjectSetInteger(0, BtnName1, OBJPROP_BGCOLOR, (BtnState?BtnBgClrA:BtnBgClrB));
    ChartRedraw(0);
   }
   
void CreatePanel()
   {
    //Symbol
    ObjectDelete(0,L00Name);
    ObjectCreate(0,L00Name,OBJ_LABEL,0,0,0);
    ObjectSetInteger(0,L00Name,OBJPROP_CORNER,CORNER_RIGHT_UPPER);
    ObjectSetInteger(0,L00Name,OBJPROP_XDISTANCE,NulXPos);
    ObjectSetInteger(0,L00Name,OBJPROP_YDISTANCE,NulYPos + 5 * SpaceYPos);
    ObjectSetString(0, L00Name, OBJPROP_FONT, Font);
    ObjectSetInteger(0, L00Name, OBJPROP_FONTSIZE, FontSize);
    ObjectSetInteger(0, L00Name, OBJPROP_COLOR, PnlClr);
    ObjectSetString(0, L00Name, OBJPROP_TEXT, _Symbol); 

    //Expert Name
    ObjectDelete(0, L01Name);
    ObjectCreate(0, L01Name, OBJ_LABEL, 0, 0, 0);
    ObjectSetInteger(0,L01Name,OBJPROP_CORNER,CORNER_RIGHT_UPPER);
    ObjectSetInteger(0,L01Name,OBJPROP_XDISTANCE,NulXPos);
    ObjectSetInteger(0,L01Name,OBJPROP_YDISTANCE,NulYPos + 7 *SpaceYPos);
    ObjectSetString(0, L01Name, OBJPROP_FONT, Font);
    ObjectSetInteger(0, L01Name, OBJPROP_FONTSIZE, FontSize);
    ObjectSetInteger(0, L01Name, OBJPROP_COLOR, PnlClr);
    ObjectSetString(0, L01Name, OBJPROP_TEXT, "-");
            
    //Time
    ObjectDelete(0,L02Name);
    ObjectCreate(0,L02Name,OBJ_LABEL,0,0,0);
    ObjectSetInteger(0,L02Name,OBJPROP_CORNER,CORNER_RIGHT_UPPER);
    ObjectSetInteger(0,L02Name,OBJPROP_XDISTANCE,NulXPos);
    ObjectSetInteger(0,L02Name,OBJPROP_YDISTANCE,NulYPos + 9 *SpaceYPos);
    ObjectSetString(0, L02Name, OBJPROP_FONT, Font);
    ObjectSetInteger(0, L02Name, OBJPROP_FONTSIZE, FontSize);
    ObjectSetInteger(0, L02Name, OBJPROP_COLOR, PnlClr);
    ObjectSetString(0, L02Name, OBJPROP_TEXT, "-");
    
    //Trend
    ObjectDelete(0,L03Name);
    ObjectCreate(0,L03Name,OBJ_LABEL,0,0,0);
    ObjectSetInteger(0,L03Name,OBJPROP_CORNER,CORNER_RIGHT_UPPER);
    ObjectSetInteger(0,L03Name,OBJPROP_XDISTANCE,NulXPos);
    ObjectSetInteger(0,L03Name,OBJPROP_YDISTANCE,NulYPos + 12 *SpaceYPos);
    ObjectSetString(0, L03Name, OBJPROP_FONT, Font);
    ObjectSetInteger(0, L03Name, OBJPROP_FONTSIZE, FontSize);
    ObjectSetInteger(0, L03Name, OBJPROP_COLOR, PnlClr);
    ObjectSetString(0, L03Name, OBJPROP_TEXT, "-");
   }

void CreateGui()
   {
    CreateRunBtn();
    CreatePanel();
   }

void DeleteGui()
   {
    ObjectDelete(0,BtnName1);
    ObjectDelete(0,L00Name);
    ObjectDelete(0,L01Name);
    ObjectDelete(0,L02Name);
   }

void SetExpertName(string name)
   {
    ObjectSetString(0, L01Name, OBJPROP_TEXT, name);
   }

void SetTime(string time)
   {
    ObjectSetString(0, L02Name, OBJPROP_TEXT, time);
   }

void SetTrend(string trend)
   {
    ObjectSetString(0, L03Name, OBJPROP_TEXT, trend);
   }