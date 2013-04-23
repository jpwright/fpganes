///////////////////////////////////////////////////////
// 3 Line Buffer with taps for use in edge detection //
///////////////////////////////////////////////////////

module buffer3 (
	clock,
	clken,
	shiftin,
	shiftout,
	oGrid);
	
	input		wire			clock,clken;
	input		wire	[29:0]	shiftin;
	
	integer i;
	
	//probably should store intensity value into "Grid," not RGB value, for use in edgedetect
	//RGB value will only be used in line buffer, and will be output to screen if not edge
	//if it is an edge, we will output black (or whatever color we choose for the line)
	output	wire	[269:0]	oGrid;
	output	reg	[29:0]	shiftout;
	
	reg	[29:0]	line1 	[639:0];
	reg	[29:0]	line2		[639:0];
	reg	[29:0]	line3		[639:0];
	//reg	[29:0]	grid_2d	[8:0];
	
	//assign oGrid = {grid_2d[8],grid_2d[7],grid_2d[6],grid_2d[5],grid_2d[4],grid_2d[3],grid_2d[2],grid_2d[1],grid_2d[0]};
	
	assign oGrid = {line1[639],line1[638],line1[637],		// grid[8] grid[7] grid[6]
						 line2[639],line2[638],line2[637],		// grid[5] grid[4] grid[3]
						 line3[639],line3[638],line3[637]};		// grid[2] grid[1] grid[0]

	
	always @ (posedge clock) begin
		if(clken) begin
			line1[0] <= shiftin;
			line2[0] <= line1[639];
			line3[0] <= line2[639];
			for(i=1;i<640;i=i+1)begin
				line1[i] <= line1[i-1];
				line2[i] <= line2[i-1];
				line3[i] <= line3[i-1];
			end
			shiftout <= line2[638];
			//grid_2d[8:0] <= {line3[639:637],line2[639:637],line1[639:637]};
		end
		else begin
			for(i=0;i<640;i=i+1)begin
				line1[i] <= line1[i];
				line2[i] <= line2[i];
				line3[i] <= line3[i];
			end
			shiftout <= shiftout;
		end
	end


endmodule
