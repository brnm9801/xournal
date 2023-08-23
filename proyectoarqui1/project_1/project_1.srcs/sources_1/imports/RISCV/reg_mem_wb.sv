`timescale 1ns / 1ps

module reg_mem_wb(
input logic clk,
input rst,

input logic [31:0] alumem,
input logic [31:0] datamem,
input logic [4:0] rdmem,
input logic mux2mem,
input logic weregmem,

output logic [31:0] alu_wb,
output logic [31:0] data_wb,
output logic [4:0] rdwb,
output logic mux2wb,
output logic weregwb
    );
    
    always_ff @ (posedge clk) begin
        if (rst) begin
            alu_wb <= 0;
            data_wb <= 0;
            rdwb <= 0;
            mux2wb <= 0;
            weregwb <= 0;
            end
        
        else begin
            alu_wb <= alumem;
            data_wb <= datamem;
            rdwb <= rdmem;
            mux2wb <= mux2mem;
            weregwb<= weregmem;

            end
    end
    
endmodule
