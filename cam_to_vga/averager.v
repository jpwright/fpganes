//Weighted averager low-pass filter module
module averager (
	iRed, iGreen, iBlue,
	iOld,
	oNew );
	
	input	[4:0]		iRed, iGreen, iBlue;	
	input	[15:0]	iOld;		//Saved sum: RGB={x,5,5,5}
	
	output	[15:0]	oNew;	//New sum: RGB={x,5,5,5}
	
	parameter n=2;	//Number of frames to average over
	
	//alpha = 2^-n
	//Sum = old(1-alpha) + alpha*new
	//Sum = old - alpha*old + alpha*new
	//Sum = old - old>>n + new>>n
	assign oNew[14:10] = iOld[14:10] - (iOld[14:10]>>n) + (iRed>>n);
	assign oNew[9:5]   = iOld[9:5]   - (iOld[9:5]>>n)   + (iGreen>>n);
	assign oNew[4:0]   = iOld[4:0]   - (iOld[4:0]>>n)   + (iBlue>>n);
	
endmodule
