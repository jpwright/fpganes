//========================================================================
// Different Registers of variable width and control
//========================================================================

`ifndef REGS_V
`define REGS_V

//------------------------------------------------------------------------
// Register
//------------------------------------------------------------------------

module Reg
#(
    parameter nbits = 1
 )
(
  input                  clk,
  input      [nbits-1:0] in,
  output reg [nbits-1:0] out
);

  always @( posedge clk ) begin
    out <= in;
  end
  
endmodule

//------------------------------------------------------------------------
// Register with enable
//------------------------------------------------------------------------

module RegEn
#(
    parameter nbits = 1
 )
(
  input                  clk,
  input                  en,
  input      [nbits-1:0] in,
  output reg [nbits-1:0] out
);

  always @( posedge clk ) begin
    if ( en )
      out <= in;
  end
  
endmodule

//------------------------------------------------------------------------
// Register with reset
//------------------------------------------------------------------------

module RegRst
#(
    parameter nbits = 1,
    parameter reset_value = 0
 )
(
  input                  clk,
  input                  reset,
  input      [nbits-1:0] in,
  output reg [nbits-1:0] out
);

  always @( posedge clk ) begin
    if ( reset )
      out <= reset_value;
    else
      out <= in;
  end

endmodule

//------------------------------------------------------------------------
// Register with enable and reset
//------------------------------------------------------------------------

module RegEnRst
#(
    parameter nbits = 1,
    parameter reset_value = 0
 )
(
  input                  clk,
  input                  reset,
  input                  en,
  input      [nbits-1:0] in,
  output reg [nbits-1:0] out
);

  always @( posedge clk ) begin
    if ( reset )
      out <= reset_value;
    else if ( en )
      out <= in;
  end

endmodule

`endif /* REGS_V */