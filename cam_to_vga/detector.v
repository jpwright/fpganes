module detector(
	clock,
	clken,
	VGA_X,
	VGA_Y,
	XMIN,
	XMAX,
	det,
	det_set,
	bar_y,
	frame_thresh,
	frame_thresh2,
	y_thresh,
	found,
	found2,
	new_frame);
	
	input	wire	clock, clken;
	input wire  VGA_X, VGA_Y;
	input wire  XMIN, XMAX, det, det_set;
	input wire  bar_y;
	input wire  frame_thresh, frame_thresh2, y_thresh;
	
	output reg found;
	output reg found2;
	output reg new_frame;
	
	reg [10:0] lowest_y;
	reg [17:0] found_sum;
	reg [17:0] found_sum_frame;
	
	always @ (posedge clock)
	begin
		if(clken)
		begin
			//Sum up the info from this frame.
			if (VGA_Y == 1 && VGA_X == 1) //NOT(0,0)!~!!!!
			begin
				//If enough goomba pixels were detected, say we found a goomba.

				found_sum_frame <= found_sum;
				
				if (found_sum > frame_thresh)
				begin
					if (bar_y > lowest_y)
					begin
						if ((bar_y - lowest_y) < y_thresh)
						begin
							if (found_sum > frame_thresh2)
							begin
								found2 <= 1;
							end
							else
							begin
								found2 <= 0;
							end
							found <= 1;
						end
						else
						begin
							found <= 0;
							found2 <= 0;
						end
					end
					else
					begin
						if (((480 - lowest_y) + bar_y) < y_thresh)
						begin
							if (found_sum > frame_thresh2)
							begin
								found2 <= 1;
							end
							else
							begin
								found2 <= 0;
							end
							found <= 1;
						end
						else
						begin
							found <= 0;
							found2 <= 0;
						end
					end
					
				end
				else
				begin
					found <= 0;
					found2 <= 0;
				end
				
				found_sum <= 0;
				new_frame <= 1;
			end
			else
			begin
//				det_set <= 0;
	
				new_frame <= 0;
				found_sum_frame <= found_sum_frame;
				found <= found;
				
				//If we are not at the end of a frame, check each pixel (in range) for presence of pipe matrix
				if (det && (VGA_X < XMAX) && (VGA_X > XMIN) && (VGA_Y < 479))
				begin
					found_sum <= found_sum + 1;
					
					if (~det_set)
					begin
						lowest_y <= VGA_Y;
					end
					else
					begin
						if (bar_y < 11)
						begin
							lowest_y <= VGA_Y;
						end
						else
						begin
							lowest_y <= lowest_y;
						end
					end
				end
				else
				begin
					lowest_y <= lowest_y;
					found_sum <= found_sum;
				end
			end
		end
		else
		begin
			//Otherwise, save the state
			lowest_y <= lowest_y;
			new_frame <= new_frame;
			found_sum_frame <= found_sum_frame;
			found <= found;
		end
	end
endmodule
