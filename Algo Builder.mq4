//+------------------------------------------------------------------+
//|                                        Algo Builder.mq4 |
//|                                           Copyright 2022,Oluyemi Sodipo |
//|                                             https://www.jarvistrade.io |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021,www.javistrade.io"
#property link      "https://www.jarvistrade.io"
#property version   "1.00"
#property strict
#include <UniversalIndicator.mqh>

CUniversalIndicator Ind01;
CUniversalIndicator Ind02;
CUniversalIndicator Ind03;
CUniversalIndicator Ind04;
CUniversalIndicator Ind05;
CUniversalIndicator Ind06;
CUniversalIndicator Ind07;
CUniversalIndicator Ind08;


enum ALGO_SWITCH
  {
   on,
   off
  };

enum INDICATOR_TYPE
  {
   Custom,
   Inbuilt
  };

enum SIGNAL_TYPE
  {
//Inbuilt
   DYNAMIC,//DYANMIC SIGNALS
   MA_Cross,
   BollingerBreakout,
   BollingerMeanReversion,
   IchimokuBreakout,
   PSARSignal,
   RSIBreakout,
   RSIReversal,
   StochasticBreakout,
   StochasticReversal,
   MACDZeroLineCross,
   MACDTwoLineCross,
   WPRBreakout,
   WPRReversal,
   RVIZeroLineCross,
   RVITwoLineCross,
   CCICross,
   CandleCrossBuf1,//Candle crossing Buffer1
   CandleCrossBuf2,//Candle crossing Buffer2
   Buf1CrossBuf2,//Buffer1 crossing Buffer2
   Buf1CrossZero,//Buffer1 crossing zero line
   Buf2CrossZero,//Buffer2 crossing zero line
   BuffersCrossThresholds,//Buffers crossing threshold
   space,//===========================================
   space2,//===========================================


//Above/Below
   STATIC,//STATIC SIGNALS
   BollingerTrendSetUp,//Bollinger Trend Setup
   BollingerReversalSetUp,
   PSARSetup,//PSAR Static
   RSITrendSetup,//RSI Trend Setup
   RSIReversalSetup,//RSI Reversal Setup
   StochasticTrendSetup,//Stochastic Trend Setup
   StochasticReversalSetup,//Stochastic Reversal Setup
   MACDAboveZero,//MACD Above/Below Zero
   MACDMainAboveSignal,//MACD Main line above/below signal line
   WPRTrendSetup,//WPR Trend Setup
   WPRReversalSetup,//WPR Reversal Setup
   RVIAboveZero,//RVI above zero line
   RVIMainAboveSignal,//RVI main line above/below signal line
   CCISetup,//CCI Setup
   CandleAboveBuf1,//Candle above/below Buffer1
   CandleAboveBuf2,//Candle above/below Buffer2
   Buf1AboveBuf2,//Buffer1 above/below Buffer2
   Buf1AboveZero,//Buffer1 above/below zero line
   Buf2AboveZero,//Buffer2 above/below zero line
   Buf1AboveThreshold,//Buffer1 above/below threshold
   Buf2AboveThreshold,//Buffer2 above/below threshold

//Non-Empty
   NonEmptyBuffer,//Buffer 1/2 is non-empty,non-zero

//Volume
   NeuBufAboveZero,//Neutral Buffer Above zero line
   NeuBufAboveThreshold//Neutral buffer above threshold



  };
input string InpSep9 = "";//...
input string InpSep10 = "TRADE INPUTS<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
input int    InpMaxTrades = 1;//Maximum Number Of Trades
input string InpSep11 = "";//...
input string InpSep12 = "GENERAL INPUTS<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
input double InpUpperThreshold = 70;//Upper Threshold
input double InpLowerThreshold = 30;//Lower Threshold
input string InpSep1 = "";//...
input string InpSep5 = "ALGO PIECE ONE<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
input ALGO_SWITCH InpSwitch1 = on;//Algo 1 On/Off
input INDICATOR_TYPE InpIndType1 = Custom;//Indicator Type 1
input string InpInd1 = "Aroon";//Custom Indicator File
input string InpParams1 = "14";//Custom Indicator Input parameters
input int    InpBuf01 = 0;//Custom Buffer 1
input int    InpBuf02 = 1;//Custom Buffer 2
input SIGNAL_TYPE InpSignal1 = CandleCrossBuf1;//Entry rule 1

input string InpSep2 = "";//...
input string InpSep6 = "ALGO PIECE TWO<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
input ALGO_SWITCH InpSwitch2 = on;//Algo 2 On/Off
input INDICATOR_TYPE InpIndType2 = Custom;//Indicator Type 2
input string InpInd2 = "Aroon";//Custom Indicator File
input string InpParams2 = "14";//Custom Input parameters
input int    InpBuf11 = 0;//Custom Buffer 1
input int    InpBuf12 = 1;//Custom Buffer 2
input SIGNAL_TYPE InpSignal2 = Buf1AboveBuf2;//Entry rule 2

input string InpSep3 = "";//...
input string InpSep7 = "ALGO PIECE THREE<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
input ALGO_SWITCH InpSwitch3 = on;//Algo 3 On/Off
input INDICATOR_TYPE InpIndType3 = Custom;//Indicator Type 3
input string InpInd3 = "Aroon";//Custom Indicator File
input string InpParams3 = "14";//Custom Input parameters
input int    InpBuf21 = 0;//Custom Buffer 1
input int    InpBuf22 = 1;//Custom Buffer 2
input SIGNAL_TYPE InpSignal3 = Buf1AboveBuf2;//Entry rule 3

