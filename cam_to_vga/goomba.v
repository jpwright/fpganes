module goomba(	//	Input Side
					mVGA_R,
					mVGA_G,
					mVGA_B,
					VGA_X,
					VGA_Y,
					goomba_Red,
					goomba_Green,
					goomba_Blue );
//	Input Side					
input	[9:0]	mVGA_R;
input [9:0] mVGA_G;
input [9:0] mVGA_B;

input [10:0] VGA_X;
input [10:0] VGA_Y;

//	Output Side
output	[9:0]	goomba_Red;
output	[9:0]	goomba_Green;
output   [9:0] goomba_Blue;


endmodule