// --------------------------------------------------------------------
// Nintendo Ninja: An FPGA AI for Super Mario Bros on the NES.
// --------------------------------------------------------------------
//
// Final Project for ECE5760: Advanced Microcontroller Design
// Jeremy Blum, Sima Mitra, Jason Wright


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

// --------------------------------------------------------------------
// CONFIGURATION VARIABLES!
// --------------------------------------------------------------------
parameter PIPE_X_MAX_RANGE   = 400;
parameter PIPE_X_MIN_RANGE   = 300;
parameter GOOMBA_X_MAX_RANGE = 430; //390?
parameter GOOMBA_X_MIN_RANGE = 320;
parameter BRICK_X_MAX_RANGE  = 450;
parameter BRICK_X_MIN_RANGE  = 320;
  
// --------------------------------------------------------------------
// GPIO/NES Controller Setup
// --------------------------------------------------------------------
  
  assign GPIO_0[34] = DPDT_SW[0]; //Start
  //assign GPIO_0[32] = DPDT_SW[1]; //Select
  /*
  assign GPIO_0[30] = DPDT_SW[2]; //B
  assign GPIO_0[28] = DPDT_SW[3]; //A
  assign GPIO_0[26] = DPDT_SW[4]; //Right
  assign GPIO_0[24] = DPDT_SW[5]; //Left
  assign GPIO_0[22] = DPDT_SW[6]; //Up
  assign GPIO_0[20] = DPDT_SW[7]; //Down
  */
  
  //assign GPIO_0[24] = KEY[3]; //Left
  //assign GPIO_0[26] = KEY[2]; //Right
  //assign GPIO_0[30] = KEY[1]; //B
  //assign GPIO_0[28] = KEY[0]; //A
  
  reg BTN_left = 1'b1;
  
  reg BTN_right = 1'b0;
  reg BTN_b = 1'b0; 
  reg BTN_a = 1'b1;
  
  assign GPIO_0[24] = BTN_left;
  assign GPIO_0[26] = BTN_right || ~DPDT_SW[0]; //Release if we push start
  //assign GPIO_0[30] = BTN_b || ~DPDT_SW[0]; //Release if we push start
  assign GPIO_0[30] = ~multi_goomba_found || DPDT_SW[1] || ~DPDT_SW[0]; 
  assign GPIO_0[28] = BTN_a;
  
// --------------------------------------------------------------------
// LEDs
// --------------------------------------------------------------------
  
   assign LED_RED[17] = BTN_a;
	assign LED_RED[16] = jump_now;
	assign LED_RED[15] = jump_flag_pgm;
	assign LED_RED[14] = jump_flag_ctrl;
	assign LED_RED[13] = short_jumping;
	assign LED_RED[12] = pipe_corner_found;
	assign LED_RED[11] = brick_edge_found || block_wall_found;
	assign LED_RED[10] = goomba_found;
	assign LED_RED[9]  = multi_goomba_found;
	//assign LED_RED[9:0] = goomba_found_sum_frame >> 3;
	assign LED_RED[8:0] = brick_edge_found_sum;
	
	assign GPIO_1[5] = brick_edge_found || block_wall_found;
	assign GPIO_1[7] = goomba_found;
	assign GPIO_1[9] = pipe_corner_found;
	

	assign LED_GREEN[7] = ~KEY[3];
	assign LED_GREEN[6] = ~KEY[3];
	assign LED_GREEN[5] = ~KEY[2];
	assign LED_GREEN[4] = ~KEY[2];
	assign LED_GREEN[3] = ~KEY[1];
	assign LED_GREEN[2] = ~KEY[1];
	assign LED_GREEN[1] = ~KEY[0];
	assign LED_GREEN[0] = ~KEY[0];
  
// --------------------------------------------------------------------
// SETTING JUMP FLAG WHEN OBJECTS SEEN
// --------------------------------------------------------------------
  
  reg[3:0] seconds_ones;
  reg[3:0] seconds_tens;
  reg[3:0] seconds_hundreds;
  reg[3:0] seconds_thousands;
	 
  reg[26:0] counter_ones;
  reg[26:0] counter_jump;
  
	reg jump_flag_pgm;  //Tells it to jump
	reg short_jump_flag_pgm;
	
	reg jump_flag_ctrl; //Dont want to jump if already mid-jump
	
	//Jump now only if being told to jump, and not presently jumping.
	wire jump_now = jump_flag_pgm & jump_flag_ctrl; 
	
	wire short_jump_now = short_jump_flag_pgm & jump_flag_ctrl;
	
	reg [9:0] jump_count;
	reg [9:0] short_jump_count;
	
	always @ (negedge new_frame)
	begin
		if (pipe_corner_found || brick_edge_found || block_wall_found)
		begin
			jump_count <= jump_count + 1;
			jump_flag_pgm <= 0;
		end
		else
		begin
			jump_count <= 0;
			jump_flag_pgm <= 0;
		end
		
		if (goomba_found)
		begin
			short_jump_count <= short_jump_count + 1;
			short_jump_flag_pgm <= 0;
		end
		else
		begin
			short_jump_count <= 0;
			short_jump_flag_pgm <= 0;
		end
		
		//Jump only if there are enough triggers in a row, and if we're not already jumping
		if (jump_count > 1 && jump_flag_ctrl)
		begin
			jump_flag_pgm <= 1;
			jump_count <= 0;
		end
		
		if (short_jump_count > 1 && jump_flag_ctrl)
		begin
			short_jump_flag_pgm <= 1;
			short_jump_count <= 0;
		end
		
	end
	
	/////////////////////////JUMPING/////////////////////////////////<--fix this
	
	reg short_jumping;
	
	always @ (posedge OSC_27 or negedge KEY[1] or posedge jump_now or posedge short_jump_now)
	begin
		if(!KEY[1] || jump_now)
		begin
			counter_jump <= 0;
			jump_flag_ctrl <= 0;
			short_jumping <= 0;
		end
		else if (short_jump_now)
		begin
			counter_jump <= 0;
			jump_flag_ctrl <= 0;
			short_jumping <= 1;
		end
		else
		begin
			//Press the A Button
			if(counter_jump == 1)
			begin
				BTN_a <= 0;
			end
			//Release the A Button 17 - 8 [17:0] DPDT_SW
			//moving to switches (DPDT_SW[17:13]<<19)
			if(counter_jump == 4199999 && short_jumping) //3599999 //3399999
			begin
				BTN_a <= 1;
			end
			
			if(counter_jump == 4219999 && short_jumping) //3629999 //3409999
			begin
				jump_flag_ctrl <= 1;
			end
			
			if(counter_jump == 11599999)
			begin
				BTN_a <= 1;
			end
			
			//Do not allow the A button to be pressed again for a while  (DPDT_SW[12:8]<<19)
			if(counter_jump == 11899999)
			begin
				jump_flag_ctrl <= 1;
			end
			
			else
			begin
				counter_jump <= counter_jump+1;
			end
		end
	end
	 
	//every 50 MHz
	//This is just a counter on the Hex LEDs
	always@(posedge OSC_50 or negedge KEY[0])
	begin
		
		if(!KEY[0])
		begin
			seconds_ones		<=	0;
			seconds_tens		<= 0;
			seconds_hundreds 	<= 0;
			seconds_thousands <= 0;
			counter_ones		<=	0;
			
		end
		else
		begin
			
			if(counter_ones == 49999999 )
			begin
				seconds_ones	<=	seconds_ones+1;
				//BTN_a <= ~BTN_a;
				counter_ones	<=	0;		
			end

			else
			begin
				counter_ones	<=	counter_ones+1;	
			end
			

			if (seconds_ones == 10)
			begin
				seconds_ones <= 0;
				seconds_tens <= seconds_tens+1;
			end

			if (seconds_tens == 10)
			begin
				seconds_tens <=0;
				seconds_hundreds <= seconds_hundreds+1;
			end

			if (seconds_hundreds == 10)
			begin
				seconds_hundreds <= 0;
				seconds_thousands <= seconds_thousands+1;
			end


		end
	end


	HexDigit H0(HEX0, seconds_ones);
	HexDigit H1(HEX1, seconds_tens);
	HexDigit H2(HEX2, seconds_hundreds);
	HexDigit H3(HEX3, seconds_thousands);

	assign HEX4 = 7'h7F;
	assign HEX5 = 7'h7F;
	assign HEX6 = 7'h7F;
	assign HEX7 = 7'h7F;
	
