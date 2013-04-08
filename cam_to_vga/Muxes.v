//========================================================================
// Different Mux modules
//========================================================================

`ifndef MUXES_V
`define MUXES_V

//------------------------------------------------------------------------
// 2-Input Mux
//------------------------------------------------------------------------

module Mux2
#(
    parameter nbits = 1
 )
(
  input      [nbits-1:0] in0,
  input      [nbits-1:0] in1,
  input                  sel,
  output reg [nbits-1:0] out
);

  always @( * ) begin
    case( sel )
      1'b0: out = in0;
      1'b1: out = in1;
      default: out = { nbits{1'bx} };
    endcase
  end
  
endmodule

//------------------------------------------------------------------------
// 3-Input Mux
//------------------------------------------------------------------------

module Mux3
#(
    parameter nbits = 1
 )
(
  input      [nbits-1:0] in0,
  input      [nbits-1:0] in1,
  input      [nbits-1:0] in2,
  input            [1:0] sel,
  output reg [nbits-1:0] out
);

  always @( * ) begin
    case( sel )
      2'b00: out = in0;
      2'b01: out = in1;
      2'b10: out = in2;
      default: out = { nbits{1'bx} };
    endcase
  end
  
endmodule

//------------------------------------------------------------------------
// 4-Input Mux
//------------------------------------------------------------------------

module Mux4
#(
    parameter nbits = 1
 )
(
  input      [nbits-1:0] in0,
  input      [nbits-1:0] in1,
  input      [nbits-1:0] in2,
  input      [nbits-1:0] in3,
  input            [1:0] sel,
  output reg [nbits-1:0] out
);

  always @( * ) begin
    case( sel )
      2'b00: out = in0;
      2'b01: out = in1;
      2'b10: out = in2;
      2'b11: out = in3;
      default: out = { nbits{1'bx} };
    endcase
  end
  
endmodule

`endif /* MUXES_V */