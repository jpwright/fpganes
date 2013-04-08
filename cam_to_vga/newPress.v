////////////////////////////////////////////////////////////
//newPress module determines when a button has been pressed.
//It debounces so the output is high for only 1 cycle after
//  a new press. 
////////////////////////////////////////////////////////////
module newPress (
	iCLK,
	iKey,
	oNewPress
);

	input iCLK;
	input iKey;		//Active high button input
	
	output oNewPress;
	
	reg [1:0] press;	//Key history buffer
	
	always @(posedge iCLK) begin
		//Update buffer like a shift register
		press <= {press[0], iKey};
	end
	
	//Only a new press after a rising edge of button
	assign oNewPress = ~press[1] & press[0];
	
endmodule
