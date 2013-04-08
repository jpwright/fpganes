///////////////////////////////////////////////////
// 3x3 Convolution for Horizontal Edge Detection //
///////////////////////////////////////////////////

module edgedetectH (
	clock,
	iGrid,
	iThreshold,
	oPixel
	);
	
	input	wire				clock;
	input	wire	[89:0]	iGrid;
	input wire	[9:0]		iThreshold;
	
	output	reg	oPixel; //0 if not edge, 1 if edge
	
	wire	[9:0] top, bottom, sum1, sum2;
	wire	[9:0] intensity [8:0];
	
	assign intensity[0] = iGrid[9:0];
	assign intensity[1] = iGrid[19:10];
	assign intensity[2] = iGrid[29:20];
	assign intensity[3] = iGrid[39:30];
	assign intensity[4] = iGrid[49:40];
	assign intensity[5] = iGrid[59:50];
	assign intensity[6] = iGrid[69:60];
	assign intensity[7] = iGrid[79:70];
	assign intensity[8] = iGrid[89:80];
	
	assign top = intensity[8]+(intensity[7]<<1)+intensity[6];
	assign bottom = intensity[2]+(intensity[1]<<1)+intensity[0];
	
	assign sum1 = top-bottom;
	assign sum2 = bottom-top;

	always @ (posedge clock) begin
		if ((sum1[9]==0 && (sum1 > iThreshold)) || (sum2[9]==0 && (sum2 > iThreshold))) begin
			oPixel <= 1'b1;
		end
		else begin
			oPixel <= 1'b0;
		end
	end
endmodule