input string InpSep4 = "";//...
input string InpSep8 = "ALGO PIECE FOUR<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
input ALGO_SWITCH InpSwitch4 = on;//Algo 4 On/Off
input INDICATOR_TYPE InpIndType4 = Custom;//Indicator Type 4
input string InpInd4 = "Aroon";//Custom Indicator File
input string InpParams4 = "14";//Input parameters
input int    InpBuf31 = 0;//Buffer 1
input int    InpBuf32 = 1;//Buffer 2
input SIGNAL_TYPE InpSignal4 = Buf1AboveZero;//Entry rule 4



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {



   if(InpIndType1==Custom)
      Ind01.SetFile(InpInd1);

   if(InpIndType2==Custom)
      Ind02.SetFile(InpInd2);

   if(InpIndType3==Custom)
      Ind03.SetFile(InpInd3);

   if(InpIndType4==Custom)
      Ind04.SetFile(InpInd4);


   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {


  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {

   bool isBuy1=false, isBuy2=false, isBuy3=false, isBuy4=false, isSell1=false, isSell2=false, isSell3=false, isSell4=false;

   if(InpIndType1==Custom)
     {
      //Indicator 1
      double ind01     = Ind01.GetValue(InpBuf01,1,InpParams1);
      double ind02     = Ind01.GetValue(InpBuf02,1,InpParams1);
      double ind01prev = Ind01.GetValue(InpBuf01,2,InpParams1);
      double ind02prev = Ind01.GetValue(InpBuf02,2,InpParams1);

      //BUY
      isBuy1 = InpSignal1==CandleCrossBuf1 ? HasCandleCrossedBufferUp(ind01,ind01prev) :
               InpSignal1==CandleCrossBuf2 ? HasCandleCrossedBufferUp(ind02,ind02prev) :
               InpSignal1==Buf1CrossBuf2   ? HasBuffer1CrossedBuffer2Up(ind01,ind01prev,ind02,ind02prev):
               InpSignal1==Buf1CrossZero   ? HasBufferCrossedZeroUp(ind01,ind01prev):
               InpSignal1==Buf2CrossZero   ? HasBufferCrossedZeroUp(ind02,ind02prev):
               InpSignal1==BuffersCrossThresholds ? HasBufferCrossedUpperThreshold(ind01,ind01prev,-20):
               InpSignal1==CandleAboveBuf1 ? IsCandleAboveBuffer(ind01):
               InpSignal1==CandleAboveBuf2 ? IsCandleAboveBuffer(ind02):
               InpSignal1==Buf1AboveBuf2   ? IsBuffer1AboveBuffer2(ind01,ind02):
               InpSignal1==Buf1AboveZero   ? IsBufferAboveZero(ind01):
               InpSignal1==Buf2AboveZero   ? IsBufferAboveZero(ind02):
               InpSignal1==Buf1AboveThreshold ? IsBufferAboveThreshold(ind01,-20):
               InpSignal1==Buf2AboveThreshold ? IsBufferAboveThreshold(ind02,-20):
               InpSignal1==NeuBufAboveZero ? IsNeutralBufferAboveZero(ind01) :
               InpSignal1==NeuBufAboveThreshold ? IsNeutralBufferAboveThreshold(ind01,ind02) :
               InpSignal1==NonEmptyBuffer ? IsNonEmpty(ind01) : 0;

      //SELL
      isSell1 = InpSignal1==CandleCrossBuf1 ? HasCandleCrossedBufferDn(ind01,ind01prev) :
                InpSignal1==CandleCrossBuf2 ? HasCandleCrossedBufferDn(ind02,ind02prev) :
                InpSignal1==Buf1CrossBuf2   ? HasBuffer1CrossedBuffer2Dn(ind01,ind01prev,ind02,ind02prev):
                InpSignal1==Buf1CrossZero   ? HasBufferCrossedZeroDn(ind01,ind01prev):
                InpSignal1==Buf2CrossZero   ? HasBufferCrossedZeroDn(ind02,ind02prev):
                InpSignal1==BuffersCrossThresholds ? HasBufferCrossedLowerThreshold(ind02,ind02prev,-80):
                InpSignal1==CandleAboveBuf1 ? IsCandleBelowBuffer(ind01):
                InpSignal1==CandleAboveBuf2 ? IsCandleBelowBuffer(ind02):
                InpSignal1==Buf1AboveBuf2   ? IsBuffer1BelowBuffer2(ind01,ind02):
                InpSignal1==Buf1AboveZero   ? IsBufferBelowZero(ind01):
                InpSignal1==Buf2AboveZero   ? IsBufferBelowZero(ind02):
                InpSignal1==Buf1AboveThreshold ? IsBufferBelowThreshold(ind01,-80):
                InpSignal1==Buf2AboveThreshold ? IsBufferBelowThreshold(ind02,-80):
                InpSignal1==NeuBufAboveZero ? IsNeutralBufferAboveZero(ind01) :
                InpSignal1==NeuBufAboveThreshold ? IsNeutralBufferAboveThreshold(ind01,ind02) :
                InpSignal1==NonEmptyBuffer ? IsNonEmpty(ind02) : 0;
     }


   if(InpIndType2==Custom)
     {
      //Indicator 2
      double ind11     = Ind02.GetValue(InpBuf11,1,InpParams2);
      double ind12     = Ind02.GetValue(InpBuf12,1,InpParams2);
      double ind11prev = Ind02.GetValue(InpBuf11,2,InpParams2);
      double ind12prev = Ind02.GetValue(InpBuf12,2,InpParams2);

      isBuy2 = InpSignal2==CandleCrossBuf1 ? HasCandleCrossedBufferUp(ind11,ind11prev) :
               InpSignal2==CandleCrossBuf2 ? HasCandleCrossedBufferUp(ind12,ind12prev) :
               InpSignal2==Buf1CrossBuf2   ? HasBuffer1CrossedBuffer2Up(ind11,ind11prev,ind12,ind12prev):
               InpSignal2==Buf1CrossZero   ? HasBufferCrossedZeroUp(ind11,ind11prev):
               InpSignal2==Buf2CrossZero   ? HasBufferCrossedZeroUp(ind12,ind12prev):
               InpSignal2==BuffersCrossThresholds ? HasBufferCrossedUpperThreshold(ind11,ind11prev,-20):
               InpSignal2==CandleAboveBuf1 ? IsCandleAboveBuffer(ind11):
               InpSignal2==CandleAboveBuf2 ? IsCandleAboveBuffer(ind12):
               InpSignal2==Buf1AboveBuf2   ? IsBuffer1AboveBuffer2(ind11,ind12):
               InpSignal2==Buf1AboveZero   ? IsBufferAboveZero(ind11):
               InpSignal2==Buf2AboveZero   ? IsBufferAboveZero(ind12):
               InpSignal2==Buf1AboveThreshold ? IsBufferAboveThreshold(ind11,-20):
               InpSignal2==Buf2AboveThreshold ? IsBufferAboveThreshold(ind12,-20):
               InpSignal2==NeuBufAboveZero ? IsNeutralBufferAboveZero(ind11) :
               InpSignal2==NeuBufAboveThreshold ? IsNeutralBufferAboveThreshold(ind11,ind12) :
               InpSignal2==NonEmptyBuffer ? IsNonEmpty(ind11) : 0;

      isSell2 = InpSignal2==CandleCrossBuf1 ? HasCandleCrossedBufferDn(ind11,ind11prev) :
                InpSignal2==CandleCrossBuf2 ? HasCandleCrossedBufferDn(ind12,ind12prev) :
                InpSignal2==Buf1CrossBuf2   ? HasBuffer1CrossedBuffer2Dn(ind11,ind11prev,ind12,ind12prev):
                InpSignal2==Buf1CrossZero   ? HasBufferCrossedZeroDn(ind11,ind11prev):
                InpSignal2==Buf2CrossZero   ? HasBufferCrossedZeroDn(ind12,ind12prev):
                InpSignal2==BuffersCrossThresholds ? HasBufferCrossedLowerThreshold(ind12,ind12prev,-80):
                InpSignal2==CandleAboveBuf1 ? IsCandleBelowBuffer(ind11):
                InpSignal2==CandleAboveBuf2 ? IsCandleBelowBuffer(ind12):
                InpSignal2==Buf1AboveBuf2   ? IsBuffer1BelowBuffer2(ind11,ind12):
                InpSignal2==Buf1AboveZero   ? IsBufferBelowZero(ind11):
                InpSignal2==Buf2AboveZero   ? IsBufferBelowZero(ind12):
                InpSignal2==Buf1AboveThreshold ? IsBufferBelowThreshold(ind11,-80):
                InpSignal2==Buf2AboveThreshold ? IsBufferBelowThreshold(ind12,-80):
                InpSignal2==NeuBufAboveZero ? IsNeutralBufferAboveZero(ind11) :
                InpSignal2==NeuBufAboveThreshold ? IsNeutralBufferAboveThreshold(ind11,ind12) :
                InpSignal1==NonEmptyBuffer ? IsNonEmpty(ind12) : 0;

     }


   if(InpIndType3==Custom)
     {
      //Indicator 3
      double ind21     = Ind03.GetValue(InpBuf21,1,InpParams3);
      double ind22     = Ind03.GetValue(InpBuf22,1,InpParams3);
      double ind21prev = Ind03.GetValue(InpBuf21,2,InpParams3);
      double ind22prev = Ind03.GetValue(InpBuf22,2,InpParams3);

      isBuy3 = InpSignal3==CandleCrossBuf1 ? HasCandleCrossedBufferUp(ind21,ind21prev) :
               InpSignal3==CandleCrossBuf2 ? HasCandleCrossedBufferUp(ind22,ind22prev) :
               InpSignal3==Buf1CrossBuf2   ? HasBuffer1CrossedBuffer2Up(ind21,ind21prev,ind22,ind22prev):
               InpSignal3==Buf1CrossZero   ? HasBufferCrossedZeroUp(ind21,ind21prev):
               InpSignal3==Buf2CrossZero   ? HasBufferCrossedZeroUp(ind22,ind22prev):
               InpSignal3==BuffersCrossThresholds ? HasBufferCrossedUpperThreshold(ind21,ind21prev,-20):
               InpSignal3==CandleAboveBuf1 ? IsCandleAboveBuffer(ind21):
               InpSignal3==CandleAboveBuf2 ? IsCandleAboveBuffer(ind22):
               InpSignal3==Buf1AboveBuf2   ? IsBuffer1AboveBuffer2(ind21,ind22):
               InpSignal3==Buf1AboveZero   ? IsBufferAboveZero(ind21):
               InpSignal3==Buf2AboveZero   ? IsBufferAboveZero(ind22):
               InpSignal3==Buf1AboveThreshold ? IsBufferAboveThreshold(ind21,-20):
               InpSignal3==Buf2AboveThreshold ? IsBufferAboveThreshold(ind22,-20):
               InpSignal3==NeuBufAboveZero ? IsNeutralBufferAboveZero(ind21) :
               InpSignal3==NeuBufAboveThreshold ? IsNeutralBufferAboveThreshold(ind21,ind22) :
               InpSignal1==NonEmptyBuffer ? IsNonEmpty(ind21) : 0;

      isSell3 = InpSignal3==CandleCrossBuf1 ? HasCandleCrossedBufferDn(ind21,ind21prev) :
                InpSignal3==CandleCrossBuf2 ? HasCandleCrossedBufferDn(ind22,ind22prev) :
                InpSignal3==Buf1CrossBuf2   ? HasBuffer1CrossedBuffer2Dn(ind21,ind21prev,ind22,ind22prev):
                InpSignal3==Buf1CrossZero   ? HasBufferCrossedZeroDn(ind21,ind21prev):
                InpSignal3==Buf2CrossZero   ? HasBufferCrossedZeroDn(ind22,ind22prev):
                InpSignal3==BuffersCrossThresholds ? HasBufferCrossedLowerThreshold(ind22,ind22prev,-80):
                InpSignal3==CandleAboveBuf1 ? IsCandleBelowBuffer(ind21):
                InpSignal3==CandleAboveBuf2 ? IsCandleBelowBuffer(ind22):
                InpSignal3==Buf1AboveBuf2   ? IsBuffer1BelowBuffer2(ind21,ind22):
                InpSignal3==Buf1AboveZero   ? IsBufferBelowZero(ind21):
                InpSignal3==Buf2AboveZero   ? IsBufferBelowZero(ind22):
                InpSignal3==Buf1AboveThreshold ? IsBufferBelowThreshold(ind21,-80):
                InpSignal3==Buf2AboveThreshold ? IsBufferBelowThreshold(ind22,-80):
                InpSignal3==NeuBufAboveZero ? IsNeutralBufferAboveZero(ind21) :
                InpSignal3==NeuBufAboveThreshold ? IsNeutralBufferAboveThreshold(ind21,ind22) :
                InpSignal1==NonEmptyBuffer ? IsNonEmpty(ind22) : 0;
     }


   if(InpIndType4==Custom)
     {

      double ind31     = Ind04.GetValue(InpBuf31,1,InpParams4);
      double ind32     = Ind04.GetValue(InpBuf32,1,InpParams4);
      double ind31prev = Ind04.GetValue(InpBuf31,2,InpParams4);
      double ind32prev = Ind04.GetValue(InpBuf32,2,InpParams4);

      isBuy4 =    InpSignal4==CandleCrossBuf1 ? HasCandleCrossedBufferUp(ind31,ind31prev) :
                  InpSignal4==CandleCrossBuf2 ? HasCandleCrossedBufferUp(ind32,ind32prev) :
                  InpSignal4==Buf1CrossBuf2   ? HasBuffer1CrossedBuffer2Up(ind31,ind31prev,ind32,ind32prev):
                  InpSignal4==Buf1CrossZero   ? HasBufferCrossedZeroUp(ind31,ind31prev):
                  InpSignal4==Buf2CrossZero   ? HasBufferCrossedZeroUp(ind32,ind32prev):
                  InpSignal4==BuffersCrossThresholds ? HasBufferCrossedUpperThreshold(ind31,ind31prev,-20):
                  InpSignal4==CandleAboveBuf1 ? IsCandleAboveBuffer(ind31):
                  InpSignal4==CandleAboveBuf2 ? IsCandleAboveBuffer(ind32):
                  InpSignal4==Buf1AboveBuf2   ? IsBuffer1AboveBuffer2(ind31,ind32):
                  InpSignal4==Buf1AboveZero   ? IsBufferAboveZero(ind31):
                  InpSignal4==Buf2AboveZero   ? IsBufferAboveZero(ind32):
                  InpSignal4==Buf1AboveThreshold ? IsBufferAboveThreshold(ind31,-20):
                  InpSignal4==Buf2AboveThreshold ? IsBufferAboveThreshold(ind32,-20):
                  InpSignal4==NeuBufAboveZero ? IsNeutralBufferAboveZero(ind31) :
                  InpSignal4==NeuBufAboveThreshold ? IsNeutralBufferAboveThreshold(ind31,ind32) :
                  InpSignal1==NonEmptyBuffer ? IsNonEmpty(ind31) : 0;


      isSell4 =    InpSignal4==CandleCrossBuf1 ? HasCandleCrossedBufferDn(ind31,ind31prev) :
                   InpSignal4==CandleCrossBuf2 ? HasCandleCrossedBufferDn(ind32,ind32prev) :
                   InpSignal4==Buf1CrossBuf2   ? HasBuffer1CrossedBuffer2Dn(ind31,ind31prev,ind32,ind32prev):
                   InpSignal4==Buf1CrossZero   ? HasBufferCrossedZeroDn(ind31,ind31prev):
                   InpSignal4==Buf2CrossZero   ? HasBufferCrossedZeroDn(ind32,ind32prev):
                   InpSignal4==BuffersCrossThresholds ? HasBufferCrossedLowerThreshold(ind32,ind32prev,-80):
                   InpSignal4==CandleAboveBuf1 ? IsCandleBelowBuffer(ind31):
                   InpSignal4==CandleAboveBuf2 ? IsCandleBelowBuffer(ind32):
                   InpSignal4==Buf1AboveBuf2   ? IsBuffer1BelowBuffer2(ind31,ind32):
                   InpSignal4==Buf1AboveZero   ? IsBufferBelowZero(ind31):
                   InpSignal4==Buf2AboveZero   ? IsBufferBelowZero(ind32):
                   InpSignal4==Buf1AboveThreshold ? IsBufferBelowThreshold(ind31,-80):
                   InpSignal4==Buf2AboveThreshold ? IsBufferBelowThreshold(ind32,-80):
                   InpSignal4==NeuBufAboveZero ? IsNeutralBufferAboveZero(ind31) :
                   InpSignal4==NeuBufAboveThreshold ? IsNeutralBufferAboveThreshold(ind31,ind32) :
                   InpSignal1==NonEmptyBuffer ? IsNonEmpty(ind32) : 0;

     }


//IN-BUILT
//IN-BUILT INDICATOR 1
   if(InpIndType1==Inbuilt)
     {
      double MA = Ind05.GetValue(Moving_Average,0,1,21);
      double MA_Prev = Ind05.GetValue(Moving_Average,0,2,21,PRICE_CLOSE,MODE_SMA);
      double UpperBol = Ind05.GetValue(Bollinger_Bands,1,1,20,PRICE_CLOSE,MODE_SMA,2);
      double LowerBol = Ind05.GetValue(Bollinger_Bands,2,1,20,PRICE_CLOSE,MODE_SMA,2);
      double UpperBolPrev = Ind05.GetValue(Bollinger_Bands,1,2,20,PRICE_CLOSE,MODE_SMA,2);
      double LowerBolPrev = Ind05.GetValue(Bollinger_Bands,2,2,20,PRICE_CLOSE,MODE_SMA,2);
      double SenkouA    = Ind05.GetValue(Ichimoku,2,1);
      double SenkouB    = Ind05.GetValue(Ichimoku,3,1);
      double SenkouAPrev    = Ind05.GetValue(Ichimoku,2,2);
      double SenkouBPrev    = Ind05.GetValue(Ichimoku,3,2);
      double PSARCurrent    = Ind05.GetValue(PSAR,0,1);
      double PSARPrev       = Ind05.GetValue(PSAR,0,2);
      double RSICurrent     = iRSI(_Symbol,_Period,14,PRICE_CLOSE,1);//Ind05.GetValue(RSI,0,1,14);
      double RSIPrev        = iRSI(_Symbol,_Period,14,PRICE_CLOSE,2);//Ind05.GetValue(RSI,0,2,14);
      double StochCurrent   = Ind05.GetValue(Stochastic,0,1,14);
      double StochPrev      = Ind05.GetValue(Stochastic,0,2,14);
      double MACDCurrent    = Ind05.GetValue(MACD,0,1,14,PRICE_CLOSE,MODE_SMA,2);
      double MACDPrev       = Ind05.GetValue(MACD,0,2,14,PRICE_CLOSE,MODE_SMA,2);
      double MACDSignalCurrent    = Ind05.GetValue(MACD,1,1,14,PRICE_CLOSE,MODE_SMA,2);
      double MACDSignalPrev       = Ind05.GetValue(MACD,1,2,14,PRICE_CLOSE,MODE_SMA,2);
      double WPRCurrent           = Ind05.GetValue(WPR,0,1,14);
      double WPRPrev              = Ind05.GetValue(WPR,0,2,14);
      double RVICurrent           = Ind05.GetValue(RVI,0,1,14);
      double RVIPrev              = Ind05.GetValue(RVI,0,2,14);
      double RVISignalCurrent           = Ind05.GetValue(RVI,1,1,14);
      double RVISignalPrev              = Ind05.GetValue(RVI,1,2,14);
      double CCICurrent           = Ind05.GetValue(CCI,0,1,14);
      double CCIPrev              = Ind05.GetValue(CCI,0,2,14);

      isBuy1 = InpSignal1==MA_Cross ? HasCandleCrossedBufferUp(MA,MA_Prev):
               InpSignal1==BollingerBreakout ? HasCandleCrossedBufferUp(UpperBol,UpperBolPrev) :
               InpSignal1==BollingerMeanReversion ? HasCandleCrossedBufferDn(LowerBol,LowerBolPrev) :
               InpSignal1==BollingerTrendSetUp ? IsCandleAboveBuffer(UpperBol) :
               InpSignal1==BollingerReversalSetUp ? IsCandleBelowBuffer(LowerBol) :
               InpSignal1==IchimokuBreakout ? HasCandleCrossedBufferUp(MathMax(SenkouA,SenkouB),MathMax(SenkouAPrev,SenkouBPrev)):
               InpSignal1==PSARSignal ? HasCandleCrossedBufferUp(PSARCurrent,PSARPrev):
               InpSignal1==PSARSetup ? IsCandleAboveBuffer(PSARCurrent):
               InpSignal1==RSIBreakout&&RSIPrev<InpUpperThreshold&&RSICurrent>InpUpperThreshold ? true:
               InpSignal1==RSIReversal &&RSIPrev>InpLowerThreshold&&RSICurrent<InpLowerThreshold ? true:
               InpSignal1==RSITrendSetup&&RSICurrent>InpUpperThreshold ? true:
               InpSignal1==RSIReversalSetup&&RSICurrent<InpLowerThreshold ? true:
               InpSignal1==StochasticBreakout&&StochPrev<InpUpperThreshold&&StochCurrent>InpUpperThreshold ? true:
               InpSignal1==StochasticReversal&&StochPrev>InpLowerThreshold&&StochCurrent<InpLowerThreshold ? true:
               InpSignal1==StochasticTrendSetup&&StochCurrent>InpUpperThreshold ? true:
               InpSignal1==StochasticReversalSetup&&StochCurrent<InpLowerThreshold ? true:
               InpSignal1==MACDZeroLineCross ? HasBufferCrossedZeroUp(MACDCurrent,MACDPrev):
               InpSignal1==MACDTwoLineCross ? HasBuffer1CrossedBuffer2Up(MACDCurrent,MACDPrev,MACDSignalCurrent,MACDSignalPrev):
               InpSignal1==MACDAboveZero ? IsBufferAboveZero(MACDCurrent):
               InpSignal1==MACDMainAboveSignal ? IsBuffer1AboveBuffer2(MACDCurrent,MACDSignalCurrent):
               InpSignal1==WPRBreakout&&WPRPrev<-20&&WPRCurrent>-20 ? true:
               InpSignal1==WPRReversal&&WPRPrev>-80&&WPRCurrent<-80 ? true:
               InpSignal1==WPRTrendSetup&&WPRCurrent>-20 ? true:
               InpSignal1==WPRReversalSetup&&WPRCurrent<-80 ? true:
               InpSignal1==RVIZeroLineCross ? HasBufferCrossedZeroUp(RVICurrent,RVIPrev):
               InpSignal1==RVITwoLineCross ? HasBuffer1CrossedBuffer2Up(RVICurrent,RVIPrev,RVISignalCurrent,RVISignalPrev):
               InpSignal1==RVIAboveZero ? IsBufferAboveZero(RVICurrent):
               InpSignal1==RVIMainAboveSignal ? IsBuffer1AboveBuffer2(RVICurrent,RVISignalCurrent):
               InpSignal1==CCICross&&CCIPrev<100&&CCICurrent>100 ? true:
               InpSignal1==CCISetup&&CCICurrent>100 ? true : 0;


      isSell1 = InpSignal1==MA_Cross ? HasCandleCrossedBufferDn(MA,MA_Prev):
                InpSignal1==BollingerBreakout ? HasCandleCrossedBufferDn(LowerBol,LowerBolPrev) :
                InpSignal1==BollingerMeanReversion ? HasCandleCrossedBufferUp(UpperBol,UpperBolPrev) :
                InpSignal1==BollingerTrendSetUp ? IsCandleBelowBuffer(LowerBol) :
                InpSignal1==BollingerReversalSetUp ? IsCandleAboveBuffer(UpperBol) :
                InpSignal1==IchimokuBreakout ? HasCandleCrossedBufferDn(MathMin(SenkouA,SenkouB),MathMin(SenkouAPrev,SenkouBPrev)):
                InpSignal1==PSARSignal ? HasCandleCrossedBufferDn(PSARCurrent,PSARPrev):
                InpSignal1==PSARSetup ? IsCandleBelowBuffer(PSARCurrent):
                InpSignal1==RSIBreakout &&RSIPrev>InpLowerThreshold&&RSICurrent<InpLowerThreshold ? true /*HasBufferCrossedLowerThreshold(RSICurrent,RSIPrev,30)*/:
                InpSignal1==RSIReversal&&RSIPrev<InpUpperThreshold&&RSICurrent>InpUpperThreshold ? true:
                InpSignal1==RSITrendSetup&&RSICurrent<InpLowerThreshold ? true:
                InpSignal1==RSIReversalSetup&&RSICurrent>InpUpperThreshold ? true:
                InpSignal1==StochasticBreakout&&StochPrev>InpLowerThreshold&&StochCurrent<InpLowerThreshold ? true:
                InpSignal1==StochasticReversal&&StochPrev<InpUpperThreshold&&StochCurrent>InpUpperThreshold ? true:
                InpSignal1==StochasticTrendSetup&&StochCurrent<InpLowerThreshold ? true:
                InpSignal1==StochasticReversalSetup&&StochCurrent>InpUpperThreshold ? true:
                InpSignal1==MACDZeroLineCross ? HasBufferCrossedZeroDn(MACDCurrent,MACDPrev):
                InpSignal1==MACDTwoLineCross ? HasBuffer1CrossedBuffer2Dn(MACDCurrent,MACDPrev,MACDSignalCurrent,MACDSignalPrev):
                InpSignal1==MACDAboveZero ? IsBufferBelowZero(MACDCurrent):
                InpSignal1==MACDMainAboveSignal ? IsBuffer1BelowBuffer2(MACDCurrent,MACDSignalCurrent):
                InpSignal1==WPRBreakout&&WPRPrev>-80&&WPRCurrent<-80 ? true:
                InpSignal1==WPRReversal&&WPRPrev<-20&&WPRCurrent>-20 ? true:
                InpSignal1==WPRTrendSetup&&WPRCurrent<-80 ? true:
                InpSignal1==WPRReversalSetup&&WPRCurrent>-20 ? true:
                InpSignal1==RVIZeroLineCross ? HasBufferCrossedZeroDn(RVICurrent,RVIPrev):
                InpSignal1==RVITwoLineCross ? HasBuffer1CrossedBuffer2Dn(RVICurrent,RVIPrev,RVISignalCurrent,RVISignalPrev):
                InpSignal1==RVIAboveZero ? IsBufferBelowZero(RVICurrent):
                InpSignal1==RVIMainAboveSignal ? IsBuffer1BelowBuffer2(RVICurrent,RVISignalCurrent):
                InpSignal1==CCICross&&CCIPrev>-100&&CCICurrent<-100 ? true:
                InpSignal1==CCISetup&&CCICurrent<-100 ? true  : 0;
     }


//IN-BUILT INDICATOR 2
   if(InpIndType2==Inbuilt)
     {
      double MA = Ind06.GetValue(Moving_Average,0,1,21);
      double MA_Prev = Ind06.GetValue(Moving_Average,0,2,21,PRICE_CLOSE,MODE_SMA);
      double UpperBol = Ind06.GetValue(Bollinger_Bands,1,1,20,PRICE_CLOSE,MODE_SMA,2);
      double LowerBol = Ind06.GetValue(Bollinger_Bands,2,1,20,PRICE_CLOSE,MODE_SMA,2);
      double UpperBolPrev = Ind06.GetValue(Bollinger_Bands,1,2,20,PRICE_CLOSE,MODE_SMA,2);
      double LowerBolPrev = Ind06.GetValue(Bollinger_Bands,2,2,20,PRICE_CLOSE,MODE_SMA,2);
      double SenkouA    = Ind06.GetValue(Ichimoku,2,1);
      double SenkouB    = Ind06.GetValue(Ichimoku,3,1);
      double SenkouAPrev    = Ind06.GetValue(Ichimoku,2,2);
      double SenkouBPrev    = Ind06.GetValue(Ichimoku,3,2);
      double PSARCurrent    = Ind06.GetValue(PSAR,0,1);
      double PSARPrev       = Ind06.GetValue(PSAR,0,2);
      double RSICurrent     = Ind06.GetValue(RSI,0,1,14);
      double RSIPrev        = Ind06.GetValue(RSI,0,2,14);
      double StochCurrent   = Ind06.GetValue(Stochastic,0,1,14);
      double StochPrev      = Ind06.GetValue(Stochastic,0,2,14);
      double MACDCurrent    = Ind06.GetValue(MACD,0,1,14,PRICE_CLOSE,MODE_SMA,2);
      double MACDPrev       = Ind06.GetValue(MACD,0,2,14,PRICE_CLOSE,MODE_SMA,2);
      double MACDSignalCurrent    = Ind06.GetValue(MACD,1,1,14,PRICE_CLOSE,MODE_SMA,2);
      double MACDSignalPrev       = Ind06.GetValue(MACD,1,2,14,PRICE_CLOSE,MODE_SMA,2);
      double WPRCurrent           = Ind06.GetValue(WPR,0,1,14);
      double WPRPrev              = Ind06.GetValue(WPR,0,2,14);
      double RVICurrent           = Ind06.GetValue(RVI,0,1,14);
      double RVIPrev              = Ind06.GetValue(RVI,0,2,14);
      double RVISignalCurrent           = Ind06.GetValue(RVI,1,1,14);
      double RVISignalPrev              = Ind06.GetValue(RVI,1,2,14);
      double CCICurrent           = Ind06.GetValue(CCI,0,1,14);
      double CCIPrev              = Ind06.GetValue(CCI,0,2,14);

      isBuy2 = InpSignal2==MA_Cross ? HasCandleCrossedBufferUp(MA,MA_Prev):
               InpSignal2==BollingerBreakout ? HasCandleCrossedBufferUp(UpperBol,UpperBolPrev) :
               InpSignal2==BollingerMeanReversion ? HasCandleCrossedBufferDn(LowerBol,LowerBolPrev) :
               InpSignal2==BollingerTrendSetUp ? IsCandleAboveBuffer(UpperBol) :
               InpSignal2==BollingerReversalSetUp ? IsCandleBelowBuffer(LowerBol) :
               InpSignal2==IchimokuBreakout ? HasCandleCrossedBufferUp(MathMax(SenkouA,SenkouB),MathMax(SenkouAPrev,SenkouBPrev)):
               InpSignal2==PSARSignal ? HasCandleCrossedBufferUp(PSARCurrent,PSARPrev):
               InpSignal2==PSARSetup ? IsCandleAboveBuffer(PSARCurrent):
               InpSignal2==RSIBreakout&&RSIPrev<InpUpperThreshold&&RSICurrent>InpUpperThreshold ? true:
               InpSignal2==RSIReversal &&RSIPrev>InpLowerThreshold&&RSICurrent<InpLowerThreshold ? true:
               InpSignal2==RSITrendSetup&&RSICurrent>InpUpperThreshold ? true:
               InpSignal2==RSIReversalSetup&&RSICurrent<InpLowerThreshold ? true:
               InpSignal2==StochasticBreakout&&StochPrev<InpUpperThreshold&&StochCurrent>InpUpperThreshold ? true:
               InpSignal2==StochasticReversal&&StochPrev>InpLowerThreshold&&StochCurrent<InpLowerThreshold ? true:
               InpSignal2==StochasticTrendSetup&&StochCurrent>InpUpperThreshold ? true:
               InpSignal2==StochasticReversalSetup&&StochCurrent<InpLowerThreshold ? true:
               InpSignal2==MACDZeroLineCross ? HasBufferCrossedZeroUp(MACDCurrent,MACDPrev):
               InpSignal2==MACDTwoLineCross ? HasBuffer1CrossedBuffer2Up(MACDCurrent,MACDPrev,MACDSignalCurrent,MACDSignalPrev):
               InpSignal2==MACDAboveZero ? IsBufferAboveZero(MACDCurrent):
               InpSignal2==MACDMainAboveSignal ? IsBuffer1AboveBuffer2(MACDCurrent,MACDSignalCurrent):
               InpSignal2==WPRBreakout&&WPRPrev<-20&&WPRCurrent>-20 ? true:
               InpSignal2==WPRReversal&&WPRPrev>-80&&WPRCurrent<-80 ? true:
               InpSignal2==WPRTrendSetup&&WPRCurrent>-20 ? true:
               InpSignal2==WPRReversalSetup&&WPRCurrent<-80 ? true:
               InpSignal2==RVIZeroLineCross ? HasBufferCrossedZeroUp(RVICurrent,RVIPrev):
               InpSignal2==RVITwoLineCross ? HasBuffer1CrossedBuffer2Up(RVICurrent,RVIPrev,RVISignalCurrent,RVISignalPrev):
               InpSignal2==RVIAboveZero ? IsBufferAboveZero(RVICurrent):
               InpSignal2==RVIMainAboveSignal ? IsBuffer1AboveBuffer2(RVICurrent,RVISignalCurrent):
               InpSignal2==CCICross&&CCIPrev<100&&CCICurrent>100 ? true:
               InpSignal2==CCISetup&&CCICurrent>100 ? true : 0;


      isSell2 = InpSignal2==MA_Cross ? HasCandleCrossedBufferDn(MA,MA_Prev):
                InpSignal2==BollingerBreakout ? HasCandleCrossedBufferDn(LowerBol,LowerBolPrev) :
                InpSignal2==BollingerMeanReversion ? HasCandleCrossedBufferUp(UpperBol,UpperBolPrev) :
                InpSignal2==BollingerTrendSetUp ? IsCandleBelowBuffer(LowerBol) :
                InpSignal2==BollingerReversalSetUp ? IsCandleAboveBuffer(UpperBol) :
                InpSignal2==IchimokuBreakout ? HasCandleCrossedBufferDn(MathMin(SenkouA,SenkouB),MathMin(SenkouAPrev,SenkouBPrev)):
                InpSignal2==PSARSignal ? HasCandleCrossedBufferDn(PSARCurrent,PSARPrev):
                InpSignal2==PSARSetup ? IsCandleBelowBuffer(PSARCurrent):
                InpSignal2==RSIBreakout &&RSIPrev>InpLowerThreshold&&RSICurrent<InpLowerThreshold ? true /*HasBufferCrossedLowerThreshold(RSICurrent,RSIPrev,30)*/:
                InpSignal2==RSIReversal&&RSIPrev<InpUpperThreshold&&RSICurrent>InpUpperThreshold ? true:
                InpSignal2==RSITrendSetup&&RSICurrent<InpLowerThreshold ? true:
                InpSignal2==RSIReversalSetup&&RSICurrent>InpUpperThreshold ? true:
                InpSignal2==StochasticBreakout&&StochPrev>InpLowerThreshold&&StochCurrent<InpLowerThreshold ? true:
                InpSignal2==StochasticReversal&&StochPrev<InpUpperThreshold&&StochCurrent>InpUpperThreshold ? true:
                InpSignal2==StochasticTrendSetup&&StochCurrent<InpLowerThreshold ? true:
                InpSignal2==StochasticReversalSetup&&StochCurrent>InpUpperThreshold ? true:
                InpSignal2==MACDZeroLineCross ? HasBufferCrossedZeroDn(MACDCurrent,MACDPrev):
                InpSignal2==MACDTwoLineCross ? HasBuffer1CrossedBuffer2Dn(MACDCurrent,MACDPrev,MACDSignalCurrent,MACDSignalPrev):
                InpSignal2==MACDAboveZero ? IsBufferBelowZero(MACDCurrent):
                InpSignal2==MACDMainAboveSignal ? IsBuffer1BelowBuffer2(MACDCurrent,MACDSignalCurrent):
                InpSignal2==WPRBreakout&&WPRPrev>-80&&WPRCurrent<-80 ? true:
                InpSignal2==WPRReversal&&WPRPrev<-20&&WPRCurrent>-20 ? true:
                InpSignal2==WPRTrendSetup&&WPRCurrent<-80 ? true:
                InpSignal2==WPRReversalSetup&&WPRCurrent>-20 ? true:
                InpSignal2==RVIZeroLineCross ? HasBufferCrossedZeroDn(RVICurrent,RVIPrev):
                InpSignal2==RVITwoLineCross ? HasBuffer1CrossedBuffer2Dn(RVICurrent,RVIPrev,RVISignalCurrent,RVISignalPrev):
                InpSignal2==RVIAboveZero ? IsBufferBelowZero(RVICurrent):
                InpSignal2==RVIMainAboveSignal ? IsBuffer1BelowBuffer2(RVICurrent,RVISignalCurrent):
                InpSignal2==CCICross&&CCIPrev>-100&&CCICurrent<-100 ? true:
                InpSignal2==CCISetup&&CCICurrent<-100 ? true  : 0;
     }

//IN-BUILT INDICATOR 3
   if(InpIndType3==Inbuilt)
     {
      double MA = Ind07.GetValue(Moving_Average,0,1,21);
      double MA_Prev = Ind07.GetValue(Moving_Average,0,2,21,PRICE_CLOSE,MODE_SMA);
      double UpperBol = Ind07.GetValue(Bollinger_Bands,1,1,20,PRICE_CLOSE,MODE_SMA,2);
      double LowerBol = Ind07.GetValue(Bollinger_Bands,2,1,20,PRICE_CLOSE,MODE_SMA,2);
      double UpperBolPrev = Ind07.GetValue(Bollinger_Bands,1,2,20,PRICE_CLOSE,MODE_SMA,2);
      double LowerBolPrev = Ind07.GetValue(Bollinger_Bands,2,2,20,PRICE_CLOSE,MODE_SMA,2);
      double SenkouA    = Ind07.GetValue(Ichimoku,2,1);
      double SenkouB    = Ind07.GetValue(Ichimoku,3,1);
      double SenkouAPrev    = Ind07.GetValue(Ichimoku,2,2);
      double SenkouBPrev    = Ind07.GetValue(Ichimoku,3,2);
      double PSARCurrent    = Ind07.GetValue(PSAR,0,1);
      double PSARPrev       = Ind07.GetValue(PSAR,0,2);
      double RSICurrent     = Ind07.GetValue(RSI,0,1,14);
      double RSIPrev        = Ind07.GetValue(RSI,0,2,14);
      double StochCurrent   = Ind07.GetValue(Stochastic,0,1,14);
      double StochPrev      = Ind07.GetValue(Stochastic,0,2,14);
      double MACDCurrent    = Ind07.GetValue(MACD,0,1,14,PRICE_CLOSE,MODE_SMA,2);
      double MACDPrev       = Ind07.GetValue(MACD,0,2,14,PRICE_CLOSE,MODE_SMA,2);
      double MACDSignalCurrent    = Ind07.GetValue(MACD,1,1,14,PRICE_CLOSE,MODE_SMA,2);
      double MACDSignalPrev       = Ind07.GetValue(MACD,1,2,14,PRICE_CLOSE,MODE_SMA,2);
      double WPRCurrent           = Ind07.GetValue(WPR,0,1,14);
      double WPRPrev              = Ind07.GetValue(WPR,0,2,14);
      double RVICurrent           = Ind07.GetValue(RVI,0,1,14);
      double RVIPrev              = Ind07.GetValue(RVI,0,2,14);
      double RVISignalCurrent           = Ind07.GetValue(RVI,1,1,14);
      double RVISignalPrev              = Ind07.GetValue(RVI,1,2,14);
      double CCICurrent           = Ind07.GetValue(CCI,0,1,14);
      double CCIPrev              = Ind07.GetValue(CCI,0,2,14);

      isBuy3 = InpSignal3==MA_Cross ? HasCandleCrossedBufferUp(MA,MA_Prev):
               InpSignal3==BollingerBreakout ? HasCandleCrossedBufferUp(UpperBol,UpperBolPrev) :
               InpSignal3==BollingerMeanReversion ? HasCandleCrossedBufferDn(LowerBol,LowerBolPrev) :
               InpSignal3==BollingerTrendSetUp ? IsCandleAboveBuffer(UpperBol) :
               InpSignal3==BollingerReversalSetUp ? IsCandleBelowBuffer(LowerBol) :
               InpSignal3==IchimokuBreakout ? HasCandleCrossedBufferUp(MathMax(SenkouA,SenkouB),MathMax(SenkouAPrev,SenkouBPrev)):
               InpSignal3==PSARSignal ? HasCandleCrossedBufferUp(PSARCurrent,PSARPrev):
               InpSignal3==PSARSetup ? IsCandleAboveBuffer(PSARCurrent):
               InpSignal3==RSIBreakout&&RSIPrev<InpUpperThreshold&&RSICurrent>InpUpperThreshold ? true:
               InpSignal3==RSIReversal &&RSIPrev>InpLowerThreshold&&RSICurrent<InpLowerThreshold ? true:
               InpSignal3==RSITrendSetup&&RSICurrent>InpUpperThreshold ? true:
               InpSignal3==RSIReversalSetup&&RSICurrent<InpLowerThreshold ? true:
               InpSignal3==StochasticBreakout&&StochPrev<InpUpperThreshold&&StochCurrent>InpUpperThreshold ? true:
               InpSignal3==StochasticReversal&&StochPrev>InpLowerThreshold&&StochCurrent<InpLowerThreshold ? true:
               InpSignal3==StochasticTrendSetup&&StochCurrent>InpUpperThreshold ? true:
               InpSignal3==StochasticReversalSetup&&StochCurrent<InpLowerThreshold ? true:
               InpSignal3==MACDZeroLineCross ? HasBufferCrossedZeroUp(MACDCurrent,MACDPrev):
               InpSignal3==MACDTwoLineCross ? HasBuffer1CrossedBuffer2Up(MACDCurrent,MACDPrev,MACDSignalCurrent,MACDSignalPrev):
               InpSignal3==MACDAboveZero ? IsBufferAboveZero(MACDCurrent):
               InpSignal3==MACDMainAboveSignal ? IsBuffer1AboveBuffer2(MACDCurrent,MACDSignalCurrent):
               InpSignal3==WPRBreakout&&WPRPrev<-20&&WPRCurrent>-20 ? true:
               InpSignal3==WPRReversal&&WPRPrev>-80&&WPRCurrent<-80 ? true:
               InpSignal3==WPRTrendSetup&&WPRCurrent>-20 ? true:
               InpSignal3==WPRReversalSetup&&WPRCurrent<-80 ? true:
               InpSignal3==RVIZeroLineCross ? HasBufferCrossedZeroUp(RVICurrent,RVIPrev):
               InpSignal3==RVITwoLineCross ? HasBuffer1CrossedBuffer2Up(RVICurrent,RVIPrev,RVISignalCurrent,RVISignalPrev):
               InpSignal3==RVIAboveZero ? IsBufferAboveZero(RVICurrent):
               InpSignal3==RVIMainAboveSignal ? IsBuffer1AboveBuffer2(RVICurrent,RVISignalCurrent):
               InpSignal3==CCICross&&CCIPrev<100&&CCICurrent>100 ? true:
               InpSignal3==CCISetup&&CCICurrent>100 ? true : 0;


      isSell3 = InpSignal3==MA_Cross ? HasCandleCrossedBufferDn(MA,MA_Prev):
                InpSignal3==BollingerBreakout ? HasCandleCrossedBufferDn(LowerBol,LowerBolPrev) :
                InpSignal3==BollingerMeanReversion ? HasCandleCrossedBufferUp(UpperBol,UpperBolPrev) :
                InpSignal3==BollingerTrendSetUp ? IsCandleBelowBuffer(LowerBol) :
                InpSignal3==BollingerReversalSetUp ? IsCandleAboveBuffer(UpperBol) :
                InpSignal3==IchimokuBreakout ? HasCandleCrossedBufferDn(MathMin(SenkouA,SenkouB),MathMin(SenkouAPrev,SenkouBPrev)):
                InpSignal3==PSARSignal ? HasCandleCrossedBufferDn(PSARCurrent,PSARPrev):
                InpSignal3==PSARSetup ? IsCandleBelowBuffer(PSARCurrent):
                InpSignal3==RSIBreakout &&RSIPrev>InpLowerThreshold&&RSICurrent<InpLowerThreshold ? true /*HasBufferCrossedLowerThreshold(RSICurrent,RSIPrev,30)*/:
                InpSignal3==RSIReversal&&RSIPrev<InpUpperThreshold&&RSICurrent>InpUpperThreshold ? true:
                InpSignal3==RSITrendSetup&&RSICurrent<InpLowerThreshold ? true:
                InpSignal3==RSIReversalSetup&&RSICurrent>InpUpperThreshold ? true:
                InpSignal3==StochasticBreakout&&StochPrev>InpLowerThreshold&&StochCurrent<InpLowerThreshold ? true:
                InpSignal3==StochasticReversal&&StochPrev<InpUpperThreshold&&StochCurrent>InpUpperThreshold ? true:
                InpSignal3==StochasticTrendSetup&&StochCurrent<InpLowerThreshold ? true:
                InpSignal3==StochasticReversalSetup&&StochCurrent>InpUpperThreshold ? true:
                InpSignal3==MACDZeroLineCross ? HasBufferCrossedZeroDn(MACDCurrent,MACDPrev):
                InpSignal3==MACDTwoLineCross ? HasBuffer1CrossedBuffer2Dn(MACDCurrent,MACDPrev,MACDSignalCurrent,MACDSignalPrev):
                InpSignal3==MACDAboveZero ? IsBufferBelowZero(MACDCurrent):
                InpSignal3==MACDMainAboveSignal ? IsBuffer1BelowBuffer2(MACDCurrent,MACDSignalCurrent):
                InpSignal3==WPRBreakout&&WPRPrev>-80&&WPRCurrent<-80 ? true:
                InpSignal3==WPRReversal&&WPRPrev<-20&&WPRCurrent>-20 ? true:
                InpSignal3==WPRTrendSetup&&WPRCurrent<-80 ? true:
                InpSignal3==WPRReversalSetup&&WPRCurrent>-20 ? true:
                InpSignal3==RVIZeroLineCross ? HasBufferCrossedZeroDn(RVICurrent,RVIPrev):
                InpSignal3==RVITwoLineCross ? HasBuffer1CrossedBuffer2Dn(RVICurrent,RVIPrev,RVISignalCurrent,RVISignalPrev):
                InpSignal3==RVIAboveZero ? IsBufferBelowZero(RVICurrent):
                InpSignal3==RVIMainAboveSignal ? IsBuffer1BelowBuffer2(RVICurrent,RVISignalCurrent):
                InpSignal3==CCICross&&CCIPrev>-100&&CCICurrent<-100 ? true:
                InpSignal3==CCISetup&&CCICurrent<-100 ? true  : 0;
     }

//IN-BUILT INDICATOR 4
   if(InpIndType4==Inbuilt)
     {
      double MA = iMA(_Symbol,_Period,21,0,MODE_SMA,PRICE_CLOSE,1);
      double MA_Prev = iMA(_Symbol,_Period,21,0,MODE_SMA,PRICE_CLOSE,2);
      double UpperBol = iBands(_Symbol,_Period,20,2,0,PRICE_CLOSE,MODE_UPPER,1);
      double LowerBol = iBands(_Symbol,_Period,20,2,0,PRICE_CLOSE,MODE_LOWER,1);
      double UpperBolPrev = iBands(_Symbol,_Period,20,2,0,PRICE_CLOSE,MODE_UPPER,2);
      double LowerBolPrev = iBands(_Symbol,_Period,20,2,0,PRICE_CLOSE,MODE_LOWER,2);
      double SenkouA    = Ind08.GetValue(Ichimoku,2,1);
      double SenkouB    = Ind08.GetValue(Ichimoku,3,1);
      double SenkouAPrev    = Ind08.GetValue(Ichimoku,2,2);
      double SenkouBPrev    = Ind08.GetValue(Ichimoku,3,2);
      double PSARCurrent    = Ind08.GetValue(PSAR,0,1);
      double PSARPrev       = Ind08.GetValue(PSAR,0,2);
      double RSICurrent     = Ind08.GetValue(RSI,0,1,14);
      double RSIPrev        = Ind08.GetValue(RSI,0,2,14);
      double StochCurrent   = Ind08.GetValue(Stochastic,0,1,14);
      double StochPrev      = Ind08.GetValue(Stochastic,0,2,14);
      double MACDCurrent    = Ind08.GetValue(MACD,0,1,14,PRICE_CLOSE,MODE_SMA,2);
      double MACDPrev       = Ind08.GetValue(MACD,0,2,14,PRICE_CLOSE,MODE_SMA,2);
      double MACDSignalCurrent    = Ind08.GetValue(MACD,1,1,14,PRICE_CLOSE,MODE_SMA,2);
      double MACDSignalPrev       = Ind08.GetValue(MACD,1,2,14,PRICE_CLOSE,MODE_SMA,2);
      double WPRCurrent           = Ind08.GetValue(WPR,0,1,14);
      double WPRPrev              = Ind08.GetValue(WPR,0,2,14);
      double RVICurrent           = Ind08.GetValue(RVI,0,1,14);
      double RVIPrev              = Ind08.GetValue(RVI,0,2,14);
      double RVISignalCurrent           = Ind08.GetValue(RVI,1,1,14);
      double RVISignalPrev              = Ind08.GetValue(RVI,1,2,14);
      double CCICurrent           = Ind08.GetValue(CCI,0,1,14);
      double CCIPrev              = Ind08.GetValue(CCI,0,2,14);

      isBuy4 = InpSignal4==MA_Cross ? HasCandleCrossedBufferUp(MA,MA_Prev):
               InpSignal4==BollingerBreakout ? HasCandleCrossedBufferUp(UpperBol,UpperBolPrev) :
               InpSignal4==BollingerMeanReversion ? HasCandleCrossedBufferDn(LowerBol,LowerBolPrev) :
               InpSignal4==BollingerTrendSetUp ? IsCandleAboveBuffer(UpperBol) :
               InpSignal4==BollingerReversalSetUp ? IsCandleBelowBuffer(LowerBol) :
               InpSignal4==IchimokuBreakout ? HasCandleCrossedBufferUp(MathMax(SenkouA,SenkouB),MathMax(SenkouAPrev,SenkouBPrev)):
               InpSignal4==PSARSignal ? HasCandleCrossedBufferUp(PSARCurrent,PSARPrev):
               InpSignal4==PSARSetup ? IsCandleAboveBuffer(PSARCurrent):
               InpSignal4==RSIBreakout&&RSIPrev<InpUpperThreshold&&RSICurrent>InpUpperThreshold ? true:
               InpSignal4==RSIReversal &&RSIPrev>InpLowerThreshold&&RSICurrent<InpLowerThreshold ? true:
               InpSignal4==RSITrendSetup&&RSICurrent>InpUpperThreshold ? true:
               InpSignal4==RSIReversalSetup&&RSICurrent<InpLowerThreshold ? true:
               InpSignal4==StochasticBreakout&&StochPrev<InpUpperThreshold&&StochCurrent>InpUpperThreshold ? true:
               InpSignal4==StochasticReversal&&StochPrev>InpLowerThreshold&&StochCurrent<InpLowerThreshold ? true:
               InpSignal4==StochasticTrendSetup&&StochCurrent>InpUpperThreshold ? true:
               InpSignal4==StochasticReversalSetup&&StochCurrent<InpLowerThreshold ? true:
               InpSignal4==MACDZeroLineCross ? HasBufferCrossedZeroUp(MACDCurrent,MACDPrev):
               InpSignal4==MACDTwoLineCross ? HasBuffer1CrossedBuffer2Up(MACDCurrent,MACDPrev,MACDSignalCurrent,MACDSignalPrev):
               InpSignal4==MACDAboveZero ? IsBufferAboveZero(MACDCurrent):
               InpSignal4==MACDMainAboveSignal ? IsBuffer1AboveBuffer2(MACDCurrent,MACDSignalCurrent):
               InpSignal4==WPRBreakout&&WPRPrev<-20&&WPRCurrent>-20 ? true:
               InpSignal4==WPRReversal&&WPRPrev>-80&&WPRCurrent<-80 ? true:
               InpSignal4==WPRTrendSetup&&WPRCurrent>-20 ? true:
               InpSignal4==WPRReversalSetup&&WPRCurrent<-80 ? true:
               InpSignal4==RVIZeroLineCross ? HasBufferCrossedZeroUp(RVICurrent,RVIPrev):
               InpSignal4==RVITwoLineCross ? HasBuffer1CrossedBuffer2Up(RVICurrent,RVIPrev,RVISignalCurrent,RVISignalPrev):
               InpSignal4==RVIAboveZero ? IsBufferAboveZero(RVICurrent):
               InpSignal4==RVIMainAboveSignal ? IsBuffer1AboveBuffer2(RVICurrent,RVISignalCurrent):
               InpSignal4==CCICross&&CCIPrev<100&&CCICurrent>100 ? true:
               InpSignal4==CCISetup&&CCICurrent>100 ? true : 0;


      isSell4 = InpSignal4==MA_Cross ? HasCandleCrossedBufferDn(MA,MA_Prev):
                InpSignal4==BollingerBreakout ? HasCandleCrossedBufferDn(LowerBol,LowerBolPrev) :
                InpSignal4==BollingerMeanReversion ? HasCandleCrossedBufferUp(UpperBol,UpperBolPrev) :
                InpSignal4==BollingerTrendSetUp ? IsCandleBelowBuffer(LowerBol) :
                InpSignal4==BollingerReversalSetUp ? IsCandleAboveBuffer(UpperBol) :
                InpSignal4==IchimokuBreakout ? HasCandleCrossedBufferDn(MathMin(SenkouA,SenkouB),MathMin(SenkouAPrev,SenkouBPrev)):
                InpSignal4==PSARSignal ? HasCandleCrossedBufferDn(PSARCurrent,PSARPrev):
                InpSignal4==PSARSetup ? IsCandleBelowBuffer(PSARCurrent):
                InpSignal4==RSIBreakout &&RSIPrev>InpLowerThreshold&&RSICurrent<InpLowerThreshold ? true /*HasBufferCrossedLowerThreshold(RSICurrent,RSIPrev,30)*/:
                InpSignal4==RSIReversal&&RSIPrev<InpUpperThreshold&&RSICurrent>InpUpperThreshold ? true:
                InpSignal4==RSITrendSetup&&RSICurrent<InpLowerThreshold ? true:
                InpSignal4==RSIReversalSetup&&RSICurrent>InpUpperThreshold ? true:
                InpSignal4==StochasticBreakout&&StochPrev>InpLowerThreshold&&StochCurrent<InpLowerThreshold ? true:
                InpSignal4==StochasticReversal&&StochPrev<InpUpperThreshold&&StochCurrent>InpUpperThreshold ? true:
                InpSignal4==StochasticTrendSetup&&StochCurrent<InpLowerThreshold ? true:
                InpSignal4==StochasticReversalSetup&&StochCurrent>InpUpperThreshold ? true:
                InpSignal4==MACDZeroLineCross ? HasBufferCrossedZeroDn(MACDCurrent,MACDPrev):
                InpSignal4==MACDTwoLineCross ? HasBuffer1CrossedBuffer2Dn(MACDCurrent,MACDPrev,MACDSignalCurrent,MACDSignalPrev):
                InpSignal4==MACDAboveZero ? IsBufferBelowZero(MACDCurrent):
                InpSignal4==MACDMainAboveSignal ? IsBuffer1BelowBuffer2(MACDCurrent,MACDSignalCurrent):
                InpSignal4==WPRBreakout&&WPRPrev>-80&&WPRCurrent<-80 ? true:
                InpSignal4==WPRReversal&&WPRPrev<-20&&WPRCurrent>-20 ? true:
                InpSignal4==WPRTrendSetup&&WPRCurrent<-80 ? true:
                InpSignal4==WPRReversalSetup&&WPRCurrent>-20 ? true:
                InpSignal4==RVIZeroLineCross ? HasBufferCrossedZeroDn(RVICurrent,RVIPrev):
                InpSignal4==RVITwoLineCross ? HasBuffer1CrossedBuffer2Dn(RVICurrent,RVIPrev,RVISignalCurrent,RVISignalPrev):
                InpSignal4==RVIAboveZero ? IsBufferBelowZero(RVICurrent):
                InpSignal4==RVIMainAboveSignal ? IsBuffer1BelowBuffer2(RVICurrent,RVISignalCurrent):
                InpSignal4==CCICross&&CCIPrev>-100&&CCICurrent<-100 ? true:
                InpSignal4==CCISetup&&CCICurrent<-100 ? true  : 0;
     }


//THREE PIECE ALGO
//2,3,4
   if(InpSwitch1==off)
     {
      if(isBuy2 && isBuy3 && isBuy4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_BUY,0.01,Ask,10,Bid-200*_Point,Ask+200*_Point,NULL,0,0,clrNONE);
           }

        }

      if(isSell2 && isSell3 && isSell4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_SELL,0.01,Bid,10,Ask+200*_Point,Bid-200*_Point,NULL,0,0,clrNONE);
           }

        }
     }