// --------------------------------------------------------------------
// Codec/Video Conversion
// --------------------------------------------------------------------

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
	 //.WR1_LOAD     (!DLY0),
    .WR1_CLK      (TD_CLK),
    //  FIFO Read Side 1
    .RD1_DATA     (m1YCbCr),
    .RD1          (m1VGA_Read),
    .RD1_ADDR     (640*13),      //  Read odd field and bypess blanking
    .RD1_MAX_ADDR (640*253),      // 13 and 253
    .RD1_LENGTH   (9'h80),
    .RD1_LOAD     (!DLY0),
	 //.RD1_LOAD     (!DLY1),
    .RD1_CLK      (OSC_27),
    //  FIFO Read Side 2
    .RD2_DATA     (m2YCbCr),
    .RD2          (m2VGA_Read),
    .RD2_ADDR     (640*267),      //  Read even field and bypess blanking
    .RD2_MAX_ADDR (640*507),      // 267 and 507
    .RD2_LENGTH   (9'h80),
    .RD2_LOAD     (!DLY0),
	 //.RD2_LOAD     (!DLY1),
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
    //.iCb      (mCb),
    //.iCr      (mCr),
	 .iCb      (mCb_int),
    .iCr      (mCr_int),
    .iDVAL    (VGA_Read),
    //  Control Signal
    .iRESET   (!DLY2),
    .iCLK     (OSC_27)
  );
  
// --------------------------------------------------------------------
// Chroma/Luma Correction
// --------------------------------------------------------------------
  
  wire flipCL = DPDT_SW[6] ? DPDT_SW[5] : flipCLctrl;
  wire [7:0] mCb_int = flipCL ? mCb : mCr;
  wire [7:0] mCr_int = flipCL ? mCr : mCb;
  
   reg flipCLctrl;
	reg flipCLdet_a;
	reg flipCLdet_b;
	reg flipCLdet_c;
	
	//wire flipCLdet = ((flipCLdet_a && flipCLdet_b) || (flipCLdet_a && flipCLdet_c) || (flipCLdet_b && flipCLdet_c));
	wire flipCLdet = flipCLdet_a || flipCLdet_b || flipCLdet_c;
	
	always @ (VGA_CLK)
	begin
		if (VGA_X == 15 && VGA_Y == 50)
		//A pixel check
		begin
			flipCLdet_a <= mVGA_r_th;
			flipCLdet_b <= flipCLdet_b;
			flipCLdet_c <= flipCLdet_c;
		end
		if (VGA_X == 15 && VGA_Y == 75)
		//B pixel check
		begin
			flipCLdet_a <= flipCLdet_a;
			flipCLdet_b <= mVGA_r_th;
			flipCLdet_c <= flipCLdet_c;
		end
		if (VGA_X == 15 && VGA_Y == 100)
		//C pixel check
		begin
			flipCLdet_a <= flipCLdet_a;
			flipCLdet_b <= flipCLdet_b;
			flipCLdet_c <= mVGA_r_th;
		end
		else
		begin
			flipCLdet_a <= flipCLdet_a;
			flipCLdet_b <= flipCLdet_b;
			flipCLdet_c <= flipCLdet_c;
		end
		if (flipCLdet && (VGA_Y == 101) && (VGA_X == 0))
		begin
			flipCLctrl <= ~flipCLctrl;
		end
	end
  
// --------------------------------------------------------------------
// VGA Controller
// --------------------------------------------------------------------

  //VGA Controller
  VGA_Ctrl u9 
  (  //  Host Side
    .iRed       (mVGA_R), 
    .iGreen     (mVGA_G),
    .iBlue      (mVGA_B), 
    .oCurrent_X (VGA_X),
    .oCurrent_Y (VGA_Y),  
    .oRequest   (VGA_Read),
	 .oShift_Flag(Shift_En),
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
  
  // Recolors Parts of the display
  recolor u100  
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
  );
  
// --------------------------------------------------------------------
// Thresholding
// --------------------------------------------------------------------
    
  wire [9:0]  mVGA_R;
  wire [9:0]  mVGA_G;
  wire [9:0]  mVGA_B;
  
  wire			Shift_En;
  
  wire [9:0]  mVGA_R_int;
  wire [9:0]  mVGA_G_int;
  wire [9:0]  mVGA_B_int;
  
  wire [9:0] Red, Green, Blue;

  assign  mVGA_R_int = Red;
  assign  mVGA_G_int = Green;
  assign  mVGA_B_int = Blue;
  
  wire mVGA_r_th = (mVGA_R_int > (10'b1000000000)) ? 1 : 0;
  wire mVGA_g_th = (mVGA_G_int > (10'b1000000000)) ? 1 : 0;
  wire mVGA_b_th = (mVGA_B_int > (10'b1000000000)) ? 1 : 0;
  
  //Good values for the pipe
  //wire mVGA_r_th_pipe = (mVGA_R_int > (10'b1000000000)) ? 1 : 0;
  //wire mVGA_g_th_pipe = (mVGA_G_int > (10'b1000000000)) ? 1 : 0;
  //wire mVGA_b_th_pipe = (mVGA_B_int > (10'b1000000000)) ? 1 : 0;
  
  wire [9:0] mVGA_r_th_full = (mVGA_r_th == 1) ? 10'b1111111111 : 0;
  wire [9:0] mVGA_g_th_full = (mVGA_g_th == 1) ? 10'b1111111111 : 0;
  wire [9:0] mVGA_b_th_full = (mVGA_b_th == 1) ? 10'b1111111111 : 0;
  
  
//  reg [10:0] VGA_Y_fake;
//  //FAKE VGA_Y
//  always @ (VGA_X)
//  begin
//	if (VGA_X == 640)
//	begin
//		VGA_Y_fake <= VGA_Y_fake + 10'b1;
//	end
//	if (VGA_Y_fake == 480)
//	begin
//		VGA_Y_fake <= 10'b0;
//	end
//  end
//
//  assign VGA_Y = VGA_Y_fake;
  
  
  //assign mVGA_R = (VGA_X > 11'b00101000000) ? Red : 10'b1111111111;
  //assign mVGA_R = VGA_row_R[VGA_X];
  //assign mVGA_G = (VGA_X > 11'b00101000000) ? Green : 0;
  //assign mVGA_B = (VGA_X > 11'b00101000000) ? Blue : 0;
  
  
  
  //assign mVGA_gs = Red + Green + Blue;
  
  
  //reg [639:0] VGA_row_gs;
  
  //reg VGA_pixel_gs;
  
//  always @ (OSC_27)
//  begin
//		VGA_pixel_gs <= (mVGA_R_int > DPDT_SW[17:8]) ? 1 : 0;
//  end
  
//  reg [319:0] row400;
	/*
  reg [639:0] row1;
  reg [639:0] row2;
  reg [639:0] row3;
  reg [639:0] row4;
  reg [639:0] row5;
  reg [639:0] row6;
  reg [639:0] row7;
  reg [639:0] row8;
  reg [639:0] row9;
  reg [639:0] row10;
  */
  //reg [10:0] VGA_X_L;
  //reg [10:0] VGA_Y_L;
  
  //reg [7:0] status;
  
  //assign LED_GREEN[7:2] = grid[8:3];
  //assign LED_GREEN[1] = Shift_En;
  //assign LED_GREEN[0] = mVGA_th;
  
  //reg [3839:0] rowbuffer;
  
  //parameter rowStart = 400;
  
  //wire [8:0] grid;
  
  //wire [8:0] kernel = DPDT_SW[10:2];
  
// --------------------------------------------------------------------
// Buffering
// --------------------------------------------------------------------
	
	wire [120:0] grid_r;
	
	buffer11 	delayer_r(
		.clock		(OSC_27),
		.clken		(Shift_En),
		.shiftin		(mVGA_r_th),
		.oGrid		(grid_r) 
	);
	
	wire [120:0] grid_g;
	
	buffer11 	delayer_g(
		.clock		(OSC_27),
		.clken		(Shift_En),
		.shiftin		(mVGA_g_th),
		.oGrid		(grid_g) 
	);
	
	wire [120:0] grid_b;
	
	buffer11 	delayer_b(
		.clock		(OSC_27),
		.clken		(Shift_En),
		.shiftin		(mVGA_b_th),
		.oGrid		(grid_b) 
	);
	
	wire [120:0] grid_goomba;
	
	buffer11 	delayer_goomba(
		.clock		(OSC_27),
		.clken		(Shift_En),
		.shiftin		(goomba_color),
		.oGrid		(grid_goomba) 
	);
  
// --------------------------------------------------------------------
// Pattern Recognition
// --------------------------------------------------------------------
  
  wire [6:0] kd_thresh = DPDT_SW[15:10] << 1; //6'b010110;
  
  wire [120:0] kernel_goomba_g = 121'b1111111111111111111111111111111110111111111000111111100000111110000000000000000000000000000000000000000000000000000000000;
  wire [120:0] kernel_goomba_r = 121'b1111111111111111111111111111111110111111111000111111100000111110001111111111111111111111111111111111111111111111111111111;
  wire [120:0] kernel_goomba_b = 121'b1111111111111111111111111111111110111111100000111111000000111110000000000000000000000000000000000000000000000000000000000;
 
  
  wire [120:0] kernel_pipe_corner_g = 121'b1111111111110000000000100000000001000000000010001111111100011111111000111111110001111111100011111111000111111110001111111;
  wire [120:0] kernel_pipe_corner_b = 121'b1111111111110000000000100000000001000000000010000000000100000000001000000000010000000000100000000001000000000010000000000;
  wire [120:0] kernel_pipe_corner_r = 121'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  
  wire [120:0] kernel_brick_edge_g = 121'b1111111111110011111111100111111111111111111111110000000111100000001111000000011110000000111100000001111000000011110000000;
  wire [120:0] kernel_brick_edge_b = 121'b1111111111111111111111111111111111111000000011100000000111000000001110000000011100000000111000000001110000000011100000000;
  wire [120:0] kernel_brick_edge_r = 121'b0000000000000011111111100111111111111111111101110111111011101111111111111111101111111111011111111110111111111101111111111;

  wire [120:0] kernel_mario_g = 121'b0010000010111100000111110000001110000000011111000000011110000000011100000000011000000000110000001000000000110100000000000;
  wire [120:0] kernel_mario_b = 121'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  wire [120:0] kernel_mario_r = 121'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111;

  wire [120:0] kernel_bar_g = 121'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  wire [120:0] kernel_bar_b = 121'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  wire [120:0] kernel_bar_r = 121'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;

  wire [120:0] kernel_goomba_color = 121'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111;
  
  wire [120:0] kd_goomba_r = kernel_goomba_r ^ grid_r;
  wire [120:0] kd_goomba_g = kernel_goomba_g ^ grid_g;
  wire [120:0] kd_goomba_b = kernel_goomba_b ^ grid_b;
  
  wire [120:0] kd_pipe_corner_r = kernel_pipe_corner_r ^ grid_r;
  wire [120:0] kd_pipe_corner_g = kernel_pipe_corner_g ^ grid_g;
  wire [120:0] kd_pipe_corner_b = kernel_pipe_corner_b ^ grid_b;
  
  wire [120:0] kd_brick_edge_r = kernel_brick_edge_r ^ grid_r;
  wire [120:0] kd_brick_edge_g = kernel_brick_edge_g ^ grid_g;
  wire [120:0] kd_brick_edge_b = kernel_brick_edge_b ^ grid_b;
  
  wire [120:0] kd_mario_r = kernel_mario_r ^ grid_r;
  wire [120:0] kd_mario_g = kernel_mario_g ^ grid_g;
  wire [120:0] kd_mario_b = kernel_mario_b ^ grid_b;
  
  wire [120:0] kd_bar_r = kernel_bar_r ^ grid_r;
  wire [120:0] kd_bar_g = kernel_bar_g ^ grid_g;
  wire [120:0] kd_bar_b = kernel_bar_b ^ grid_b;
  
  //wire [120:0] kd_goomba_color_r = kernel_goomba_color ^ grid_goomba;
  wire [120:0] kd_goomba_color_r = grid_goomba;
  
  //wire [2:0] kd_sum = kd[8] + kd[7] + kd[6] + kd[5] + kd[4] + kd[3] + kd[2] + kd[1] + kd[0];
  wire [6:0] kd_goomba_sum_r = kd_goomba_r[120] + kd_goomba_r[119] + kd_goomba_r[118] + kd_goomba_r[117] + kd_goomba_r[116] + kd_goomba_r[115] + kd_goomba_r[114] + kd_goomba_r[113] + kd_goomba_r[112] + kd_goomba_r[111] + kd_goomba_r[110] + kd_goomba_r[109] + kd_goomba_r[108] + kd_goomba_r[107] + kd_goomba_r[106] + kd_goomba_r[105] + kd_goomba_r[104] + kd_goomba_r[103] + kd_goomba_r[102] + kd_goomba_r[101] + kd_goomba_r[100] + kd_goomba_r[99] + kd_goomba_r[98] + kd_goomba_r[97] + kd_goomba_r[96] + kd_goomba_r[95] + kd_goomba_r[94] + kd_goomba_r[93] + kd_goomba_r[92] + kd_goomba_r[91] + kd_goomba_r[90] + kd_goomba_r[89] + kd_goomba_r[88] + kd_goomba_r[87] + kd_goomba_r[86] + kd_goomba_r[85] + kd_goomba_r[84] + kd_goomba_r[83] + kd_goomba_r[82] + kd_goomba_r[81] + kd_goomba_r[80] + kd_goomba_r[79] + kd_goomba_r[78] + kd_goomba_r[77] + kd_goomba_r[76] + kd_goomba_r[75] + kd_goomba_r[74] + kd_goomba_r[73] + kd_goomba_r[72] + kd_goomba_r[71] + kd_goomba_r[70] + kd_goomba_r[69] + kd_goomba_r[68] + kd_goomba_r[67] + kd_goomba_r[66] + kd_goomba_r[65] + kd_goomba_r[64] + kd_goomba_r[63] + kd_goomba_r[62] + kd_goomba_r[61] + kd_goomba_r[60] + kd_goomba_r[59] + kd_goomba_r[58] + kd_goomba_r[57] + kd_goomba_r[56] + kd_goomba_r[55] + kd_goomba_r[54] + kd_goomba_r[53] + kd_goomba_r[52] + kd_goomba_r[51] + kd_goomba_r[50] + kd_goomba_r[49] + kd_goomba_r[48] + kd_goomba_r[47] + kd_goomba_r[46] + kd_goomba_r[45] + kd_goomba_r[44] + kd_goomba_r[43] + kd_goomba_r[42] + kd_goomba_r[41] + kd_goomba_r[40] + kd_goomba_r[39] + kd_goomba_r[38] + kd_goomba_r[37] + kd_goomba_r[36] + kd_goomba_r[35] + kd_goomba_r[34] + kd_goomba_r[33] + kd_goomba_r[32] + kd_goomba_r[31] + kd_goomba_r[30] + kd_goomba_r[29] + kd_goomba_r[28] + kd_goomba_r[27] + kd_goomba_r[26] + kd_goomba_r[25] + kd_goomba_r[24] + kd_goomba_r[23] + kd_goomba_r[22] + kd_goomba_r[21] + kd_goomba_r[20] + kd_goomba_r[19] + kd_goomba_r[18] + kd_goomba_r[17] + kd_goomba_r[16] + kd_goomba_r[15] + kd_goomba_r[14] + kd_goomba_r[13] + kd_goomba_r[12] + kd_goomba_r[11] + kd_goomba_r[10] + kd_goomba_r[9] + kd_goomba_r[8] + kd_goomba_r[7] + kd_goomba_r[6] + kd_goomba_r[5] + kd_goomba_r[4] + kd_goomba_r[3] + kd_goomba_r[2] + kd_goomba_r[1] + kd_goomba_r[0];
  wire [6:0] kd_goomba_sum_g = kd_goomba_g[120] + kd_goomba_g[119] + kd_goomba_g[118] + kd_goomba_g[117] + kd_goomba_g[116] + kd_goomba_g[115] + kd_goomba_g[114] + kd_goomba_g[113] + kd_goomba_g[112] + kd_goomba_g[111] + kd_goomba_g[110] + kd_goomba_g[109] + kd_goomba_g[108] + kd_goomba_g[107] + kd_goomba_g[106] + kd_goomba_g[105] + kd_goomba_g[104] + kd_goomba_g[103] + kd_goomba_g[102] + kd_goomba_g[101] + kd_goomba_g[100] + kd_goomba_g[99] + kd_goomba_g[98] + kd_goomba_g[97] + kd_goomba_g[96] + kd_goomba_g[95] + kd_goomba_g[94] + kd_goomba_g[93] + kd_goomba_g[92] + kd_goomba_g[91] + kd_goomba_g[90] + kd_goomba_g[89] + kd_goomba_g[88] + kd_goomba_g[87] + kd_goomba_g[86] + kd_goomba_g[85] + kd_goomba_g[84] + kd_goomba_g[83] + kd_goomba_g[82] + kd_goomba_g[81] + kd_goomba_g[80] + kd_goomba_g[79] + kd_goomba_g[78] + kd_goomba_g[77] + kd_goomba_g[76] + kd_goomba_g[75] + kd_goomba_g[74] + kd_goomba_g[73] + kd_goomba_g[72] + kd_goomba_g[71] + kd_goomba_g[70] + kd_goomba_g[69] + kd_goomba_g[68] + kd_goomba_g[67] + kd_goomba_g[66] + kd_goomba_g[65] + kd_goomba_g[64] + kd_goomba_g[63] + kd_goomba_g[62] + kd_goomba_g[61] + kd_goomba_g[60] + kd_goomba_g[59] + kd_goomba_g[58] + kd_goomba_g[57] + kd_goomba_g[56] + kd_goomba_g[55] + kd_goomba_g[54] + kd_goomba_g[53] + kd_goomba_g[52] + kd_goomba_g[51] + kd_goomba_g[50] + kd_goomba_g[49] + kd_goomba_g[48] + kd_goomba_g[47] + kd_goomba_g[46] + kd_goomba_g[45] + kd_goomba_g[44] + kd_goomba_g[43] + kd_goomba_g[42] + kd_goomba_g[41] + kd_goomba_g[40] + kd_goomba_g[39] + kd_goomba_g[38] + kd_goomba_g[37] + kd_goomba_g[36] + kd_goomba_g[35] + kd_goomba_g[34] + kd_goomba_g[33] + kd_goomba_g[32] + kd_goomba_g[31] + kd_goomba_g[30] + kd_goomba_g[29] + kd_goomba_g[28] + kd_goomba_g[27] + kd_goomba_g[26] + kd_goomba_g[25] + kd_goomba_g[24] + kd_goomba_g[23] + kd_goomba_g[22] + kd_goomba_g[21] + kd_goomba_g[20] + kd_goomba_g[19] + kd_goomba_g[18] + kd_goomba_g[17] + kd_goomba_g[16] + kd_goomba_g[15] + kd_goomba_g[14] + kd_goomba_g[13] + kd_goomba_g[12] + kd_goomba_g[11] + kd_goomba_g[10] + kd_goomba_g[9] + kd_goomba_g[8] + kd_goomba_g[7] + kd_goomba_g[6] + kd_goomba_g[5] + kd_goomba_g[4] + kd_goomba_g[3] + kd_goomba_g[2] + kd_goomba_g[1] + kd_goomba_g[0];
  wire [6:0] kd_goomba_sum_b = kd_goomba_b[120] + kd_goomba_b[119] + kd_goomba_b[118] + kd_goomba_b[117] + kd_goomba_b[116] + kd_goomba_b[115] + kd_goomba_b[114] + kd_goomba_b[113] + kd_goomba_b[112] + kd_goomba_b[111] + kd_goomba_b[110] + kd_goomba_b[109] + kd_goomba_b[108] + kd_goomba_b[107] + kd_goomba_b[106] + kd_goomba_b[105] + kd_goomba_b[104] + kd_goomba_b[103] + kd_goomba_b[102] + kd_goomba_b[101] + kd_goomba_b[100] + kd_goomba_b[99] + kd_goomba_b[98] + kd_goomba_b[97] + kd_goomba_b[96] + kd_goomba_b[95] + kd_goomba_b[94] + kd_goomba_b[93] + kd_goomba_b[92] + kd_goomba_b[91] + kd_goomba_b[90] + kd_goomba_b[89] + kd_goomba_b[88] + kd_goomba_b[87] + kd_goomba_b[86] + kd_goomba_b[85] + kd_goomba_b[84] + kd_goomba_b[83] + kd_goomba_b[82] + kd_goomba_b[81] + kd_goomba_b[80] + kd_goomba_b[79] + kd_goomba_b[78] + kd_goomba_b[77] + kd_goomba_b[76] + kd_goomba_b[75] + kd_goomba_b[74] + kd_goomba_b[73] + kd_goomba_b[72] + kd_goomba_b[71] + kd_goomba_b[70] + kd_goomba_b[69] + kd_goomba_b[68] + kd_goomba_b[67] + kd_goomba_b[66] + kd_goomba_b[65] + kd_goomba_b[64] + kd_goomba_b[63] + kd_goomba_b[62] + kd_goomba_b[61] + kd_goomba_b[60] + kd_goomba_b[59] + kd_goomba_b[58] + kd_goomba_b[57] + kd_goomba_b[56] + kd_goomba_b[55] + kd_goomba_b[54] + kd_goomba_b[53] + kd_goomba_b[52] + kd_goomba_b[51] + kd_goomba_b[50] + kd_goomba_b[49] + kd_goomba_b[48] + kd_goomba_b[47] + kd_goomba_b[46] + kd_goomba_b[45] + kd_goomba_b[44] + kd_goomba_b[43] + kd_goomba_b[42] + kd_goomba_b[41] + kd_goomba_b[40] + kd_goomba_b[39] + kd_goomba_b[38] + kd_goomba_b[37] + kd_goomba_b[36] + kd_goomba_b[35] + kd_goomba_b[34] + kd_goomba_b[33] + kd_goomba_b[32] + kd_goomba_b[31] + kd_goomba_b[30] + kd_goomba_b[29] + kd_goomba_b[28] + kd_goomba_b[27] + kd_goomba_b[26] + kd_goomba_b[25] + kd_goomba_b[24] + kd_goomba_b[23] + kd_goomba_b[22] + kd_goomba_b[21] + kd_goomba_b[20] + kd_goomba_b[19] + kd_goomba_b[18] + kd_goomba_b[17] + kd_goomba_b[16] + kd_goomba_b[15] + kd_goomba_b[14] + kd_goomba_b[13] + kd_goomba_b[12] + kd_goomba_b[11] + kd_goomba_b[10] + kd_goomba_b[9] + kd_goomba_b[8] + kd_goomba_b[7] + kd_goomba_b[6] + kd_goomba_b[5] + kd_goomba_b[4] + kd_goomba_b[3] + kd_goomba_b[2] + kd_goomba_b[1] + kd_goomba_b[0];

  wire [9:0] kd_goomba_sum = kd_goomba_sum_r + kd_goomba_sum_g + kd_goomba_sum_b;

  wire [6:0] kd_pipe_corner_sum_r = kd_pipe_corner_r[120] + kd_pipe_corner_r[119] + kd_pipe_corner_r[118] + kd_pipe_corner_r[117] + kd_pipe_corner_r[116] + kd_pipe_corner_r[115] + kd_pipe_corner_r[114] + kd_pipe_corner_r[113] + kd_pipe_corner_r[112] + kd_pipe_corner_r[111] + kd_pipe_corner_r[110] + kd_pipe_corner_r[109] + kd_pipe_corner_r[108] + kd_pipe_corner_r[107] + kd_pipe_corner_r[106] + kd_pipe_corner_r[105] + kd_pipe_corner_r[104] + kd_pipe_corner_r[103] + kd_pipe_corner_r[102] + kd_pipe_corner_r[101] + kd_pipe_corner_r[100] + kd_pipe_corner_r[99] + kd_pipe_corner_r[98] + kd_pipe_corner_r[97] + kd_pipe_corner_r[96] + kd_pipe_corner_r[95] + kd_pipe_corner_r[94] + kd_pipe_corner_r[93] + kd_pipe_corner_r[92] + kd_pipe_corner_r[91] + kd_pipe_corner_r[90] + kd_pipe_corner_r[89] + kd_pipe_corner_r[88] + kd_pipe_corner_r[87] + kd_pipe_corner_r[86] + kd_pipe_corner_r[85] + kd_pipe_corner_r[84] + kd_pipe_corner_r[83] + kd_pipe_corner_r[82] + kd_pipe_corner_r[81] + kd_pipe_corner_r[80] + kd_pipe_corner_r[79] + kd_pipe_corner_r[78] + kd_pipe_corner_r[77] + kd_pipe_corner_r[76] + kd_pipe_corner_r[75] + kd_pipe_corner_r[74] + kd_pipe_corner_r[73] + kd_pipe_corner_r[72] + kd_pipe_corner_r[71] + kd_pipe_corner_r[70] + kd_pipe_corner_r[69] + kd_pipe_corner_r[68] + kd_pipe_corner_r[67] + kd_pipe_corner_r[66] + kd_pipe_corner_r[65] + kd_pipe_corner_r[64] + kd_pipe_corner_r[63] + kd_pipe_corner_r[62] + kd_pipe_corner_r[61] + kd_pipe_corner_r[60] + kd_pipe_corner_r[59] + kd_pipe_corner_r[58] + kd_pipe_corner_r[57] + kd_pipe_corner_r[56] + kd_pipe_corner_r[55] + kd_pipe_corner_r[54] + kd_pipe_corner_r[53] + kd_pipe_corner_r[52] + kd_pipe_corner_r[51] + kd_pipe_corner_r[50] + kd_pipe_corner_r[49] + kd_pipe_corner_r[48] + kd_pipe_corner_r[47] + kd_pipe_corner_r[46] + kd_pipe_corner_r[45] + kd_pipe_corner_r[44] + kd_pipe_corner_r[43] + kd_pipe_corner_r[42] + kd_pipe_corner_r[41] + kd_pipe_corner_r[40] + kd_pipe_corner_r[39] + kd_pipe_corner_r[38] + kd_pipe_corner_r[37] + kd_pipe_corner_r[36] + kd_pipe_corner_r[35] + kd_pipe_corner_r[34] + kd_pipe_corner_r[33] + kd_pipe_corner_r[32] + kd_pipe_corner_r[31] + kd_pipe_corner_r[30] + kd_pipe_corner_r[29] + kd_pipe_corner_r[28] + kd_pipe_corner_r[27] + kd_pipe_corner_r[26] + kd_pipe_corner_r[25] + kd_pipe_corner_r[24] + kd_pipe_corner_r[23] + kd_pipe_corner_r[22] + kd_pipe_corner_r[21] + kd_pipe_corner_r[20] + kd_pipe_corner_r[19] + kd_pipe_corner_r[18] + kd_pipe_corner_r[17] + kd_pipe_corner_r[16] + kd_pipe_corner_r[15] + kd_pipe_corner_r[14] + kd_pipe_corner_r[13] + kd_pipe_corner_r[12] + kd_pipe_corner_r[11] + kd_pipe_corner_r[10] + kd_pipe_corner_r[9] + kd_pipe_corner_r[8] + kd_pipe_corner_r[7] + kd_pipe_corner_r[6] + kd_pipe_corner_r[5] + kd_pipe_corner_r[4] + kd_pipe_corner_r[3] + kd_pipe_corner_r[2] + kd_pipe_corner_r[1] + kd_pipe_corner_r[0];
  wire [6:0] kd_pipe_corner_sum_g = kd_pipe_corner_g[120] + kd_pipe_corner_g[119] + kd_pipe_corner_g[118] + kd_pipe_corner_g[117] + kd_pipe_corner_g[116] + kd_pipe_corner_g[115] + kd_pipe_corner_g[114] + kd_pipe_corner_g[113] + kd_pipe_corner_g[112] + kd_pipe_corner_g[111] + kd_pipe_corner_g[110] + kd_pipe_corner_g[109] + kd_pipe_corner_g[108] + kd_pipe_corner_g[107] + kd_pipe_corner_g[106] + kd_pipe_corner_g[105] + kd_pipe_corner_g[104] + kd_pipe_corner_g[103] + kd_pipe_corner_g[102] + kd_pipe_corner_g[101] + kd_pipe_corner_g[100] + kd_pipe_corner_g[99] + kd_pipe_corner_g[98] + kd_pipe_corner_g[97] + kd_pipe_corner_g[96] + kd_pipe_corner_g[95] + kd_pipe_corner_g[94] + kd_pipe_corner_g[93] + kd_pipe_corner_g[92] + kd_pipe_corner_g[91] + kd_pipe_corner_g[90] + kd_pipe_corner_g[89] + kd_pipe_corner_g[88] + kd_pipe_corner_g[87] + kd_pipe_corner_g[86] + kd_pipe_corner_g[85] + kd_pipe_corner_g[84] + kd_pipe_corner_g[83] + kd_pipe_corner_g[82] + kd_pipe_corner_g[81] + kd_pipe_corner_g[80] + kd_pipe_corner_g[79] + kd_pipe_corner_g[78] + kd_pipe_corner_g[77] + kd_pipe_corner_g[76] + kd_pipe_corner_g[75] + kd_pipe_corner_g[74] + kd_pipe_corner_g[73] + kd_pipe_corner_g[72] + kd_pipe_corner_g[71] + kd_pipe_corner_g[70] + kd_pipe_corner_g[69] + kd_pipe_corner_g[68] + kd_pipe_corner_g[67] + kd_pipe_corner_g[66] + kd_pipe_corner_g[65] + kd_pipe_corner_g[64] + kd_pipe_corner_g[63] + kd_pipe_corner_g[62] + kd_pipe_corner_g[61] + kd_pipe_corner_g[60] + kd_pipe_corner_g[59] + kd_pipe_corner_g[58] + kd_pipe_corner_g[57] + kd_pipe_corner_g[56] + kd_pipe_corner_g[55] + kd_pipe_corner_g[54] + kd_pipe_corner_g[53] + kd_pipe_corner_g[52] + kd_pipe_corner_g[51] + kd_pipe_corner_g[50] + kd_pipe_corner_g[49] + kd_pipe_corner_g[48] + kd_pipe_corner_g[47] + kd_pipe_corner_g[46] + kd_pipe_corner_g[45] + kd_pipe_corner_g[44] + kd_pipe_corner_g[43] + kd_pipe_corner_g[42] + kd_pipe_corner_g[41] + kd_pipe_corner_g[40] + kd_pipe_corner_g[39] + kd_pipe_corner_g[38] + kd_pipe_corner_g[37] + kd_pipe_corner_g[36] + kd_pipe_corner_g[35] + kd_pipe_corner_g[34] + kd_pipe_corner_g[33] + kd_pipe_corner_g[32] + kd_pipe_corner_g[31] + kd_pipe_corner_g[30] + kd_pipe_corner_g[29] + kd_pipe_corner_g[28] + kd_pipe_corner_g[27] + kd_pipe_corner_g[26] + kd_pipe_corner_g[25] + kd_pipe_corner_g[24] + kd_pipe_corner_g[23] + kd_pipe_corner_g[22] + kd_pipe_corner_g[21] + kd_pipe_corner_g[20] + kd_pipe_corner_g[19] + kd_pipe_corner_g[18] + kd_pipe_corner_g[17] + kd_pipe_corner_g[16] + kd_pipe_corner_g[15] + kd_pipe_corner_g[14] + kd_pipe_corner_g[13] + kd_pipe_corner_g[12] + kd_pipe_corner_g[11] + kd_pipe_corner_g[10] + kd_pipe_corner_g[9] + kd_pipe_corner_g[8] + kd_pipe_corner_g[7] + kd_pipe_corner_g[6] + kd_pipe_corner_g[5] + kd_pipe_corner_g[4] + kd_pipe_corner_g[3] + kd_pipe_corner_g[2] + kd_pipe_corner_g[1] + kd_pipe_corner_g[0];
  wire [6:0] kd_pipe_corner_sum_b = kd_pipe_corner_b[120] + kd_pipe_corner_b[119] + kd_pipe_corner_b[118] + kd_pipe_corner_b[117] + kd_pipe_corner_b[116] + kd_pipe_corner_b[115] + kd_pipe_corner_b[114] + kd_pipe_corner_b[113] + kd_pipe_corner_b[112] + kd_pipe_corner_b[111] + kd_pipe_corner_b[110] + kd_pipe_corner_b[109] + kd_pipe_corner_b[108] + kd_pipe_corner_b[107] + kd_pipe_corner_b[106] + kd_pipe_corner_b[105] + kd_pipe_corner_b[104] + kd_pipe_corner_b[103] + kd_pipe_corner_b[102] + kd_pipe_corner_b[101] + kd_pipe_corner_b[100] + kd_pipe_corner_b[99] + kd_pipe_corner_b[98] + kd_pipe_corner_b[97] + kd_pipe_corner_b[96] + kd_pipe_corner_b[95] + kd_pipe_corner_b[94] + kd_pipe_corner_b[93] + kd_pipe_corner_b[92] + kd_pipe_corner_b[91] + kd_pipe_corner_b[90] + kd_pipe_corner_b[89] + kd_pipe_corner_b[88] + kd_pipe_corner_b[87] + kd_pipe_corner_b[86] + kd_pipe_corner_b[85] + kd_pipe_corner_b[84] + kd_pipe_corner_b[83] + kd_pipe_corner_b[82] + kd_pipe_corner_b[81] + kd_pipe_corner_b[80] + kd_pipe_corner_b[79] + kd_pipe_corner_b[78] + kd_pipe_corner_b[77] + kd_pipe_corner_b[76] + kd_pipe_corner_b[75] + kd_pipe_corner_b[74] + kd_pipe_corner_b[73] + kd_pipe_corner_b[72] + kd_pipe_corner_b[71] + kd_pipe_corner_b[70] + kd_pipe_corner_b[69] + kd_pipe_corner_b[68] + kd_pipe_corner_b[67] + kd_pipe_corner_b[66] + kd_pipe_corner_b[65] + kd_pipe_corner_b[64] + kd_pipe_corner_b[63] + kd_pipe_corner_b[62] + kd_pipe_corner_b[61] + kd_pipe_corner_b[60] + kd_pipe_corner_b[59] + kd_pipe_corner_b[58] + kd_pipe_corner_b[57] + kd_pipe_corner_b[56] + kd_pipe_corner_b[55] + kd_pipe_corner_b[54] + kd_pipe_corner_b[53] + kd_pipe_corner_b[52] + kd_pipe_corner_b[51] + kd_pipe_corner_b[50] + kd_pipe_corner_b[49] + kd_pipe_corner_b[48] + kd_pipe_corner_b[47] + kd_pipe_corner_b[46] + kd_pipe_corner_b[45] + kd_pipe_corner_b[44] + kd_pipe_corner_b[43] + kd_pipe_corner_b[42] + kd_pipe_corner_b[41] + kd_pipe_corner_b[40] + kd_pipe_corner_b[39] + kd_pipe_corner_b[38] + kd_pipe_corner_b[37] + kd_pipe_corner_b[36] + kd_pipe_corner_b[35] + kd_pipe_corner_b[34] + kd_pipe_corner_b[33] + kd_pipe_corner_b[32] + kd_pipe_corner_b[31] + kd_pipe_corner_b[30] + kd_pipe_corner_b[29] + kd_pipe_corner_b[28] + kd_pipe_corner_b[27] + kd_pipe_corner_b[26] + kd_pipe_corner_b[25] + kd_pipe_corner_b[24] + kd_pipe_corner_b[23] + kd_pipe_corner_b[22] + kd_pipe_corner_b[21] + kd_pipe_corner_b[20] + kd_pipe_corner_b[19] + kd_pipe_corner_b[18] + kd_pipe_corner_b[17] + kd_pipe_corner_b[16] + kd_pipe_corner_b[15] + kd_pipe_corner_b[14] + kd_pipe_corner_b[13] + kd_pipe_corner_b[12] + kd_pipe_corner_b[11] + kd_pipe_corner_b[10] + kd_pipe_corner_b[9] + kd_pipe_corner_b[8] + kd_pipe_corner_b[7] + kd_pipe_corner_b[6] + kd_pipe_corner_b[5] + kd_pipe_corner_b[4] + kd_pipe_corner_b[3] + kd_pipe_corner_b[2] + kd_pipe_corner_b[1] + kd_pipe_corner_b[0];
  
  wire [9:0] kd_pipe_corner_sum = kd_pipe_corner_sum_r + kd_pipe_corner_sum_g + kd_pipe_corner_sum_b;
  
  wire [6:0] kd_brick_edge_sum_r = kd_brick_edge_r[120] + kd_brick_edge_r[119] + kd_brick_edge_r[118] + kd_brick_edge_r[117] + kd_brick_edge_r[116] + kd_brick_edge_r[115] + kd_brick_edge_r[114] + kd_brick_edge_r[113] + kd_brick_edge_r[112] + kd_brick_edge_r[111] + kd_brick_edge_r[110] + kd_brick_edge_r[109] + kd_brick_edge_r[108] + kd_brick_edge_r[107] + kd_brick_edge_r[106] + kd_brick_edge_r[105] + kd_brick_edge_r[104] + kd_brick_edge_r[103] + kd_brick_edge_r[102] + kd_brick_edge_r[101] + kd_brick_edge_r[100] + kd_brick_edge_r[99] + kd_brick_edge_r[98] + kd_brick_edge_r[97] + kd_brick_edge_r[96] + kd_brick_edge_r[95] + kd_brick_edge_r[94] + kd_brick_edge_r[93] + kd_brick_edge_r[92] + kd_brick_edge_r[91] + kd_brick_edge_r[90] + kd_brick_edge_r[89] + kd_brick_edge_r[88] + kd_brick_edge_r[87] + kd_brick_edge_r[86] + kd_brick_edge_r[85] + kd_brick_edge_r[84] + kd_brick_edge_r[83] + kd_brick_edge_r[82] + kd_brick_edge_r[81] + kd_brick_edge_r[80] + kd_brick_edge_r[79] + kd_brick_edge_r[78] + kd_brick_edge_r[77] + kd_brick_edge_r[76] + kd_brick_edge_r[75] + kd_brick_edge_r[74] + kd_brick_edge_r[73] + kd_brick_edge_r[72] + kd_brick_edge_r[71] + kd_brick_edge_r[70] + kd_brick_edge_r[69] + kd_brick_edge_r[68] + kd_brick_edge_r[67] + kd_brick_edge_r[66] + kd_brick_edge_r[65] + kd_brick_edge_r[64] + kd_brick_edge_r[63] + kd_brick_edge_r[62] + kd_brick_edge_r[61] + kd_brick_edge_r[60] + kd_brick_edge_r[59] + kd_brick_edge_r[58] + kd_brick_edge_r[57] + kd_brick_edge_r[56] + kd_brick_edge_r[55] + kd_brick_edge_r[54] + kd_brick_edge_r[53] + kd_brick_edge_r[52] + kd_brick_edge_r[51] + kd_brick_edge_r[50] + kd_brick_edge_r[49] + kd_brick_edge_r[48] + kd_brick_edge_r[47] + kd_brick_edge_r[46] + kd_brick_edge_r[45] + kd_brick_edge_r[44] + kd_brick_edge_r[43] + kd_brick_edge_r[42] + kd_brick_edge_r[41] + kd_brick_edge_r[40] + kd_brick_edge_r[39] + kd_brick_edge_r[38] + kd_brick_edge_r[37] + kd_brick_edge_r[36] + kd_brick_edge_r[35] + kd_brick_edge_r[34] + kd_brick_edge_r[33] + kd_brick_edge_r[32] + kd_brick_edge_r[31] + kd_brick_edge_r[30] + kd_brick_edge_r[29] + kd_brick_edge_r[28] + kd_brick_edge_r[27] + kd_brick_edge_r[26] + kd_brick_edge_r[25] + kd_brick_edge_r[24] + kd_brick_edge_r[23] + kd_brick_edge_r[22] + kd_brick_edge_r[21] + kd_brick_edge_r[20] + kd_brick_edge_r[19] + kd_brick_edge_r[18] + kd_brick_edge_r[17] + kd_brick_edge_r[16] + kd_brick_edge_r[15] + kd_brick_edge_r[14] + kd_brick_edge_r[13] + kd_brick_edge_r[12] + kd_brick_edge_r[11] + kd_brick_edge_r[10] + kd_brick_edge_r[9] + kd_brick_edge_r[8] + kd_brick_edge_r[7] + kd_brick_edge_r[6] + kd_brick_edge_r[5] + kd_brick_edge_r[4] + kd_brick_edge_r[3] + kd_brick_edge_r[2] + kd_brick_edge_r[1] + kd_brick_edge_r[0];
  wire [6:0] kd_brick_edge_sum_g = kd_brick_edge_g[120] + kd_brick_edge_g[119] + kd_brick_edge_g[118] + kd_brick_edge_g[117] + kd_brick_edge_g[116] + kd_brick_edge_g[115] + kd_brick_edge_g[114] + kd_brick_edge_g[113] + kd_brick_edge_g[112] + kd_brick_edge_g[111] + kd_brick_edge_g[110] + kd_brick_edge_g[109] + kd_brick_edge_g[108] + kd_brick_edge_g[107] + kd_brick_edge_g[106] + kd_brick_edge_g[105] + kd_brick_edge_g[104] + kd_brick_edge_g[103] + kd_brick_edge_g[102] + kd_brick_edge_g[101] + kd_brick_edge_g[100] + kd_brick_edge_g[99] + kd_brick_edge_g[98] + kd_brick_edge_g[97] + kd_brick_edge_g[96] + kd_brick_edge_g[95] + kd_brick_edge_g[94] + kd_brick_edge_g[93] + kd_brick_edge_g[92] + kd_brick_edge_g[91] + kd_brick_edge_g[90] + kd_brick_edge_g[89] + kd_brick_edge_g[88] + kd_brick_edge_g[87] + kd_brick_edge_g[86] + kd_brick_edge_g[85] + kd_brick_edge_g[84] + kd_brick_edge_g[83] + kd_brick_edge_g[82] + kd_brick_edge_g[81] + kd_brick_edge_g[80] + kd_brick_edge_g[79] + kd_brick_edge_g[78] + kd_brick_edge_g[77] + kd_brick_edge_g[76] + kd_brick_edge_g[75] + kd_brick_edge_g[74] + kd_brick_edge_g[73] + kd_brick_edge_g[72] + kd_brick_edge_g[71] + kd_brick_edge_g[70] + kd_brick_edge_g[69] + kd_brick_edge_g[68] + kd_brick_edge_g[67] + kd_brick_edge_g[66] + kd_brick_edge_g[65] + kd_brick_edge_g[64] + kd_brick_edge_g[63] + kd_brick_edge_g[62] + kd_brick_edge_g[61] + kd_brick_edge_g[60] + kd_brick_edge_g[59] + kd_brick_edge_g[58] + kd_brick_edge_g[57] + kd_brick_edge_g[56] + kd_brick_edge_g[55] + kd_brick_edge_g[54] + kd_brick_edge_g[53] + kd_brick_edge_g[52] + kd_brick_edge_g[51] + kd_brick_edge_g[50] + kd_brick_edge_g[49] + kd_brick_edge_g[48] + kd_brick_edge_g[47] + kd_brick_edge_g[46] + kd_brick_edge_g[45] + kd_brick_edge_g[44] + kd_brick_edge_g[43] + kd_brick_edge_g[42] + kd_brick_edge_g[41] + kd_brick_edge_g[40] + kd_brick_edge_g[39] + kd_brick_edge_g[38] + kd_brick_edge_g[37] + kd_brick_edge_g[36] + kd_brick_edge_g[35] + kd_brick_edge_g[34] + kd_brick_edge_g[33] + kd_brick_edge_g[32] + kd_brick_edge_g[31] + kd_brick_edge_g[30] + kd_brick_edge_g[29] + kd_brick_edge_g[28] + kd_brick_edge_g[27] + kd_brick_edge_g[26] + kd_brick_edge_g[25] + kd_brick_edge_g[24] + kd_brick_edge_g[23] + kd_brick_edge_g[22] + kd_brick_edge_g[21] + kd_brick_edge_g[20] + kd_brick_edge_g[19] + kd_brick_edge_g[18] + kd_brick_edge_g[17] + kd_brick_edge_g[16] + kd_brick_edge_g[15] + kd_brick_edge_g[14] + kd_brick_edge_g[13] + kd_brick_edge_g[12] + kd_brick_edge_g[11] + kd_brick_edge_g[10] + kd_brick_edge_g[9] + kd_brick_edge_g[8] + kd_brick_edge_g[7] + kd_brick_edge_g[6] + kd_brick_edge_g[5] + kd_brick_edge_g[4] + kd_brick_edge_g[3] + kd_brick_edge_g[2] + kd_brick_edge_g[1] + kd_brick_edge_g[0];
  wire [6:0] kd_brick_edge_sum_b = kd_brick_edge_b[120] + kd_brick_edge_b[119] + kd_brick_edge_b[118] + kd_brick_edge_b[117] + kd_brick_edge_b[116] + kd_brick_edge_b[115] + kd_brick_edge_b[114] + kd_brick_edge_b[113] + kd_brick_edge_b[112] + kd_brick_edge_b[111] + kd_brick_edge_b[110] + kd_brick_edge_b[109] + kd_brick_edge_b[108] + kd_brick_edge_b[107] + kd_brick_edge_b[106] + kd_brick_edge_b[105] + kd_brick_edge_b[104] + kd_brick_edge_b[103] + kd_brick_edge_b[102] + kd_brick_edge_b[101] + kd_brick_edge_b[100] + kd_brick_edge_b[99] + kd_brick_edge_b[98] + kd_brick_edge_b[97] + kd_brick_edge_b[96] + kd_brick_edge_b[95] + kd_brick_edge_b[94] + kd_brick_edge_b[93] + kd_brick_edge_b[92] + kd_brick_edge_b[91] + kd_brick_edge_b[90] + kd_brick_edge_b[89] + kd_brick_edge_b[88] + kd_brick_edge_b[87] + kd_brick_edge_b[86] + kd_brick_edge_b[85] + kd_brick_edge_b[84] + kd_brick_edge_b[83] + kd_brick_edge_b[82] + kd_brick_edge_b[81] + kd_brick_edge_b[80] + kd_brick_edge_b[79] + kd_brick_edge_b[78] + kd_brick_edge_b[77] + kd_brick_edge_b[76] + kd_brick_edge_b[75] + kd_brick_edge_b[74] + kd_brick_edge_b[73] + kd_brick_edge_b[72] + kd_brick_edge_b[71] + kd_brick_edge_b[70] + kd_brick_edge_b[69] + kd_brick_edge_b[68] + kd_brick_edge_b[67] + kd_brick_edge_b[66] + kd_brick_edge_b[65] + kd_brick_edge_b[64] + kd_brick_edge_b[63] + kd_brick_edge_b[62] + kd_brick_edge_b[61] + kd_brick_edge_b[60] + kd_brick_edge_b[59] + kd_brick_edge_b[58] + kd_brick_edge_b[57] + kd_brick_edge_b[56] + kd_brick_edge_b[55] + kd_brick_edge_b[54] + kd_brick_edge_b[53] + kd_brick_edge_b[52] + kd_brick_edge_b[51] + kd_brick_edge_b[50] + kd_brick_edge_b[49] + kd_brick_edge_b[48] + kd_brick_edge_b[47] + kd_brick_edge_b[46] + kd_brick_edge_b[45] + kd_brick_edge_b[44] + kd_brick_edge_b[43] + kd_brick_edge_b[42] + kd_brick_edge_b[41] + kd_brick_edge_b[40] + kd_brick_edge_b[39] + kd_brick_edge_b[38] + kd_brick_edge_b[37] + kd_brick_edge_b[36] + kd_brick_edge_b[35] + kd_brick_edge_b[34] + kd_brick_edge_b[33] + kd_brick_edge_b[32] + kd_brick_edge_b[31] + kd_brick_edge_b[30] + kd_brick_edge_b[29] + kd_brick_edge_b[28] + kd_brick_edge_b[27] + kd_brick_edge_b[26] + kd_brick_edge_b[25] + kd_brick_edge_b[24] + kd_brick_edge_b[23] + kd_brick_edge_b[22] + kd_brick_edge_b[21] + kd_brick_edge_b[20] + kd_brick_edge_b[19] + kd_brick_edge_b[18] + kd_brick_edge_b[17] + kd_brick_edge_b[16] + kd_brick_edge_b[15] + kd_brick_edge_b[14] + kd_brick_edge_b[13] + kd_brick_edge_b[12] + kd_brick_edge_b[11] + kd_brick_edge_b[10] + kd_brick_edge_b[9] + kd_brick_edge_b[8] + kd_brick_edge_b[7] + kd_brick_edge_b[6] + kd_brick_edge_b[5] + kd_brick_edge_b[4] + kd_brick_edge_b[3] + kd_brick_edge_b[2] + kd_brick_edge_b[1] + kd_brick_edge_b[0];

  wire [9:0] kd_brick_edge_sum = kd_brick_edge_sum_r + kd_brick_edge_sum_g + kd_brick_edge_sum_b;
  
  wire [6:0] kd_mario_sum_r = kd_mario_r[120] + kd_mario_r[119] + kd_mario_r[118] + kd_mario_r[117] + kd_mario_r[116] + kd_mario_r[115] + kd_mario_r[114] + kd_mario_r[113] + kd_mario_r[112] + kd_mario_r[111] + kd_mario_r[110] + kd_mario_r[109] + kd_mario_r[108] + kd_mario_r[107] + kd_mario_r[106] + kd_mario_r[105] + kd_mario_r[104] + kd_mario_r[103] + kd_mario_r[102] + kd_mario_r[101] + kd_mario_r[100] + kd_mario_r[99] + kd_mario_r[98] + kd_mario_r[97] + kd_mario_r[96] + kd_mario_r[95] + kd_mario_r[94] + kd_mario_r[93] + kd_mario_r[92] + kd_mario_r[91] + kd_mario_r[90] + kd_mario_r[89] + kd_mario_r[88] + kd_mario_r[87] + kd_mario_r[86] + kd_mario_r[85] + kd_mario_r[84] + kd_mario_r[83] + kd_mario_r[82] + kd_mario_r[81] + kd_mario_r[80] + kd_mario_r[79] + kd_mario_r[78] + kd_mario_r[77] + kd_mario_r[76] + kd_mario_r[75] + kd_mario_r[74] + kd_mario_r[73] + kd_mario_r[72] + kd_mario_r[71] + kd_mario_r[70] + kd_mario_r[69] + kd_mario_r[68] + kd_mario_r[67] + kd_mario_r[66] + kd_mario_r[65] + kd_mario_r[64] + kd_mario_r[63] + kd_mario_r[62] + kd_mario_r[61] + kd_mario_r[60] + kd_mario_r[59] + kd_mario_r[58] + kd_mario_r[57] + kd_mario_r[56] + kd_mario_r[55] + kd_mario_r[54] + kd_mario_r[53] + kd_mario_r[52] + kd_mario_r[51] + kd_mario_r[50] + kd_mario_r[49] + kd_mario_r[48] + kd_mario_r[47] + kd_mario_r[46] + kd_mario_r[45] + kd_mario_r[44] + kd_mario_r[43] + kd_mario_r[42] + kd_mario_r[41] + kd_mario_r[40] + kd_mario_r[39] + kd_mario_r[38] + kd_mario_r[37] + kd_mario_r[36] + kd_mario_r[35] + kd_mario_r[34] + kd_mario_r[33] + kd_mario_r[32] + kd_mario_r[31] + kd_mario_r[30] + kd_mario_r[29] + kd_mario_r[28] + kd_mario_r[27] + kd_mario_r[26] + kd_mario_r[25] + kd_mario_r[24] + kd_mario_r[23] + kd_mario_r[22] + kd_mario_r[21] + kd_mario_r[20] + kd_mario_r[19] + kd_mario_r[18] + kd_mario_r[17] + kd_mario_r[16] + kd_mario_r[15] + kd_mario_r[14] + kd_mario_r[13] + kd_mario_r[12] + kd_mario_r[11] + kd_mario_r[10] + kd_mario_r[9] + kd_mario_r[8] + kd_mario_r[7] + kd_mario_r[6] + kd_mario_r[5] + kd_mario_r[4] + kd_mario_r[3] + kd_mario_r[2] + kd_mario_r[1] + kd_mario_r[0];
  wire [6:0] kd_mario_sum_g = kd_mario_g[120] + kd_mario_g[119] + kd_mario_g[118] + kd_mario_g[117] + kd_mario_g[116] + kd_mario_g[115] + kd_mario_g[114] + kd_mario_g[113] + kd_mario_g[112] + kd_mario_g[111] + kd_mario_g[110] + kd_mario_g[109] + kd_mario_g[108] + kd_mario_g[107] + kd_mario_g[106] + kd_mario_g[105] + kd_mario_g[104] + kd_mario_g[103] + kd_mario_g[102] + kd_mario_g[101] + kd_mario_g[100] + kd_mario_g[99] + kd_mario_g[98] + kd_mario_g[97] + kd_mario_g[96] + kd_mario_g[95] + kd_mario_g[94] + kd_mario_g[93] + kd_mario_g[92] + kd_mario_g[91] + kd_mario_g[90] + kd_mario_g[89] + kd_mario_g[88] + kd_mario_g[87] + kd_mario_g[86] + kd_mario_g[85] + kd_mario_g[84] + kd_mario_g[83] + kd_mario_g[82] + kd_mario_g[81] + kd_mario_g[80] + kd_mario_g[79] + kd_mario_g[78] + kd_mario_g[77] + kd_mario_g[76] + kd_mario_g[75] + kd_mario_g[74] + kd_mario_g[73] + kd_mario_g[72] + kd_mario_g[71] + kd_mario_g[70] + kd_mario_g[69] + kd_mario_g[68] + kd_mario_g[67] + kd_mario_g[66] + kd_mario_g[65] + kd_mario_g[64] + kd_mario_g[63] + kd_mario_g[62] + kd_mario_g[61] + kd_mario_g[60] + kd_mario_g[59] + kd_mario_g[58] + kd_mario_g[57] + kd_mario_g[56] + kd_mario_g[55] + kd_mario_g[54] + kd_mario_g[53] + kd_mario_g[52] + kd_mario_g[51] + kd_mario_g[50] + kd_mario_g[49] + kd_mario_g[48] + kd_mario_g[47] + kd_mario_g[46] + kd_mario_g[45] + kd_mario_g[44] + kd_mario_g[43] + kd_mario_g[42] + kd_mario_g[41] + kd_mario_g[40] + kd_mario_g[39] + kd_mario_g[38] + kd_mario_g[37] + kd_mario_g[36] + kd_mario_g[35] + kd_mario_g[34] + kd_mario_g[33] + kd_mario_g[32] + kd_mario_g[31] + kd_mario_g[30] + kd_mario_g[29] + kd_mario_g[28] + kd_mario_g[27] + kd_mario_g[26] + kd_mario_g[25] + kd_mario_g[24] + kd_mario_g[23] + kd_mario_g[22] + kd_mario_g[21] + kd_mario_g[20] + kd_mario_g[19] + kd_mario_g[18] + kd_mario_g[17] + kd_mario_g[16] + kd_mario_g[15] + kd_mario_g[14] + kd_mario_g[13] + kd_mario_g[12] + kd_mario_g[11] + kd_mario_g[10] + kd_mario_g[9] + kd_mario_g[8] + kd_mario_g[7] + kd_mario_g[6] + kd_mario_g[5] + kd_mario_g[4] + kd_mario_g[3] + kd_mario_g[2] + kd_mario_g[1] + kd_mario_g[0];
  wire [6:0] kd_mario_sum_b = kd_mario_b[120] + kd_mario_b[119] + kd_mario_b[118] + kd_mario_b[117] + kd_mario_b[116] + kd_mario_b[115] + kd_mario_b[114] + kd_mario_b[113] + kd_mario_b[112] + kd_mario_b[111] + kd_mario_b[110] + kd_mario_b[109] + kd_mario_b[108] + kd_mario_b[107] + kd_mario_b[106] + kd_mario_b[105] + kd_mario_b[104] + kd_mario_b[103] + kd_mario_b[102] + kd_mario_b[101] + kd_mario_b[100] + kd_mario_b[99] + kd_mario_b[98] + kd_mario_b[97] + kd_mario_b[96] + kd_mario_b[95] + kd_mario_b[94] + kd_mario_b[93] + kd_mario_b[92] + kd_mario_b[91] + kd_mario_b[90] + kd_mario_b[89] + kd_mario_b[88] + kd_mario_b[87] + kd_mario_b[86] + kd_mario_b[85] + kd_mario_b[84] + kd_mario_b[83] + kd_mario_b[82] + kd_mario_b[81] + kd_mario_b[80] + kd_mario_b[79] + kd_mario_b[78] + kd_mario_b[77] + kd_mario_b[76] + kd_mario_b[75] + kd_mario_b[74] + kd_mario_b[73] + kd_mario_b[72] + kd_mario_b[71] + kd_mario_b[70] + kd_mario_b[69] + kd_mario_b[68] + kd_mario_b[67] + kd_mario_b[66] + kd_mario_b[65] + kd_mario_b[64] + kd_mario_b[63] + kd_mario_b[62] + kd_mario_b[61] + kd_mario_b[60] + kd_mario_b[59] + kd_mario_b[58] + kd_mario_b[57] + kd_mario_b[56] + kd_mario_b[55] + kd_mario_b[54] + kd_mario_b[53] + kd_mario_b[52] + kd_mario_b[51] + kd_mario_b[50] + kd_mario_b[49] + kd_mario_b[48] + kd_mario_b[47] + kd_mario_b[46] + kd_mario_b[45] + kd_mario_b[44] + kd_mario_b[43] + kd_mario_b[42] + kd_mario_b[41] + kd_mario_b[40] + kd_mario_b[39] + kd_mario_b[38] + kd_mario_b[37] + kd_mario_b[36] + kd_mario_b[35] + kd_mario_b[34] + kd_mario_b[33] + kd_mario_b[32] + kd_mario_b[31] + kd_mario_b[30] + kd_mario_b[29] + kd_mario_b[28] + kd_mario_b[27] + kd_mario_b[26] + kd_mario_b[25] + kd_mario_b[24] + kd_mario_b[23] + kd_mario_b[22] + kd_mario_b[21] + kd_mario_b[20] + kd_mario_b[19] + kd_mario_b[18] + kd_mario_b[17] + kd_mario_b[16] + kd_mario_b[15] + kd_mario_b[14] + kd_mario_b[13] + kd_mario_b[12] + kd_mario_b[11] + kd_mario_b[10] + kd_mario_b[9] + kd_mario_b[8] + kd_mario_b[7] + kd_mario_b[6] + kd_mario_b[5] + kd_mario_b[4] + kd_mario_b[3] + kd_mario_b[2] + kd_mario_b[1] + kd_mario_b[0];
  
  wire [9:0] kd_mario_sum = kd_mario_sum_r + kd_mario_sum_g + kd_mario_sum_b;
  
  wire [6:0] kd_bar_sum_r = kd_bar_r[120] + kd_bar_r[119] + kd_bar_r[118] + kd_bar_r[117] + kd_bar_r[116] + kd_bar_r[115] + kd_bar_r[114] + kd_bar_r[113] + kd_bar_r[112] + kd_bar_r[111] + kd_bar_r[110] + kd_bar_r[109] + kd_bar_r[108] + kd_bar_r[107] + kd_bar_r[106] + kd_bar_r[105] + kd_bar_r[104] + kd_bar_r[103] + kd_bar_r[102] + kd_bar_r[101] + kd_bar_r[100] + kd_bar_r[99] + kd_bar_r[98] + kd_bar_r[97] + kd_bar_r[96] + kd_bar_r[95] + kd_bar_r[94] + kd_bar_r[93] + kd_bar_r[92] + kd_bar_r[91] + kd_bar_r[90] + kd_bar_r[89] + kd_bar_r[88] + kd_bar_r[87] + kd_bar_r[86] + kd_bar_r[85] + kd_bar_r[84] + kd_bar_r[83] + kd_bar_r[82] + kd_bar_r[81] + kd_bar_r[80] + kd_bar_r[79] + kd_bar_r[78] + kd_bar_r[77] + kd_bar_r[76] + kd_bar_r[75] + kd_bar_r[74] + kd_bar_r[73] + kd_bar_r[72] + kd_bar_r[71] + kd_bar_r[70] + kd_bar_r[69] + kd_bar_r[68] + kd_bar_r[67] + kd_bar_r[66] + kd_bar_r[65] + kd_bar_r[64] + kd_bar_r[63] + kd_bar_r[62] + kd_bar_r[61] + kd_bar_r[60] + kd_bar_r[59] + kd_bar_r[58] + kd_bar_r[57] + kd_bar_r[56] + kd_bar_r[55] + kd_bar_r[54] + kd_bar_r[53] + kd_bar_r[52] + kd_bar_r[51] + kd_bar_r[50] + kd_bar_r[49] + kd_bar_r[48] + kd_bar_r[47] + kd_bar_r[46] + kd_bar_r[45] + kd_bar_r[44] + kd_bar_r[43] + kd_bar_r[42] + kd_bar_r[41] + kd_bar_r[40] + kd_bar_r[39] + kd_bar_r[38] + kd_bar_r[37] + kd_bar_r[36] + kd_bar_r[35] + kd_bar_r[34] + kd_bar_r[33] + kd_bar_r[32] + kd_bar_r[31] + kd_bar_r[30] + kd_bar_r[29] + kd_bar_r[28] + kd_bar_r[27] + kd_bar_r[26] + kd_bar_r[25] + kd_bar_r[24] + kd_bar_r[23] + kd_bar_r[22] + kd_bar_r[21] + kd_bar_r[20] + kd_bar_r[19] + kd_bar_r[18] + kd_bar_r[17] + kd_bar_r[16] + kd_bar_r[15] + kd_bar_r[14] + kd_bar_r[13] + kd_bar_r[12] + kd_bar_r[11] + kd_bar_r[10] + kd_bar_r[9] + kd_bar_r[8] + kd_bar_r[7] + kd_bar_r[6] + kd_bar_r[5] + kd_bar_r[4] + kd_bar_r[3] + kd_bar_r[2] + kd_bar_r[1] + kd_bar_r[0];
  wire [6:0] kd_bar_sum_g = kd_bar_g[120] + kd_bar_g[119] + kd_bar_g[118] + kd_bar_g[117] + kd_bar_g[116] + kd_bar_g[115] + kd_bar_g[114] + kd_bar_g[113] + kd_bar_g[112] + kd_bar_g[111] + kd_bar_g[110] + kd_bar_g[109] + kd_bar_g[108] + kd_bar_g[107] + kd_bar_g[106] + kd_bar_g[105] + kd_bar_g[104] + kd_bar_g[103] + kd_bar_g[102] + kd_bar_g[101] + kd_bar_g[100] + kd_bar_g[99] + kd_bar_g[98] + kd_bar_g[97] + kd_bar_g[96] + kd_bar_g[95] + kd_bar_g[94] + kd_bar_g[93] + kd_bar_g[92] + kd_bar_g[91] + kd_bar_g[90] + kd_bar_g[89] + kd_bar_g[88] + kd_bar_g[87] + kd_bar_g[86] + kd_bar_g[85] + kd_bar_g[84] + kd_bar_g[83] + kd_bar_g[82] + kd_bar_g[81] + kd_bar_g[80] + kd_bar_g[79] + kd_bar_g[78] + kd_bar_g[77] + kd_bar_g[76] + kd_bar_g[75] + kd_bar_g[74] + kd_bar_g[73] + kd_bar_g[72] + kd_bar_g[71] + kd_bar_g[70] + kd_bar_g[69] + kd_bar_g[68] + kd_bar_g[67] + kd_bar_g[66] + kd_bar_g[65] + kd_bar_g[64] + kd_bar_g[63] + kd_bar_g[62] + kd_bar_g[61] + kd_bar_g[60] + kd_bar_g[59] + kd_bar_g[58] + kd_bar_g[57] + kd_bar_g[56] + kd_bar_g[55] + kd_bar_g[54] + kd_bar_g[53] + kd_bar_g[52] + kd_bar_g[51] + kd_bar_g[50] + kd_bar_g[49] + kd_bar_g[48] + kd_bar_g[47] + kd_bar_g[46] + kd_bar_g[45] + kd_bar_g[44] + kd_bar_g[43] + kd_bar_g[42] + kd_bar_g[41] + kd_bar_g[40] + kd_bar_g[39] + kd_bar_g[38] + kd_bar_g[37] + kd_bar_g[36] + kd_bar_g[35] + kd_bar_g[34] + kd_bar_g[33] + kd_bar_g[32] + kd_bar_g[31] + kd_bar_g[30] + kd_bar_g[29] + kd_bar_g[28] + kd_bar_g[27] + kd_bar_g[26] + kd_bar_g[25] + kd_bar_g[24] + kd_bar_g[23] + kd_bar_g[22] + kd_bar_g[21] + kd_bar_g[20] + kd_bar_g[19] + kd_bar_g[18] + kd_bar_g[17] + kd_bar_g[16] + kd_bar_g[15] + kd_bar_g[14] + kd_bar_g[13] + kd_bar_g[12] + kd_bar_g[11] + kd_bar_g[10] + kd_bar_g[9] + kd_bar_g[8] + kd_bar_g[7] + kd_bar_g[6] + kd_bar_g[5] + kd_bar_g[4] + kd_bar_g[3] + kd_bar_g[2] + kd_bar_g[1] + kd_bar_g[0];
  wire [6:0] kd_bar_sum_b = kd_bar_b[120] + kd_bar_b[119] + kd_bar_b[118] + kd_bar_b[117] + kd_bar_b[116] + kd_bar_b[115] + kd_bar_b[114] + kd_bar_b[113] + kd_bar_b[112] + kd_bar_b[111] + kd_bar_b[110] + kd_bar_b[109] + kd_bar_b[108] + kd_bar_b[107] + kd_bar_b[106] + kd_bar_b[105] + kd_bar_b[104] + kd_bar_b[103] + kd_bar_b[102] + kd_bar_b[101] + kd_bar_b[100] + kd_bar_b[99] + kd_bar_b[98] + kd_bar_b[97] + kd_bar_b[96] + kd_bar_b[95] + kd_bar_b[94] + kd_bar_b[93] + kd_bar_b[92] + kd_bar_b[91] + kd_bar_b[90] + kd_bar_b[89] + kd_bar_b[88] + kd_bar_b[87] + kd_bar_b[86] + kd_bar_b[85] + kd_bar_b[84] + kd_bar_b[83] + kd_bar_b[82] + kd_bar_b[81] + kd_bar_b[80] + kd_bar_b[79] + kd_bar_b[78] + kd_bar_b[77] + kd_bar_b[76] + kd_bar_b[75] + kd_bar_b[74] + kd_bar_b[73] + kd_bar_b[72] + kd_bar_b[71] + kd_bar_b[70] + kd_bar_b[69] + kd_bar_b[68] + kd_bar_b[67] + kd_bar_b[66] + kd_bar_b[65] + kd_bar_b[64] + kd_bar_b[63] + kd_bar_b[62] + kd_bar_b[61] + kd_bar_b[60] + kd_bar_b[59] + kd_bar_b[58] + kd_bar_b[57] + kd_bar_b[56] + kd_bar_b[55] + kd_bar_b[54] + kd_bar_b[53] + kd_bar_b[52] + kd_bar_b[51] + kd_bar_b[50] + kd_bar_b[49] + kd_bar_b[48] + kd_bar_b[47] + kd_bar_b[46] + kd_bar_b[45] + kd_bar_b[44] + kd_bar_b[43] + kd_bar_b[42] + kd_bar_b[41] + kd_bar_b[40] + kd_bar_b[39] + kd_bar_b[38] + kd_bar_b[37] + kd_bar_b[36] + kd_bar_b[35] + kd_bar_b[34] + kd_bar_b[33] + kd_bar_b[32] + kd_bar_b[31] + kd_bar_b[30] + kd_bar_b[29] + kd_bar_b[28] + kd_bar_b[27] + kd_bar_b[26] + kd_bar_b[25] + kd_bar_b[24] + kd_bar_b[23] + kd_bar_b[22] + kd_bar_b[21] + kd_bar_b[20] + kd_bar_b[19] + kd_bar_b[18] + kd_bar_b[17] + kd_bar_b[16] + kd_bar_b[15] + kd_bar_b[14] + kd_bar_b[13] + kd_bar_b[12] + kd_bar_b[11] + kd_bar_b[10] + kd_bar_b[9] + kd_bar_b[8] + kd_bar_b[7] + kd_bar_b[6] + kd_bar_b[5] + kd_bar_b[4] + kd_bar_b[3] + kd_bar_b[2] + kd_bar_b[1] + kd_bar_b[0];

  wire [9:0] kd_bar_sum = kd_bar_sum_r + kd_bar_sum_g + kd_bar_sum_b;
  
  wire [6:0] kd_goomba_color_sum = kd_goomba_color_r[120] + kd_goomba_color_r[119] + kd_goomba_color_r[118] + kd_goomba_color_r[117] + kd_goomba_color_r[116] + kd_goomba_color_r[115] + kd_goomba_color_r[114] + kd_goomba_color_r[113] + kd_goomba_color_r[112] + kd_goomba_color_r[111] + kd_goomba_color_r[110] + kd_goomba_color_r[109] + kd_goomba_color_r[108] + kd_goomba_color_r[107] + kd_goomba_color_r[106] + kd_goomba_color_r[105] + kd_goomba_color_r[104] + kd_goomba_color_r[103] + kd_goomba_color_r[102] + kd_goomba_color_r[101] + kd_goomba_color_r[100] + kd_goomba_color_r[99] + kd_goomba_color_r[98] + kd_goomba_color_r[97] + kd_goomba_color_r[96] + kd_goomba_color_r[95] + kd_goomba_color_r[94] + kd_goomba_color_r[93] + kd_goomba_color_r[92] + kd_goomba_color_r[91] + kd_goomba_color_r[90] + kd_goomba_color_r[89] + kd_goomba_color_r[88] + kd_goomba_color_r[87] + kd_goomba_color_r[86] + kd_goomba_color_r[85] + kd_goomba_color_r[84] + kd_goomba_color_r[83] + kd_goomba_color_r[82] + kd_goomba_color_r[81] + kd_goomba_color_r[80] + kd_goomba_color_r[79] + kd_goomba_color_r[78] + kd_goomba_color_r[77] + kd_goomba_color_r[76] + kd_goomba_color_r[75] + kd_goomba_color_r[74] + kd_goomba_color_r[73] + kd_goomba_color_r[72] + kd_goomba_color_r[71] + kd_goomba_color_r[70] + kd_goomba_color_r[69] + kd_goomba_color_r[68] + kd_goomba_color_r[67] + kd_goomba_color_r[66] + kd_goomba_color_r[65] + kd_goomba_color_r[64] + kd_goomba_color_r[63] + kd_goomba_color_r[62] + kd_goomba_color_r[61] + kd_goomba_color_r[60] + kd_goomba_color_r[59] + kd_goomba_color_r[58] + kd_goomba_color_r[57] + kd_goomba_color_r[56] + kd_goomba_color_r[55] + kd_goomba_color_r[54] + kd_goomba_color_r[53] + kd_goomba_color_r[52] + kd_goomba_color_r[51] + kd_goomba_color_r[50] + kd_goomba_color_r[49] + kd_goomba_color_r[48] + kd_goomba_color_r[47] + kd_goomba_color_r[46] + kd_goomba_color_r[45] + kd_goomba_color_r[44] + kd_goomba_color_r[43] + kd_goomba_color_r[42] + kd_goomba_color_r[41] + kd_goomba_color_r[40] + kd_goomba_color_r[39] + kd_goomba_color_r[38] + kd_goomba_color_r[37] + kd_goomba_color_r[36] + kd_goomba_color_r[35] + kd_goomba_color_r[34] + kd_goomba_color_r[33] + kd_goomba_color_r[32] + kd_goomba_color_r[31] + kd_goomba_color_r[30] + kd_goomba_color_r[29] + kd_goomba_color_r[28] + kd_goomba_color_r[27] + kd_goomba_color_r[26] + kd_goomba_color_r[25] + kd_goomba_color_r[24] + kd_goomba_color_r[23] + kd_goomba_color_r[22] + kd_goomba_color_r[21] + kd_goomba_color_r[20] + kd_goomba_color_r[19] + kd_goomba_color_r[18] + kd_goomba_color_r[17] + kd_goomba_color_r[16] + kd_goomba_color_r[15] + kd_goomba_color_r[14] + kd_goomba_color_r[13] + kd_goomba_color_r[12] + kd_goomba_color_r[11] + kd_goomba_color_r[10] + kd_goomba_color_r[9] + kd_goomba_color_r[8] + kd_goomba_color_r[7] + kd_goomba_color_r[6] + kd_goomba_color_r[5] + kd_goomba_color_r[4] + kd_goomba_color_r[3] + kd_goomba_color_r[2] + kd_goomba_color_r[1] + kd_goomba_color_r[0];
  
  //wire det_goomba = (kd_goomba_sum < (kd_thresh << 4));
  
  //wire det_goomba = (mVGA_R_int > 10'b1110000000) && (mVGA_G_int > 10'b0111111100) && (mVGA_G_int < 10'b1100000000) && (mVGA_B_int < 10'b0100000000) && (mVGA_B_int > 10'b0010000000);
  wire goomba_color = (mVGA_G_int > 10'b0101111100) && (mVGA_G_int < 10'b1110000000) && (mVGA_B_int < 10'b1010000000) && (mVGA_B_int > 10'b0001100000) && (mVGA_R_int > 10'b1100000000);
  wire det_goomba = (kd_goomba_color_sum > 6'b011100);
  
  wire det_pipe_corner = (kd_pipe_corner_sum < 6'b110000);
  wire det_brick_edge  = (kd_brick_edge_sum  < 8'b01011100);
  //wire det_mario       = (kd_mario_sum < (kd_thresh << 4));
  wire det_mario = 0;
  wire det_bar         = (kd_bar_sum == 0);
  
  
	
	wire [9:0] mVGA_gs_r;
   wire [9:0] mVGA_gs_g;
   wire [9:0] mVGA_gs_b;
	
// --------------------------------------------------------------------
// Display
// --------------------------------------------------------------------
	
	wire DISP_R_THRESH = (~DPDT_SW[4] && ~DPDT_SW[3]);
	wire DISP_G_THRESH = (~DPDT_SW[4] && DPDT_SW[3]);
	wire DISP_B_THRESH = (DPDT_SW[4] && ~DPDT_SW[3]);
	wire DISP_A_THRESH = (DPDT_SW[4] && DPDT_SW[3]);
	
	wire DISP_CHANNELS = DPDT_SW[8];
	
	wire [9:0] BASE_R_T = (DPDT_SW[2]) ? mVGA_R_int : ((DISP_G_THRESH ? (DISP_CHANNELS ? mVGA_g_th_full : 10'b0000000000) : (DISP_B_THRESH ? (DISP_CHANNELS ? mVGA_b_th_full : 10'b0000000000) : (DISP_CHANNELS ? mVGA_r_th_full : mVGA_R_int))));
	wire [9:0] BASE_G_T = (DPDT_SW[2]) ? mVGA_G_int : ((DISP_R_THRESH ? (DISP_CHANNELS ? mVGA_r_th_full : 10'b0000000000) : (DISP_B_THRESH ? (DISP_CHANNELS ? mVGA_b_th_full : 10'b0000000000) : (DISP_CHANNELS ? mVGA_g_th_full : mVGA_G_int))));
	wire [9:0] BASE_B_T = (DPDT_SW[2]) ? mVGA_B_int : ((DISP_G_THRESH ? (DISP_CHANNELS ? mVGA_g_th_full : 10'b0000000000) : (DISP_R_THRESH ? (DISP_CHANNELS ? mVGA_r_th_full : 10'b0000000000) : (DISP_CHANNELS ? mVGA_b_th_full : mVGA_B_int))));
	
	wire [9:0] BASE_R = (DPDT_SW[9]) ? (goomba_color ? 10'b1111111111 : 10'b0000000000) : BASE_R_T;
   wire [9:0] BASE_G = (DPDT_SW[9]) ? (goomba_color ? 10'b1111111111 : 10'b0000000000) : BASE_G_T;
   wire [9:0] BASE_B = (DPDT_SW[9]) ? (goomba_color ? 10'b1111111111 : 10'b0000000000) : BASE_B_T;

	//Toggle w/ Switch 7
	assign mVGA_gs_r = DPDT_SW[15] ? (det_goomba ? 10'b1111111111 : (det_mario ? 10'b1111111111 :(det_pipe_corner ? 10'b0000000000 : (det_brick_edge ? 10'b1111111111 : (DPDT_SW[7] ? BASE_R : 10'b0000000000))))) : BASE_R;
	assign mVGA_gs_g = DPDT_SW[15] ? (det_goomba ? 10'b0000000000 : (det_mario ? 10'b0000000000 :(det_pipe_corner ? 10'b1111111111 : (det_brick_edge ? 10'b1111111111 : (DPDT_SW[7] ? BASE_G : 10'b0000000000))))) : BASE_G;
	assign mVGA_gs_b = DPDT_SW[15] ? (det_goomba ? 10'b0000000000 : (det_mario ? 10'b1111111111 :(det_pipe_corner ? 10'b0000000000 : (det_brick_edge ? 10'b0000000000 : (DPDT_SW[7] ? BASE_B : 10'b0000000000))))) : BASE_B;

	//Switch 15: display kernels
	
// --------------------------------------------------------------------
// AI
// --------------------------------------------------------------------	
	
	reg [10:0] goomba_x_1;
	reg [10:0] goomba_y_1;
	
	reg [10:0] pipe_corner_x;
	reg [10:0] pipe_corner_y;
	
	/*always @ (posedge det_goomba)
	begin
		goomba_x_1 <= VGA_X;
		goomba_y_1 <= VGA_Y;
	end*/
	
	//The sum could conceivably be up to 18 bits (+246400) for 560x440 checking area.
	reg [17:0] pipe_corner_found_sum;
	reg [17:0] pipe_corner_found_sum_frame;
	reg pipe_corner_found;
	
	reg [17:0] brick_edge_found_sum;
	reg [17:0] brick_edge_found_sum_frame;
	reg brick_edge_found;
	
	reg [17:0] block_wall_found_sum;
	reg [17:0] block_wall_found_sum_frame;
	reg block_wall_found;
	
	reg [17:0] goomba_found_sum;
	reg [17:0] goomba_found_sum_frame;
	reg goomba_found;
	
	reg multi_goomba_found;
	
	reg [10:0] bar_y;
	
	reg det_set;
	
	reg new_frame;
	reg new_frame_ofcorner;
	reg new_frame_goomba;
	
	//Pipe detection and jumping
	//Do this for every single Pixel that we draw.
	//always @ (VGA_Y or VGA_X)
	
	///////////////////////////////PIPE DETECTION///////////////////////////////////
	always @ (posedge OSC_27)
	begin
		if(Shift_En)
		begin
			//Sum up the info from this frame.
			if (VGA_Y == 1 && VGA_X == 1) //NOT(0,0)!~!!!!
			begin
				//If enough pipe pixels were detected, say we found a pipe corner.

				pipe_corner_found_sum_frame <= pipe_corner_found_sum;
				
				if (pipe_corner_found_sum > 1)
				begin
					pipe_corner_found <= 1;
				end
				else
				begin
					pipe_corner_found <= 0;
				end
				
				pipe_corner_found_sum <= 0;
				new_frame <= 1;
			end
			else
			begin
//				det_set <= 0;
				new_frame <= 0;
				pipe_corner_found_sum_frame <= pipe_corner_found_sum_frame;
				pipe_corner_found <= pipe_corner_found;
				
				//If we are not at the end of a frame, check each pixel (in range) for presence of pipe matrix
				if (det_pipe_corner && (VGA_X < PIPE_X_MAX_RANGE) && (VGA_X > PIPE_X_MIN_RANGE) && (VGA_Y < 479))
				begin
					pipe_corner_found_sum <= pipe_corner_found_sum + 1;
					pipe_corner_x <= VGA_X;
					pipe_corner_y <= VGA_Y;
				end
				else
				begin
					pipe_corner_found_sum <= pipe_corner_found_sum;
				end
			end
		end
		else
		begin
			//Otherwise, save the state
			new_frame <= new_frame;
			pipe_corner_found_sum_frame <= pipe_corner_found_sum_frame;
			pipe_corner_found <= pipe_corner_found;
		end
	end
	
	////////////////////////////////
	///////////////////////////////CORNER DETECTION///////////////////////////////////
	
	reg [10:0] lowest_brick_y;
	reg [10:0] brick_to_bar;
	
	
	
	always @ (posedge OSC_27)
	begin
		if(Shift_En)
		begin
			//Sum up the info from this frame.
			if (VGA_Y == 1 && VGA_X == 1) //Important that this checks at the end of the frame since it
														 //uses the bar location
			begin
				//If enough brick edge pixels detected.....
				brick_edge_found_sum_frame <= brick_edge_found_sum;
				
				brick_to_bar <= (bar_y > lowest_brick_y) ? (bar_y - lowest_brick_y) : ((480 - lowest_brick_y) + bar_y);
				
				if (brick_edge_found_sum > 80)
				begin
					if (bar_y > lowest_brick_y)
					begin
						if ((bar_y - lowest_brick_y) < 20)
						begin
							brick_edge_found <= 1;
						end
						else
						begin
							brick_edge_found <= 0;
						end
					end
					else
					begin
						if (((480 - lowest_brick_y) + bar_y) < 20)
						begin
							brick_edge_found <= 1;
						end
						else
						begin
							brick_edge_found <= 0;
						end
					end
				end
				else
				begin
					brick_edge_found <= 0;
				end
				
				block_wall_found_sum_frame <= block_wall_found_sum;
				
				if (block_wall_found_sum > 80)
				begin
					block_wall_found <= 1;
				end
				else
				begin
					block_wall_found <= 0;
				end
				
				brick_edge_found_sum <= 0;
				block_wall_found_sum <= 0;
				new_frame_ofcorner <= 1;
			end
			else
			begin
//				det_set <= 0;
				new_frame_ofcorner <= 0;
				brick_edge_found_sum_frame <= brick_edge_found_sum_frame;
				brick_edge_found <= brick_edge_found;
				block_wall_found_sum_frame <= block_wall_found_sum_frame;
				block_wall_found <= block_wall_found;
				
				//If we are not at the end of a frame, check each pixel (in range) for presence of brick corner matrix	
				if (det_brick_edge && (VGA_X < BRICK_X_MAX_RANGE) && (VGA_X > BRICK_X_MIN_RANGE) && (VGA_Y < 479))
				begin
					brick_edge_found_sum <= brick_edge_found_sum + 1;
					//pipe_corner_x <= VGA_X;
					//pipe_corner_y <= VGA_Y;
					if (~det_set)
					begin
						lowest_brick_y <= VGA_Y;
					end
					else
					begin
						if (bar_y < 11)
						begin
							lowest_brick_y <= VGA_Y;
						end
						else
						begin
							lowest_brick_y <= lowest_brick_y;
						end
					end
				end
				else
				begin
					lowest_brick_y <= lowest_brick_y;
					brick_edge_found_sum <= brick_edge_found_sum;
				end
				
				if (det_brick_edge && (VGA_X < 335) && (VGA_X > 315) && (VGA_Y < 479))
				begin
					block_wall_found_sum <= brick_edge_found_sum + 1;
				end
				else
				begin
					block_wall_found_sum <= brick_edge_found_sum;
				end
			end
		end
		else
		begin
			new_frame_ofcorner <= new_frame_ofcorner;
			brick_edge_found_sum <= brick_edge_found_sum;
			brick_edge_found <= brick_edge_found;
			block_wall_found_sum <= block_wall_found_sum;
			block_wall_found <= block_wall_found;
			lowest_brick_y <= lowest_brick_y;
		end
	end
	/////////////////////////////////
	///////////////////////////////GOOMBA DETECTION//////////////////////////////////////
	reg [10:0] lowest_goomba_y;
	reg [10:0] goomba_to_bar;
	
	always @ (posedge OSC_27)
	begin
		if(Shift_En)
		begin
			//Sum up the info from this frame.
			if (VGA_Y == 1 && VGA_X == 1) //NOT(0,0)!~!!!!
			begin
				//If enough goomba pixels were detected, say we found a goomba.

				goomba_found_sum_frame <= goomba_found_sum;
				
				goomba_to_bar <= (bar_y > lowest_goomba_y) ? (bar_y - lowest_goomba_y) : ((480 - lowest_goomba_y) + bar_y);
				
				if (goomba_found_sum > 15)
				begin
					if (bar_y > lowest_goomba_y)
					begin
						if ((bar_y - lowest_goomba_y) < 85)
						begin
							if (goomba_found_sum > 30)
							begin
								multi_goomba_found <= 1;
							end
							else
							begin
								multi_goomba_found <= 0;
							end
							goomba_found <= 1;
						end
						else
						begin
							goomba_found <= 0;
							multi_goomba_found <= 0;
						end
					end
					else
					begin
						if (((480 - lowest_goomba_y) + bar_y) < 85)
						begin
							if (goomba_found_sum > 30)
							begin
								multi_goomba_found <= 1;
							end
							else
							begin
								multi_goomba_found <= 0;
							end
							goomba_found <= 1;
						end
						else
						begin
							goomba_found <= 0;
							multi_goomba_found <= 0;
						end
					end
					
				end
				else
				begin
					goomba_found <= 0;
					multi_goomba_found <= 0;
				end
				
				goomba_found_sum <= 0;
				new_frame_goomba <= 1;
			end
			else
			begin
//				det_set <= 0;
	
				new_frame_goomba <= 0;
				goomba_found_sum_frame <= goomba_found_sum_frame;
				goomba_found <= goomba_found;
				
				//If we are not at the end of a frame, check each pixel (in range) for presence of pipe matrix
				if (det_goomba && (VGA_X < GOOMBA_X_MAX_RANGE) && (VGA_X > GOOMBA_X_MIN_RANGE) && (VGA_Y < 479))
				begin
					goomba_found_sum <= goomba_found_sum + 1;
					
					if (~det_set)
					begin
						lowest_goomba_y <= VGA_Y;
					end
					else
					begin
						if (bar_y < 11)
						begin
							lowest_goomba_y <= VGA_Y;
						end
						else
						begin
							lowest_goomba_y <= lowest_goomba_y;
						end
					end
				end
				else
				begin
					lowest_goomba_y <= lowest_goomba_y;
					goomba_found_sum <= goomba_found_sum;
				end
			end
		end
		else
		begin
			//Otherwise, save the state
			lowest_goomba_y <= lowest_goomba_y;
			goomba_to_bar <= goomba_to_bar;
			new_frame_goomba <= new_frame_goomba;
			goomba_found_sum_frame <= goomba_found_sum_frame;
			goomba_found <= goomba_found;
		end
	end
	
	///////////////////////////////BAR DETECTION//////////////////////////////////////
	always @ (posedge OSC_27)
	begin
		if(Shift_En)
		begin
			//Sum up the info from this frame.
			if (VGA_Y == 1 && VGA_X == 1) //NOT(0,0)!~!!!!
			begin
				bar_y <= 1;
				det_set <= 0;
			end
			else if (det_bar && ~det_set)
			begin
				bar_y <= VGA_Y;
				det_set <= 1;
			end
		end
		else
		begin
			//Otherwise, save the state
			bar_y <= bar_y;
			det_set <= det_set;
		end
	end
	
	
	/////////////////////////////
	
   //assign mVGA_gs = (mVGA_th == 1) ? 10'b1111111111 : 0;
	
	/*always @ (OSC_27)
	begin
		//if (grid == kernel)
		if (kd_sum < kd_thresh)
		begin
			mVGA_gs_r <= 10'b1111111111;
			mVGA_gs_g <= 10'b0000000000;
			mVGA_gs_b <= 10'b0000000000;
		end
		else
		begin
			//mVGA_gs_r <= (mVGA_th == 1) ? 10'b1111111111 : 0;
			//mVGA_gs_g <= (mVGA_th == 1) ? 10'b1111111111 : 0;
			//mVGA_gs_b <= (mVGA_th == 1) ? 10'b1111111111 : 0;
			if (DPDT_SW[2])
			begin
				mVGA_gs_r <= mVGA_R_int;
				mVGA_gs_g <= mVGA_G_int;
				mVGA_gs_b <= mVGA_B_int;
			end
			else
			begin
				if (DPDT_SW[4:3] == 0)
				begin
					mVGA_gs_r <= mVGA_r_th_full;
					mVGA_gs_g <= mVGA_r_th_full;
					mVGA_gs_b <= mVGA_r_th_full; 
				end
				else if (DPDT_SW[4:3] == 1)
				begin
					mVGA_gs_r <= mVGA_g_th_full;
					mVGA_gs_g <= mVGA_g_th_full;
					mVGA_gs_b <= mVGA_g_th_full;
				end
				else if (DPDT_SW[4:3] == 2)
				begin
					mVGA_gs_r <= mVGA_b_th_full;
					mVGA_gs_g <= mVGA_b_th_full;
					mVGA_gs_b <= mVGA_b_th_full;
				end
				else if (DPDT_SW[4:3] == 3)
				begin
					mVGA_gs_r <= mVGA_r_th_full;
					mVGA_gs_g <= mVGA_g_th_full;
					mVGA_gs_b <= mVGA_b_th_full;
				end
			end
		end
	end*/
		
  
//  assign mVGA_R = mVGA_R_int;
//  assign mVGA_G = mVGA_G_int;
//  assign mVGA_B = mVGA_B_int;
	
    assign mVGA_R = mVGA_gs_r;
    assign mVGA_G = mVGA_gs_g;
    assign mVGA_B = mVGA_gs_b;

//  assign mVGA_R = (VGA_pixel_gs == 1) ? 1023 : 0;
//  assign mVGA_G = (VGA_pixel_gs == 1) ? 1023 : 0;
//  assign mVGA_B = (VGA_pixel_gs == 1) ? 1023 : 0;
  
// --------------------------------------------------------------------
// Misc
// --------------------------------------------------------------------

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
  //assign m1VGA_Read = VGA_Read;
  //assign m2VGA_Read = VGA_Read;
  
  assign  mYCbCr_d   =  !VGA_Y[0] ?  m1YCbCr  :  m2YCbCr;
  //assign  mYCbCr_d   =  m1YCbCr;
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

//Line_Buffer u10  
//  (  
//    .clken    (VGA_Read),
//    .clock    (OSC_27),
//    .shiftin  (mYCbCr_d),
//    .shiftout (m4YCbCr)
//  );
  //assign m4YCbCr = mYCbCr_d;

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

//////////////////////////////////////////////
// Decode one hex digit for LED 7-seg display
module HexDigit(segs, num);
	input [3:0] num	;		//the hex digit to be displayed
	output [6:0] segs ;		//actual LED segments
	reg [6:0] segs ;
	always @ (num)
	begin
		case (num)
				4'h0: segs = 7'b1000000;
				4'h1: segs = 7'b1111001;
				4'h2: segs = 7'b0100100;
				4'h3: segs = 7'b0110000;
				4'h4: segs = 7'b0011001;
				4'h5: segs = 7'b0010010;
				4'h6: segs = 7'b0000010;
				4'h7: segs = 7'b1111000;
				4'h8: segs = 7'b0000000;
				4'h9: segs = 7'b0010000;
				default segs = 7'b1111111;
		endcase
	end
endmodule
///////////////////////////////////////////////
