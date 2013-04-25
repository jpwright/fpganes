//11 line buffer
module buffer11(
  clock,
	clken,
	shiftin,
	shiftout,
	oGrid);

	input	wire	clock, clken;
	input	wire	shiftin;
	integer	i;
	output	wire [120:0] oGrid;
	output	reg  shiftout;
	reg line1 [639:0];
	reg line2 [639:0];
	reg line3 [639:0];
	reg line4 [639:0];
	reg line5 [639:0];
	reg line6 [639:0];
	reg line7 [639:0];
	reg line8 [639:0];
	reg line9 [639:0];
	reg line10 [639:0];
	reg line11 [639:0];
	assign oGrid={line1[639],line1[638],line1[637],line1[636],line1[635],line1[634],line1[633],line1[632],line1[631],line1[630],line1[629],
			line2[639],line2[638],line2[637],line2[636],line2[635],line2[634],line2[633],line2[632],line2[631],line2[630],line2[629],
			line3[639],line3[638],line3[637],line3[636],line3[635],line3[634],line3[633],line3[632],line3[631],line3[630],line3[629],
			line4[639],line4[638],line4[637],line4[636],line4[635],line4[634],line4[633],line4[632],line4[631],line4[630],line4[629],
			line5[639],line5[638],line5[637],line5[636],line5[635],line5[634],line5[633],line5[632],line5[631],line5[630],line5[629],
			line6[639],line6[638],line6[637],line6[636],line6[635],line6[634],line6[633],line6[632],line6[631],line6[630],line6[629],
			line7[639],line7[638],line7[637],line7[636],line7[635],line7[634],line7[633],line7[632],line7[631],line7[630],line7[629],
			line8[639],line8[638],line8[637],line8[636],line8[635],line8[634],line8[633],line8[632],line8[631],line8[630],line8[629],
			line9[639],line9[638],line9[637],line9[636],line9[635],line9[634],line9[633],line9[632],line9[631],line9[630],line9[629],
			line10[639],line10[638],line10[637],line10[636],line10[635],line10[634],line10[633],line10[632],line10[631],line10[630],line10[629],
			line11[639],line11[638],line11[637],line11[636],line11[635],line11[634],line11[633],line11[632],line11[631],line11[630],line11[629]
			};
	always @ (posedge clock) begin
		if(clken)
		begin
			line1[0] <= shiftin;
			line2[0] <= line1[639];
			line3[0] <= line2[639];
			line4[0] <= line3[639];
			line5[0] <= line4[639];
			line6[0] <= line5[639];
			line7[0] <= line6[639];
			line8[0] <= line7[639];
			line9[0] <= line8[639];
			line10[0] <= line9[639];
			line11[0] <= line10[639];
			for(i=1;i<640;i=i+1)
			begin
				line1[i] <= line1[i-1];
				line2[i] <= line2[i-1];
				line3[i] <= line3[i-1];
				line4[i] <= line4[i-1];
				line5[i] <= line5[i-1];
				line6[i] <= line6[i-1];
				line7[i] <= line7[i-1];
				line8[i] <= line8[i-1];
				line9[i] <= line9[i-1];
				line10[i] <= line10[i-1];
				line11[i] <= line11[i-1];
			end
			shiftout <= line6[634];
		end
		else
		begin
			for(i=0;i<640;i=i+1)
			begin
				line1[i] <= line1[i];
				line2[i] <= line2[i];
				line3[i] <= line3[i];
				line4[i] <= line4[i];
				line5[i] <= line5[i];
				line6[i] <= line6[i];
				line7[i] <= line7[i];
				line8[i] <= line8[i];
				line9[i] <= line9[i];
				line10[i] <= line10[i];
				line11[i] <= line11[i];
			end
			shiftout <= shiftout;
		end
	end
endmodule
