module recolor(	//	Input Side
					iCCD_R,
					iCCD_G,
					iCCD_B,
					iCCD_DVAL,
					iCCD_PIXCLK,
					iRST_N,
					//	Output Side
					oCCD_R,
					oCCD_G,
					oCCD_B,
					oCCD_DVAL	);
//	Input Side					
input	[9:0]	iCCD_R;
input	[9:0]	iCCD_G;
input	[9:0]	iCCD_B;
input			iCCD_DVAL;
input			iCCD_PIXCLK;
input			iRST_N;
//	Output Side
output	[9:0]	oCCD_R;
output	[9:0]	oCCD_G;
output	[9:0]	oCCD_B;
output			oCCD_DVAL;
//	Internal Registers
reg		[9:0]	Z_Cont;
reg				mCCD_DVAL;

assign	oCCD_DVAL	=	iCCD_DVAL;

assign oCCD_R = iCCD_R; //& 10'b1000000000;
assign oCCD_G = iCCD_G; //& 10'b1000000000;
assign oCCD_B = iCCD_B; //& 10'b1000000000;
//assign oCCD_R = 10'b1000000000;
//assign oCCD_G = 10'b0000000000;
//assign oCCD_B = 10'b0000000000;

//SCrew with the colors.
//Stack_RAM (
//			.clock(iCCD_PIXCLK),
//			.data(iCCD_B),
//			.rdaddress(Z_Cont),
//			.wraddress(Z_Cont),
//			.wren(iCCD_DVAL),
//			.q(oCCD_R));
//
//Stack_RAM (
//			.clock(iCCD_PIXCLK),
//			.data(iCCD_B),
//			.rdaddress(Z_Cont),
//			.wraddress(Z_Cont),
//			.wren(iCCD_DVAL),
//			.q(oCCD_G));
//
//Stack_RAM (
//			.clock(iCCD_PIXCLK),
//			.data(iCCD_B),
//			.rdaddress(Z_Cont),
//			.wraddress(Z_Cont),
//			.wren(iCCD_DVAL),
//			.q(oCCD_B));

endmodule