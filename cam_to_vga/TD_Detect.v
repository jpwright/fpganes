module TD_Detect(	oTD_Stable,
					iTD_VS,
					iTD_HS,
					iRST_N	);
input		iTD_VS;
input		iTD_HS;
input		iRST_N;
output		oTD_Stable;
reg			TD_Stable;
reg			Pre_VS;
reg	[7:0]	Stable_Cont;

assign	oTD_Stable	=	TD_Stable;

always@(posedge iTD_HS or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		TD_Stable	<=	1'b0;
		Stable_Cont	<=	4'h0;
		Pre_VS		<=	1'b0;
	end
	else
	begin
		Pre_VS	<=	iTD_VS;
		if(!iTD_VS)
		Stable_Cont	<=	Stable_Cont+1'b1;
		else
		Stable_Cont	<=	0;
		
		if({Pre_VS,iTD_VS}==2'b01)
		begin
			if(Stable_Cont==9)
			TD_Stable	<=	1'b1;
			else
			TD_Stable	<=	1'b0;
		end
	end
end

endmodule