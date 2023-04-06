//+------------------------------------------------------------------+
//|                                           UniversalIndicator.mqh |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

enum INDICATOR
  {
    
     //Trend
     Moving_Average,//Moving Average
     Bollinger_Bands,//Bollinger Bands
     Ichimoku,//Ichimoku Kinko Hyo
     PSAR,//Parabolic SAR
     
     
     //Oscillators
     RSI,
     Stochastic,
     MACD,
     WPR,
     RVI,
     CCI
     
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CUniversalIndicator
  {

protected:
   string            file;
   double            value;

public:
   void              SetFile(string indicatorName);
   string            GetFile();
   double            GetValue(int bufferNum, int shift,string inputs);
   double            GetValue(INDICATOR ind,int bufferNum,int shift,int period=14,ENUM_APPLIED_PRICE price=PRICE_CLOSE,ENUM_MA_METHOD mode=MODE_SMA,double dev=2);
   

  };


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CUniversalIndicator::SetFile(string indicatorName)
  {
   file = indicatorName+".ex4";
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CUniversalIndicator::GetValue(int bufferNum, int shift, string inputs)
  {

   double inp1=0,inp2=0,inp3=0,inp4=0,inp5=0,inp6=0,inp7=0,inp8=0,inp9=0,inp10=0;
   string comma = ",";

   ushort sep = StringGetCharacter(comma,0);

   string params[];

   ArrayResize(params,StringLen(inputs),0);

   StringSplit(inputs,sep,params);

   if(ArraySize(params)==1)
     {
      inp1 = (double)StringTrimLeft(StringTrimRight(params[0]));
      value = iCustom(_Symbol,_Period,file,inp1,bufferNum,shift);
     }

   if(ArraySize(params)==2)
     {
      inp1 = (double)StringTrimLeft(StringTrimRight(params[0]));
      inp2 = (double)StringTrimLeft(StringTrimRight(params[1]));
      value = iCustom(_Symbol,_Period,file,inp1,inp2,bufferNum,shift);
     }

   if(ArraySize(params)==3)
     {
      inp1 = (double)StringTrimLeft(StringTrimRight(params[0]));
      inp2 = (double)StringTrimLeft(StringTrimRight(params[1]));
      inp3 = (double)StringTrimLeft(StringTrimRight(params[2]));
      value = iCustom(_Symbol,_Period,file,inp1,inp2,inp3,bufferNum,shift);
     }

   if(ArraySize(params)==4)
     {
      inp1 = (double)StringTrimLeft(StringTrimRight(params[0]));
      inp2 = (double)StringTrimLeft(StringTrimRight(params[1]));
      inp3 = (double)StringTrimLeft(StringTrimRight(params[2]));
      inp4 = (double)StringTrimLeft(StringTrimRight(params[3]));
      value = iCustom(_Symbol,_Period,file,inp1,inp2,inp3,inp4,bufferNum,shift);
     }

   if(ArraySize(params)==5)
     {
      inp1 = (double)StringTrimLeft(StringTrimRight(params[0]));
      inp2 = (double)StringTrimLeft(StringTrimRight(params[1]));
      inp3 = (double)StringTrimLeft(StringTrimRight(params[2]));
      inp4 = (double)StringTrimLeft(StringTrimRight(params[3]));
      inp5 = (double)StringTrimLeft(StringTrimRight(params[4]));
      value = iCustom(_Symbol,_Period,file,inp1,inp2,inp3,inp4,inp5,bufferNum,shift);
     }

   if(ArraySize(params)==6)
     {
      inp1 = (double)StringTrimLeft(StringTrimRight(params[0]));
      inp2 = (double)StringTrimLeft(StringTrimRight(params[1]));
      inp3 = (double)StringTrimLeft(StringTrimRight(params[2]));
      inp4 = (double)StringTrimLeft(StringTrimRight(params[3]));
      inp5 = (double)StringTrimLeft(StringTrimRight(params[4]));
      inp6 = (double)StringTrimLeft(StringTrimRight(params[5]));
      value = iCustom(_Symbol,_Period,file,inp1,inp2,inp3,inp4,inp5,inp6,bufferNum,shift);
     }

   if(ArraySize(params)==7)
     {
      inp1 = (double)StringTrimLeft(StringTrimRight(params[0]));
      inp2 = (double)StringTrimLeft(StringTrimRight(params[1]));
      inp3 = (double)StringTrimLeft(StringTrimRight(params[2]));
      inp4 = (double)StringTrimLeft(StringTrimRight(params[3]));
      inp5 = (double)StringTrimLeft(StringTrimRight(params[4]));
      inp6 = (double)StringTrimLeft(StringTrimRight(params[5]));
      inp7 = (double)StringTrimLeft(StringTrimRight(params[6]));
      value = iCustom(_Symbol,_Period,file,inp1,inp2,inp3,inp4,inp5,inp6,inp7,bufferNum,shift);
     }

   if(ArraySize(params)==8)
     {
      inp1 = (double)StringTrimLeft(StringTrimRight(params[0]));
      inp2 = (double)StringTrimLeft(StringTrimRight(params[1]));
      inp3 = (double)StringTrimLeft(StringTrimRight(params[2]));
      inp4 = (double)StringTrimLeft(StringTrimRight(params[3]));
      inp5 = (double)StringTrimLeft(StringTrimRight(params[4]));
      inp6 = (double)StringTrimLeft(StringTrimRight(params[5]));
      inp7 = (double)StringTrimLeft(StringTrimRight(params[6]));
      inp8 = (double)StringTrimLeft(StringTrimRight(params[7]));
      value = iCustom(_Symbol,_Period,file,inp1,inp2,inp3,inp4,inp5,inp6,inp7,inp8,bufferNum,shift);
     }

   if(ArraySize(params)==9)
     {
      inp1 = (double)StringTrimLeft(StringTrimRight(params[0]));
      inp2 = (double)StringTrimLeft(StringTrimRight(params[1]));
      inp3 = (double)StringTrimLeft(StringTrimRight(params[2]));
      inp4 = (double)StringTrimLeft(StringTrimRight(params[3]));
      inp5 = (double)StringTrimLeft(StringTrimRight(params[4]));
      inp6 = (double)StringTrimLeft(StringTrimRight(params[5]));
      inp7 = (double)StringTrimLeft(StringTrimRight(params[6]));
      inp8 = (double)StringTrimLeft(StringTrimRight(params[7]));
      inp9 = (double)StringTrimLeft(StringTrimRight(params[8]));
      value = iCustom(_Symbol,_Period,file,inp1,inp2,inp3,inp4,inp5,inp6,inp7,inp8,inp9,bufferNum,shift);
     }

   if(ArraySize(params)==10)
     {
      inp1 = (double)StringTrimLeft(StringTrimRight(params[0]));
      inp2 = (double)StringTrimLeft(StringTrimRight(params[1]));
      inp3 = (double)StringTrimLeft(StringTrimRight(params[2]));
      inp4 = (double)StringTrimLeft(StringTrimRight(params[3]));
      inp5 = (double)StringTrimLeft(StringTrimRight(params[4]));
      inp6 = (double)StringTrimLeft(StringTrimRight(params[5]));
      inp7 = (double)StringTrimLeft(StringTrimRight(params[6]));
      inp8 = (double)StringTrimLeft(StringTrimRight(params[7]));
      inp9 = (double)StringTrimLeft(StringTrimRight(params[8]));
      inp10 = (double)StringTrimLeft(StringTrimRight(params[9]));
      value = iCustom(_Symbol,_Period,file,inp1,inp2,inp3,inp4,inp5,inp6,inp7,inp8,inp9,inp10,bufferNum,shift);
     }



   Print(params[0]);

   return(value);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CUniversalIndicator::GetValue(INDICATOR ind,int bufferNum,int shift,int period=14,ENUM_APPLIED_PRICE price=PRICE_CLOSE,ENUM_MA_METHOD mode=MODE_SMA,double dev=2)
  {
   switch(ind)
     {
      case Moving_Average:
        value = iMA(_Symbol,_Period,period,0,mode,price,shift);
        break;
      
      case Bollinger_Bands:
        value = iBands(_Symbol,_Period,period,dev,0,price,bufferNum,shift);
        break;
      
      case Ichimoku:
         value = iIchimoku(_Symbol,_Period,9,26,52,bufferNum,shift);
         break;
      
      case PSAR:
         value = iSAR(_Symbol,_Period,0.02,0.2,shift);
         break;
      
      case RSI:
         value = iRSI(_Symbol,_Period,period,price,shift);
         break;
         
      case Stochastic:
         value = iStochastic(_Symbol,_Period,18,3,3,mode,STO_LOWHIGH,bufferNum,shift);
         break;
         
      case MACD:
         value = iMACD(_Symbol,_Period,12,26,9,price,bufferNum,shift);
         break;
         
      case WPR:
         value = iWPR(_Symbol,_Period,period,shift);
         break;
      
      case RVI:
         value = iRVI(_Symbol,_Period,period,bufferNum,shift);
         break;
      
      case CCI:
         value = iCCI(_Symbol,_Period,period,price,shift);
      default:
        break;
     }

   return(value);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CUniversalIndicator::GetFile()
  {
   return(file);
  }



