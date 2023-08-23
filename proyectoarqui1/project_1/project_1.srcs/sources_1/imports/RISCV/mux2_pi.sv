`timescale 1ns / 1ps


module mux2_pi #(parameter ANCHO = 5)(
	input  logic 		       sel,
	input  logic [ANCHO-1 : 0] i_20_24,
	input  logic [ANCHO-1 : 0] i_7_11,
	output logic [ANCHO-1 : 0] imm_0_4
);

assign imm_0_4 = sel ? i_7_11 : i_20_24;
endmodule