//1,3,4
   if(InpSwitch2==off)
     {
      if(isBuy1 && isBuy3 && isBuy4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_BUY,0.01,Ask,10,Bid-200*_Point,Ask+200*_Point,NULL,0,0,clrNONE);
           }

        }

      if(isSell1 && isSell3 && isSell4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_SELL,0.01,Bid,10,Ask+200*_Point,Bid-200*_Point,NULL,0,0,clrNONE);
           }

        }
     }


//1,2,4
   if(InpSwitch3==off)
     {
      if(isBuy1 && isBuy2 && isBuy4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_BUY,0.01,Ask,10,Bid-200*_Point,Ask+200*_Point,NULL,0,0,clrNONE);
           }

        }

      if(isSell1 && isSell2 && isSell4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_SELL,0.01,Bid,10,Ask+200*_Point,Bid-200*_Point,NULL,0,0,clrNONE);
           }

        }
     }

//TWO PIECE ALGO
//1,2
   if(InpSwitch3==off && InpSwitch4==off)
     {
      if(isBuy1 && isBuy2 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_BUY,0.01,Ask,10,Bid-200*_Point,Ask+200*_Point,NULL,0,0,clrNONE);
           }

        }

      if(isSell1 && isSell2 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_SELL,0.01,Bid,10,Ask+200*_Point,Bid-200*_Point,NULL,0,0,clrNONE);
           }

        }
     }

