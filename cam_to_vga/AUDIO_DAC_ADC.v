/////////////////////////////////////////////////////////////////////////
// modified from the Terasic version:
//   eliminate all memory references
//   simplify interface to top-level module
//   add audio I/O from top-level module
// modifed by Bruce Land, Cornell University 2007
/////////////////////////////////////////////////////////////////////////

module AUDIO_DAC_ADC (	
					oAUD_BCK,
					oAUD_DATA,
					oAUD_LRCK,
					oAUD_inL,
					oAUD_inR,
					iAUD_ADCDAT,
					iAUD_extR,
					iAUD_extL,
					//	Control Signals
				    iCLK_18_4,
					iRST_N	
					);				

parameter	REF_CLK			=	18432000;	//	18.432	MHz
parameter	SAMPLE_RATE		=	48000;		//	48		KHz
parameter	DATA_WIDTH		=	16;			//	16		Bits
parameter	CHANNEL_NUM		=	2;			//	Dual Channel

// audio input FROM top-level module
input signed [DATA_WIDTH-1:0]	iAUD_extR, iAUD_extL;
// audio output TO top-level module
output signed [DATA_WIDTH-1:0]	oAUD_inL, oAUD_inR;

//	Audio Side
output			oAUD_DATA;
output			oAUD_LRCK;
output	reg		oAUD_BCK;
input			iAUD_ADCDAT;
//	Control Signals
//input	[1:0]	iSrc_Select;
input			iCLK_18_4;
input			iRST_N;
//	Internal Registers and Wires
reg		[3:0]	BCK_DIV;
reg		[8:0]	LRCK_1X_DIV;
reg		[7:0]	LRCK_2X_DIV;
reg		[6:0]	LRCK_4X_DIV;
reg		[3:0]	SEL_Cont;

// to DAC and from ADC
reg signed [DATA_WIDTH-1:0]	AUD_outL, AUD_outR ;
reg	signed [DATA_WIDTH-1:0]	AUD_inL, AUD_inR ;

reg							LRCK_1X;
reg							LRCK_2X;
reg							LRCK_4X;

wire	[3:0]				bit_in;

//////////////////////////////////////////////////
////////////	AUD_BCK Generator	//////////////
/////////////////////////////////////////////////
always@(posedge iCLK_18_4 or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		BCK_DIV		<=	0;
		oAUD_BCK	<=	0;
	end
	else
	begin
		if(BCK_DIV >= REF_CLK/(SAMPLE_RATE*DATA_WIDTH*CHANNEL_NUM*2)-1 )
		begin
			BCK_DIV		<=	0;
			oAUD_BCK	<=	~oAUD_BCK;
		end
		else
		BCK_DIV		<=	BCK_DIV+1;
	end
end

//////////////////////////////////////////////////
////////////	AUD_LRCK Generator	//////////////
//oAUD_LRCK is high for left and low for right////
//////////////////////////////////////////////////
always@(posedge iCLK_18_4 or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		LRCK_1X_DIV	<=	0;
		LRCK_2X_DIV	<=	0;
		LRCK_4X_DIV	<=	0;
		LRCK_1X		<=	0;
		LRCK_2X		<=	0;
		LRCK_4X		<=	0;
	end
	else
	begin
		//	LRCK 1X
		if(LRCK_1X_DIV >= REF_CLK/(SAMPLE_RATE*2)-1 )
		begin
			LRCK_1X_DIV	<=	0;
			LRCK_1X	<=	~LRCK_1X;
		end
		else
		LRCK_1X_DIV		<=	LRCK_1X_DIV+1;
		//	LRCK 2X
		if(LRCK_2X_DIV >= REF_CLK/(SAMPLE_RATE*4)-1 )
		begin
			LRCK_2X_DIV	<=	0;
			LRCK_2X	<=	~LRCK_2X;
		end
		else
		LRCK_2X_DIV		<=	LRCK_2X_DIV+1;		
		//	LRCK 4X
		if(LRCK_4X_DIV >= REF_CLK/(SAMPLE_RATE*8)-1 )
		begin
			LRCK_4X_DIV	<=	0;
			LRCK_4X	<=	~LRCK_4X;
		end
		else
		LRCK_4X_DIV		<=	LRCK_4X_DIV+1;		
	end
end

assign oAUD_LRCK = LRCK_1X;


//////////////////////////////////////////////////
//////////	16 Bits - MSB First	//////////////////
/// Clocks in the ADC input
/// and sets up the output bit selector
/// and clocks out the DAC data
//////////////////////////////////////////////////
// first the ADC
always@(negedge oAUD_BCK or negedge iRST_N)
begin
	if(!iRST_N) SEL_Cont <= 0;
	else
	begin
		SEL_Cont <= SEL_Cont+1; //4 bit counter, so it wraps at 16
		if (LRCK_1X)
			AUD_inL[~(SEL_Cont)] <= iAUD_ADCDAT;
		else
			AUD_inR[~(SEL_Cont)] <= iAUD_ADCDAT;
	end
end
assign oAUD_inL = AUD_inL;
assign oAUD_inR = AUD_inR;

// now the DAC -- output the DAC bit-stream					
assign oAUD_DATA = (LRCK_1X)? AUD_outL[~SEL_Cont]: AUD_outR[~SEL_Cont] ;
//assign oAUD_DATA = (LRCK_1X)? iAUD_extL[~SEL_Cont]: iAUD_extR[~SEL_Cont] ;																			
// register the inputs	


always@(posedge LRCK_1X) //oAUD_LRCK --  posedge LRCK_1X
begin
	AUD_outR <= iAUD_extR; 
	AUD_outL <= iAUD_extL ;
 end 

//assign AUD_outR = iAUD_extR ; 
//assign AUD_outL = iAUD_extL ;

endmodule
								
			
					