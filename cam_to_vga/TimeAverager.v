//Time averages a 2x2 block of pixels
module TimeAverager (
	iCLK, 
	iVGA_BLANK,
	iVGA_X, iVGA_Y,
	iRed, iGreen, iBlue,
	oRed, oGreen, oBlue,
	oSRAM_WE_N,
	oSRAM_ADDR,
	SRAM_DQ );
	
	input 		iCLK;			
	input			iVGA_BLANK;
	input [9:0]	iVGA_X, iVGA_Y;	//Address requested by VGA Ctrl
	input [4:0] iRed, iGreen, iBlue;
	
	output reg [4:0]	oRed, oGreen, oBlue;
	output 	 			oSRAM_WE_N;
	output 	  [17:0] oSRAM_ADDR;
	
	inout [15:0]	SRAM_DQ;
	
	wire [15:0] avg_in, avg_out;
	
	reg [15:0] temp;
	
	//To make 2x2 blocking, discard LSB and address for 320x240
	assign oSRAM_ADDR = {iVGA_Y[9:1],iVGA_X[9:1]};
	
	//Read during first cycle, write during second
	assign SRAM_DQ = iVGA_X[0] ? avg_out : 16'hzzzz;
	
	//Time averager module
	averager avg0 (iRed, iGreen, iBlue, avg_in, avg_out);
	//Take input from SRAM during first cycle
	assign avg_in = iVGA_X[0] ?  temp : SRAM_DQ;
	
	//Only write during first cycle if not a VGA blank
	assign oSRAM_WE_N = (iVGA_X[0] && iVGA_BLANK) ? 1'b0 : 1'b1;
	
	//update 
	always @(posedge iCLK) begin
		oRed <= avg_out[14:10];
		oGreen <= avg_out[9:5];
		oBlue <= avg_out[4:0];
		temp <= avg_out;
	end
	
endmodule
	
	