//1,3
   if(InpSwitch2==off && InpSwitch4==off)
     {
      if(isBuy1 && isBuy3 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_BUY,0.01,Ask,10,Bid-200*_Point,Ask+200*_Point,NULL,0,0,clrNONE);
           }

        }

      if(isSell1 && isSell3 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_SELL,0.01,Bid,10,Ask+200*_Point,Bid-200*_Point,NULL,0,0,clrNONE);
           }

        }
     }


//1,4
   if(InpSwitch2==off && InpSwitch3==off)
     {
      if(isBuy1 && isBuy4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_BUY,0.01,Ask,10,Bid-200*_Point,Ask+200*_Point,NULL,0,0,clrNONE);
           }

        }

      if(isSell1 && isSell4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_SELL,0.01,Bid,10,Ask+200*_Point,Bid-200*_Point,NULL,0,0,clrNONE);
           }

        }
     }



//2,3
   if(InpSwitch1==off && InpSwitch4==off)
     {
      if(isBuy2 && isBuy3 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_BUY,0.01,Ask,10,Bid-200*_Point,Ask+200*_Point,NULL,0,0,clrNONE);
           }

        }

      if(isSell2 && isSell3 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_SELL,0.01,Bid,10,Ask+200*_Point,Bid-200*_Point,NULL,0,0,clrNONE);
           }

        }
     }

