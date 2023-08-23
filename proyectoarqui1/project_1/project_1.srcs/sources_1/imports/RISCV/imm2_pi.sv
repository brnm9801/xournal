`timescale 1ns / 1ps


module imm2_pi (
  input  logic signed [4:0]  in,  //in [11 : 7]
  input logic signed [6 : 0] in2,  //in2 [31 : 25]
  output logic signed [31:0] out
);

  assign out = { {19{in2[6]}}, in2[6], in[0], in2[5 : 0], in[4 : 1],1'b0};

endmodule
