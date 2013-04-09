// --------------------------------------------------------------------
// Copyright (c) 2005 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
// Major Functions:  DE2 TV Box
// --------------------------------------------------------------------

module DE2_TV
(
  // Clock Input      
  input         OSC_27,    //  27 MHz
  input         OSC_50,    //  50 MHz
  input         EXT_CLOCK,   //  External Clock
  // Push Button   
  input   [3:0] KEY,         //  Button[3:0]
  // DPDT DPDT_SWitch   
  input  [17:0] DPDT_SW,          //  DPDT DPDT_SWitch[17:0]
  // 7-SEG Dispaly 
  output  [6:0] HEX0,        //  Seven Segment Digital 0
  output  [6:0] HEX1,        //  Seven Segment Digital 1
  output  [6:0] HEX2,        //  Seven Segment Digital 2
  output  [6:0] HEX3,        //  Seven Segment Digital 3
  output  [6:0] HEX4,        //  Seven Segment Digital 4
  output  [6:0] HEX5,        //  Seven Segment Digital 5
  output  [6:0] HEX6,        //  Seven Segment Digital 6
  output  [6:0] HEX7,        //  Seven Segment Digital 7
  // LED  
  output  [8:0] LED_GREEN,   //  LED Green[8:0]
  output [17:0] LED_RED,     //  LED Red[17:0]
  // UART 
  output        UART_TXD,    //  UART Transmitter
  input         UART_RXD,    //  UART Receiver
  // IRDA
  output        IRDA_TXD,    //  IRDA Transmitter
  input         IRDA_RXD,    //  IRDA Receiver
  // SDRAM Interface  
  inout  [15:0] DRAM_DQ,     //  SDRAM Data bus 16 Bits
  output [11:0] DRAM_ADDR,   //  SDRAM Address bus 12 Bits
  output        DRAM_LDQM,   //  SDRAM Low-byte Data Mask 
  output        DRAM_UDQM,   //  SDRAM High-byte Data Mask
  output        DRAM_WE_N,   //  SDRAM Write Enable
  output        DRAM_CAS_N,  //  SDRAM Column Address Strobe
  output        DRAM_RAS_N,  //  SDRAM Row Address Strobe
  output        DRAM_CS_N,   //  SDRAM Chip Select
  output        DRAM_BA_0,   //  SDRAM Bank Address 0
  output        DRAM_BA_1,   //  SDRAM Bank Address 0
  output        DRAM_CLK,    //  SDRAM Clock
  output        DRAM_CKE,    //  SDRAM Clock Enable
  // Flash Interface  
  inout   [7:0] FL_DQ,       //  FLASH Data bus 8 Bits
  output [21:0] FL_ADDR,     //  FLASH Address bus 22 Bits
  output        FL_WE_N,     //  FLASH Write Enable
  output        FL_RST_N,    //  FLASH Reset
  output        FL_OE_N,     //  FLASH Output Enable
  output        FL_CE_N,     //  FLASH Chip Enable
  // SRAM Interface  
  inout  [15:0] SRAM_DQ,     //  SRAM Data bus 16 Bits
  output [17:0] SRAM_ADDR,   //  SRAM Adress bus 18 Bits
  output        SRAM_UB_N,   //  SRAM High-byte Data Mask 
  output        SRAM_LB_N,   //  SRAM Low-byte Data Mask 
  output        SRAM_WE_N,   //  SRAM Write Enable
  output        SRAM_CE_N,   //  SRAM Chip Enable
  output        SRAM_OE_N,   //  SRAM Output Enable
  // ISP1362 Interface 
  inout  [15:0] OTG_DATA,    //  ISP1362 Data bus 16 Bits
  output  [1:0] OTG_ADDR,    //  ISP1362 Address 2 Bits
  output        OTG_CS_N,    //  ISP1362 Chip Select
  output        OTG_RD_N,    //  ISP1362 Write
  output        OTG_WR_N,    //  ISP1362 Read
  output        OTG_RST_N,   //  ISP1362 Reset
  output        OTG_FSPEED,  //  USB Full Speed,  0 = Enable, Z = Disable
  output        OTG_LSPEED,  //  USB Low Speed,   0 = Enable, Z = Disable
  input         OTG_INT0,    //  ISP1362 Interrupt 0
  input         OTG_INT1,    //  ISP1362 Interrupt 1
  input         OTG_DREQ0,   //  ISP1362 DMA Request 0
  input         OTG_DREQ1,   //  ISP1362 DMA Request 1
  output        OTG_DACK0_N, //  ISP1362 DMA Acknowledge 0
  output        OTG_DACK1_N, //  ISP1362 DMA Acknowledge 1
  // LCD Module 16X2   
  output        LCD_ON,      //  LCD Power ON/OFF
  output        LCD_BLON,    //  LCD Back Light ON/OFF
  output        LCD_RW,      //  LCD Read/Write Select, 0 = Write, 1 = Read
  output        LCD_EN,      //  LCD Enable
  output        LCD_RS,      //  LCD Command/Data Select, 0 = Command, 1 = Data
  inout   [7:0] LCD_DATA,    //  LCD Data bus 8 bits
  // SD_Card Interface 
  inout         SD_DAT,      //  SD Card Data
  inout         SD_DAT3,     //  SD Card Data 3
  inout         SD_CMD,      //  SD Card Command Signal
  output        SD_CLK,      //  SD Card Clock
  // USB JTAG link  
  input         TDI,         // CPLD -> FPGA (data in)
  input         TCK,         // CPLD -> FPGA (clk)
  input         TCS,         // CPLD -> FPGA (CS)
  output        TDO,         // FPGA -> CPLD (data out)
  // I2C    
  inout         I2C_SDAT,    //  I2C Data
  output        I2C_SCLK,    //  I2C Clock
  // PS2   
  input         PS2_DAT,     //  PS2 Data
  input         PS2_CLK,     //  PS2 Clock
  // VGA   
  output        VGA_CLK,     //  VGA Clock
  output        VGA_HS,      //  VGA H_SYNC
  output        VGA_VS,      //  VGA V_SYNC
  output        VGA_BLANK,   //  VGA BLANK
  output        VGA_SYNC,    //  VGA SYNC
  output  [9:0] VGA_R,       //  VGA Red[9:0]
  output  [9:0] VGA_G,       //  VGA Green[9:0]
  output  [9:0] VGA_B,       //  VGA Blue[9:0]
  // Ethernet Interface 
  inout  [15:0] ENET_DATA,   //  DM9000A DATA bus 16Bits
  output        ENET_CMD,    //  DM9000A Command/Data Select, 0 = Command, 1 = Data
  output        ENET_CS_N,   //  DM9000A Chip Select
  output        ENET_WR_N,   //  DM9000A Write
  output        ENET_RD_N,   //  DM9000A Read
  output        ENET_RST_N,  //  DM9000A Reset
  input         ENET_INT,    //  DM9000A Interrupt
  output        ENET_CLK,    //  DM9000A Clock 25 MHz
  // Audio CODEC 
  inout         AUD_ADCLRCK, //  Audio CODEC ADC LR Clock
  input         AUD_ADCDAT,  //  Audio CODEC ADC Data
  inout         AUD_DACLRCK, //  Audio CODEC DAC LR Clock
  output        AUD_DACDAT,  //  Audio CODEC DAC Data
  inout         AUD_BCLK,    //  Audio CODEC Bit-Stream Clock
  output        AUD_XCK,     //  Audio CODEC Chip Clock
  // TV Decoder  
  input   [7:0] TD_DATA,     //  TV Decoder Data bus 8 bits
  input         TD_HS,       //  TV Decoder H_SYNC
  input         TD_VS,       //  TV Decoder V_SYNC
  output        TD_RESET,    //  TV Decoder Reset
  input         TD_CLK,      //  TV Decoder Line Locked Clock
  // GPIO  
  inout  [35:0] GPIO_0,      //  GPIO Connection 0
  inout  [35:0] GPIO_1       //  GPIO Connection 1
);

  //  For Audio CODEC
  wire  AUD_CTRL_CLK;  //  For Audio Controller
  assign  AUD_XCK = AUD_CTRL_CLK;
  
  //assign GPIO_0[28] = BTN_a;
  assign GPIO_0[34] = DPDT_SW[0];
  assign GPIO_0[32] = DPDT_SW[1];
  assign GPIO_0[30] = DPDT_SW[2];
  assign GPIO_0[28] = DPDT_SW[3];
  assign GPIO_0[26] = DPDT_SW[4];
  assign GPIO_0[24] = DPDT_SW[5];
  assign GPIO_0[22] = DPDT_SW[6];
  assign GPIO_0[20] = DPDT_SW[7];

  //  7 segment LUT
  /*SEG7_LUT_8 u0 
  (
    .oSEG0  (HEX0),
    .oSEG1  (HEX1),
    .oSEG2  (HEX2),
    .oSEG3  (HEX3),
    .oSEG4  (HEX4),
    .oSEG5  (HEX5),
    .oSEG6  (HEX6),
    .oSEG7  (HEX7),
    .iDIG   (DPDT_SW) 
  );*/

  // Audio CODEC and video decoder setting
  I2C_AV_Config u1  
  (  //  Host Side
    .iCLK     (OSC_50),
    .iRST_N   (KEY[0]),
    //  I2C Side
    .I2C_SCLK (I2C_SCLK),
    .I2C_SDAT (I2C_SDAT)  
  );

  //  TV Decoder Stable Check
  TD_Detect u2 
  (  
    .oTD_Stable (TD_Stable),
    .iTD_VS     (TD_VS),
    .iTD_HS     (TD_HS),
    .iRST_N     (KEY[0])  
  );

  //  Reset Delay Timer
  Reset_Delay u3 
  (  
    .iCLK   (OSC_50),
    .iRST   (TD_Stable),
    .oRST_0 (DLY0),
    .oRST_1 (DLY1),
    .oRST_2 (DLY2)
  );

  //  ITU-R 656 to YUV 4:2:2
  ITU_656_Decoder u4 
  (  //  TV Decoder Input
    .iTD_DATA   (TD_DATA),
    //  Position Output
    .oTV_X      (TV_X),
    //.oTV_Y(TV_Y),
    //  YUV 4:2:2 Output
    .oYCbCr     (YCbCr),
    .oDVAL      (TV_DVAL),
    //  Control Signals
    .iSwap_CbCr (Quotient[0]),
    .iSkip      (Remain==4'h0),
    .iRST_N     (DLY1),
    .iCLK_27    (TD_CLK)  
  );

  //  For Down Sample 720 to 640
  DIV u5  
  (  
    .aclr     (!DLY0), 
    .clock    (TD_CLK),
    .denom    (4'h9),
    .numer    (TV_X),
    .quotient (Quotient),
    .remain   (Remain)
  );

  //  SDRAM frame buffer
  Sdram_Control_4Port u6  
  (  //  HOST Side
    .REF_CLK      (OSC_27),
    .CLK_18       (AUD_CTRL_CLK),
    .RESET_N      (1'b1),
    //  FIFO Write Side 1
    .WR1_DATA     (YCbCr),
    .WR1          (TV_DVAL),
    .WR1_FULL     (WR1_FULL),
    .WR1_ADDR     (0),
    .WR1_MAX_ADDR (640*507),    //  525-18
    .WR1_LENGTH   (9'h80),
    .WR1_LOAD     (!DLY0),
    .WR1_CLK      (TD_CLK),
    //  FIFO Read Side 1
    .RD1_DATA     (m1YCbCr),
    .RD1          (m1VGA_Read),
    .RD1_ADDR     (640*13),      //  Read odd field and bypess blanking
    .RD1_MAX_ADDR (640*253),
    .RD1_LENGTH   (9'h80),
    .RD1_LOAD     (!DLY0),
    .RD1_CLK      (OSC_27),
    //  FIFO Read Side 2
    .RD2_DATA     (m2YCbCr),
    .RD2          (m2VGA_Read),
    .RD2_ADDR     (640*267),      //  Read even field and bypess blanking
    .RD2_MAX_ADDR (640*507),
    .RD2_LENGTH   (9'h80),
    .RD2_LOAD     (!DLY0),
    .RD2_CLK      (OSC_27),
    //  SDRAM Side
    .SA           (DRAM_ADDR),
    .BA           ({DRAM_BA_1,DRAM_BA_0}),
    .CS_N         (DRAM_CS_N),
    .CKE          (DRAM_CKE),
    .RAS_N        (DRAM_RAS_N),
    .CAS_N        (DRAM_CAS_N),
    .WE_N         (DRAM_WE_N),
    .DQ           (DRAM_DQ),
    .DQM          ({DRAM_UDQM,DRAM_LDQM}),
    .SDR_CLK      (DRAM_CLK)  
  );

  //  YUV 4:2:2 to YUV 4:4:4
  YUV422_to_444 u7 
  (  //  YUV 4:2:2 Input
    .iYCbCr   (mYCbCr),
    //  YUV  4:4:4 Output
    .oY       (mY),
    .oCb      (mCb),
    .oCr      (mCr),
    //  Control Signals
    .iX       (VGA_X),
    .iCLK     (OSC_27),
    .iRST_N   (DLY0)
  );

  //  YCbCr 8-bit to RGB-10 bit 
  YCbCr2RGB u8 
  (  //  Output Side
    .Red      (mRed),
    .Green    (mGreen),
    .Blue     (mBlue),
    .oDVAL    (mDVAL),
    //  Input Side
    .iY       (mY),
    .iCb      (mCb),
    .iCr      (mCr),
    .iDVAL    (VGA_Read),
    //  Control Signal
    .iRESET   (!DLY2),
    .iCLK     (OSC_27)
  );

  // Comment out this module if you don't want the mirror effect
  /*Mirror_Col u100  
  (  //  Input Side
    .iCCD_R       (mRed),
    .iCCD_G       (mGreen),
    .iCCD_B       (mBlue),
    .iCCD_DVAL    (mDVAL),
    .iCCD_PIXCLK  (VGA_CLK), //(TD_CLK),
    .iRST_N       (DLY2),
    //  Output Side
    .oCCD_R       (Red),
    .oCCD_G       (Green),
    .oCCD_B       (Blue)//,
    //.oCCD_DVAL(TV_DVAL));
  );*/

  //VGA Controller
  VGA_Ctrl u9 
  (  //  Host Side
    .iRed       (mVGA_R), 
    .iGreen     (mVGA_G),
    .iBlue      (mVGA_B), 
    .oCurrent_X (VGA_X),
    .oCurrent_Y (VGA_Y),
    .oRequest   (VGA_Read),
    //  VGA Side
    .oVGA_R     (VGA_R),
    .oVGA_G     (VGA_G),
    .oVGA_B     (VGA_B),
    .oVGA_HS    (VGA_HS),
    .oVGA_VS    (VGA_VS),
    .oVGA_SYNC  (VGA_SYNC),
    .oVGA_BLANK (VGA_BLANK),
    .oVGA_CLOCK (VGA_CLK),
    //  Control Signal
    .iCLK       (OSC_27), // 27 MHz clock
    .iRST_N     (DLY2)  
  );
    
  wire [9:0]  mVGA_R;
  wire [9:0]  mVGA_G;
  wire [9:0]  mVGA_B;
  wire [9:0] Red, Green, Blue;

  // Check RGB value of a pixel in the background image in ROM memory.
  // If it's 0, black, get RGB value from the camcorder; 
  // otherwise print white lines and letters on the screen
  // To get grayscale, replace the next three lines with the commented-out lines
  assign  mVGA_R = mRed;//( Red >> 2 ) + ( Green >> 1 ) + ( Blue >> 3 );
  assign  mVGA_G = mGreen;//( Red >> 2 ) + ( Green >> 1 ) + ( Blue >> 3 );
  assign  mVGA_B = mBlue;//( Red >> 2 ) + ( Green >> 1 ) + ( Blue >> 3 );

  //  For ITU-R 656 Decoder
  wire  [15:0] YCbCr;
  wire  [9:0]  TV_X;
  wire         TV_DVAL;

  //  For VGA Controller
  wire  [9:0]  mRed;
  wire  [9:0]  mGreen;
  wire  [9:0]  mBlue;
  wire  [10:0] VGA_X;
  wire  [10:0] VGA_Y;
  wire  VGA_Read;  //  VGA data request
  wire  m1VGA_Read;  //  Read odd field
  wire  m2VGA_Read;  //  Read even field

  //  For YUV 4:2:2 to YUV 4:4:4
  wire  [7:0]  mY;
  wire  [7:0]  mCb;
  wire  [7:0]  mCr;

  //  For field select
  wire  [15:0]  mYCbCr;
  wire  [15:0]  mYCbCr_d;
  wire  [15:0]  m1YCbCr;
  wire  [15:0]  m2YCbCr;
  wire  [15:0]  m3YCbCr;

  //  For Delay Timer
  wire      TD_Stable;
  wire      DLY0;
  wire      DLY1;
  wire      DLY2;

  //  For Down Sample
  wire  [3:0]  Remain;
  wire  [9:0]  Quotient;

  assign  m1VGA_Read =  VGA_Y[0]  ?  1'b0     :  VGA_Read;
  assign  m2VGA_Read =  VGA_Y[0]  ?  VGA_Read :  1'b0;
  assign  mYCbCr_d   =  !VGA_Y[0] ?  m1YCbCr  :  m2YCbCr;
  assign  mYCbCr     =  m5YCbCr;

  wire      mDVAL;

  //  Line buffer, delay one line
  Line_Buffer u10  
  (  
    .clken    (VGA_Read),
    .clock    (OSC_27),
    .shiftin  (mYCbCr_d),
    .shiftout (m3YCbCr)
  );

  Line_Buffer u11
  (  
    .clken    (VGA_Read),
    .clock    (OSC_27),
    .shiftin  (m3YCbCr),
    .shiftout (m4YCbCr)
  );

  wire  [15:0] m4YCbCr;
  wire  [15:0] m5YCbCr;
  wire  [8:0]  Tmp1,Tmp2;
  wire  [7:0]  Tmp3,Tmp4;

  assign  Tmp1    = m4YCbCr[7:0] + mYCbCr_d[7:0];
  assign  Tmp2    = m4YCbCr[15:8] + mYCbCr_d[15:8];
  assign  Tmp3    = Tmp1[8:2] + m3YCbCr[7:1];
  assign  Tmp4    = Tmp2[8:2] + m3YCbCr[15:9];
  assign  m5YCbCr = { Tmp4, Tmp3 };

  assign  TD_RESET = 1'b1;  //  Allow 27 MHz

  AUDIO_DAC_ADC u12  
  (  //  Audio Side
    .oAUD_BCK     (AUD_BCLK),
    .oAUD_DATA    (AUD_DACDAT),
    .oAUD_LRCK    (AUD_DACLRCK),
    .oAUD_inL     (audio_inL), // audio data from ADC 
    .oAUD_inR     (audio_inR), // audio data from ADC 
    .iAUD_ADCDAT  (AUD_ADCDAT),
    .iAUD_extL    (audio_outL), // audio data to DAC
    .iAUD_extR    (audio_outR), // audio data to DAC
    //  Control Signals
    .iCLK_18_4    (AUD_CTRL_CLK),
    .iRST_N       (DLY0)
  );

endmodule