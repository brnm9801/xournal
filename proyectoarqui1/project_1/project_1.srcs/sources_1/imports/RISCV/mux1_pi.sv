`timescale 1ns / 1ps


module mux1_pi #(parameter ANCHO = 32)(
	input  logic 		       sel,
	input  logic [ANCHO-1 : 0] a,
	input  logic [ANCHO-1 : 0] b,
	output logic [ANCHO-1 : 0] c
);

assign c = sel ? b : a;
endmodule