`timescale 1ns / 1ps


module imm1_pi (
  input  logic signed [11:0]  in,
  output logic signed [31:0] out
);

  assign out = { {20{in[11]}}, in };

endmodule