//2,4
   if(InpSwitch1==off && InpSwitch3==off)
     {
      if(isBuy2 && isBuy4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_BUY,0.01,Ask,10,Bid-200*_Point,Ask+200*_Point,NULL,0,0,clrNONE);
           }

        }

      if(isSell2 && isSell4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_SELL,0.01,Bid,10,Ask+200*_Point,Bid-200*_Point,NULL,0,0,clrNONE);
           }

        }
     }

//3,4
   if(InpSwitch1==off && InpSwitch2==off)
     {
      if(isBuy3 && isBuy4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_BUY,0.01,Ask,10,Bid-200*_Point,Ask+200*_Point,NULL,0,0,clrNONE);
           }

        }

      if(isSell3 && isSell4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_SELL,0.01,Bid,10,Ask+200*_Point,Bid-200*_Point,NULL,0,0,clrNONE);
           }

        }
     }


//ONE PIECE ALGO
//1
   if(InpSwitch2==off && InpSwitch3==off && InpSwitch4==off)
     {
      if(isBuy1 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_BUY,0.01,Ask,10,Bid-200*_Point,Ask+200*_Point,NULL,0,0,clrNONE);
           }

        }

      if(isSell1 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_SELL,0.01,Bid,10,Ask+200*_Point,Bid-200*_Point,NULL,0,0,clrNONE);
           }

        }
     }


//2
   if(InpSwitch1==off && InpSwitch3==off && InpSwitch4==off)
     {
      if(isBuy2 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_BUY,0.01,Ask,10,Bid-200*_Point,Ask+200*_Point,NULL,0,0,clrNONE);
           }

        }

      if(isSell2 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_SELL,0.01,Bid,10,Ask+200*_Point,Bid-200*_Point,NULL,0,0,clrNONE);
           }

        }
     }


//3
   if(InpSwitch1==off && InpSwitch2==off && InpSwitch4==off)
     {
      if(isBuy3 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_BUY,0.01,Ask,10,Bid-200*_Point,Ask+200*_Point,NULL,0,0,clrNONE);
           }

        }

      if(isSell3 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_SELL,0.01,Bid,10,Ask+200*_Point,Bid-200*_Point,NULL,0,0,clrNONE);
           }

        }
     }

//4
   if(InpSwitch1==off && InpSwitch2==off && InpSwitch3==off)
     {
      if(isBuy4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_BUY,0.01,Ask,10,Bid-200*_Point,Ask+200*_Point,NULL,0,0,clrNONE);
           }

        }

      if(isSell4 && OrdersTotal()<InpMaxTrades)
        {
         for(int i=0; i<InpMaxTrades; i++)
           {
            int ticket = OrderSend(_Symbol,OP_SELL,0.01,Bid,10,Ask+200*_Point,Bid-200*_Point,NULL,0,0,clrNONE);
           }

        }
     }

  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HasCandleCrossedBufferUp(double pvalue, double pvalueprev)
  {
   double close     = iClose(_Symbol,_Period,1);
   double closeprev = iClose(_Symbol,_Period,2);

   if(closeprev<pvalueprev && close>pvalue)
     {
      return(true);
     }

   return(false);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HasCandleCrossedBufferDn(double pvalue, double pvalueprev)
  {
   double close     = iClose(_Symbol,_Period,1);
   double closeprev = iClose(_Symbol,_Period,2);

   if(closeprev>pvalueprev && close<pvalue)
     {
      return(true);
     }

   return(false);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsCandleAboveBuffer(double pvalue)
  {

   double close     = iClose(_Symbol,_Period,1);
   double closeprev = iClose(_Symbol,_Period,2);

   if(close>pvalue)
     {
      return(true);
     }

   return(false);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsCandleBelowBuffer(double pvalue)
  {

   double close     = iClose(_Symbol,_Period,1);
   double closeprev = iClose(_Symbol,_Period,2);

   if(close<pvalue)
     {
      return(true);
     }

   return(false);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsBuffer1AboveBuffer2(double pvalue, double pvalue2)
  {


   if(pvalue>pvalue2 && pvalue!=EMPTY_VALUE)
     {
      return(true);
     }




   return(false);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsBuffer1BelowBuffer2(double pvalue, double pvalue2)
  {


   if(pvalue<pvalue2 && pvalue2!=EMPTY_VALUE)
     {
      return(true);
     }

   return(false);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HasBuffer1CrossedBuffer2Up(double pvalue, double pvalueprev, double pvalue2, double pvalue2prev)
  {

   if(pvalueprev<pvalue2prev && pvalue>pvalue2)
     {
      return(true);
     }

   return(false);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HasBuffer1CrossedBuffer2Dn(double pvalue, double pvalueprev, double pvalue2, double pvalue2prev)
  {

   if(pvalueprev>pvalue2prev && pvalue<pvalue2)
     {
      return(true);
     }

   return(false);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HasBufferCrossedUpperThreshold(double pvalue, double pvalueprev,double threshold)
  {

   if(pvalueprev<threshold && pvalue>threshold)
     {
      return(true);
     }

   return(true);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HasBufferCrossedLowerThreshold(double pvalue, double pvalueprev,double threshold)
  {

   if(pvalueprev>threshold && pvalue<threshold)
     {
      return(true);
     }

   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HasBufferCrossedZeroUp(double pvalue, double pvalueprev)
  {

   if(pvalueprev<0 && pvalue>0)
     {
      return(true);
     }
   return(false);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HasBufferCrossedZeroDn(double pvalue, double pvalueprev)
  {

   if(pvalueprev>0 && pvalue<0)
     {
      return(true);
     }
   return(false);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsBufferAboveZero(double pvalue)
  {
   if(pvalue>0)
     {
      return(true);
     }
   return(false);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsBufferBelowZero(double pvalue)
  {
   if(pvalue<0)
     {
      return(true);
     }
   return(false);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsBufferAboveThreshold(double pvalue, double threshold)
  {
   if(pvalue>threshold)
     {
      return(true);
     }
   return(false);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsBufferBelowThreshold(double pvalue, double threshold)
  {
   if(pvalue<threshold)
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
bool IsNeutralBufferAboveZero(double pvalue)
  {

   if(pvalue>0)
     {
      return(true);
     }
   return(false);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsNeutralBufferBelowZero(double pvalue)
  {

   if(pvalue<0)
     {
      return(true);
     }
   return(false);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsNeutralBufferAboveThreshold(double pvalue, double thresholdbuffer)
  {

   if(pvalue>thresholdbuffer)
     {
      return(true);
     }
   return(false);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsNeutralBufferBelowThreshold(double pvalue, double thresholdbuffer)
  {

   if(pvalue<thresholdbuffer)
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
bool IsNonEmpty(double pvalue)
  {

   if(pvalue!=EMPTY_VALUE && pvalue!=0)
     {
      return(true);
     }

   return(false);
  }
//+------------------------------------------------------------------+
