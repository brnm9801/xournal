`timescale 1ns / 1ps



module reg_ex_mem(
input logic clk,
input logic rst,

input logic [31:0] aluout_e,
input logic [31:0] data_e,
input logic [4:0] rde,
input logic mux2e,
input logic wereg_e,
input logic wemem_e,

output logic [31:0] aluout_mem,
output logic [31:0] data_mem,
output logic [4:0] rd_mem,
output logic mux2_mem,
output logic wereg_mem,
output logic wemem_mem
    );
    
            always_ff @ (posedge clk) begin
        if (rst) begin
            aluout_mem <= 0;
            data_mem <= 0;
            rd_mem <= 0;
            mux2_mem <= 0;
            wereg_mem <= 0;
            wemem_mem <= 0;
            end
        
        else begin
            aluout_mem <= aluout_e;
            data_mem <= data_e;
            rd_mem <= rde;
            mux2_mem <= mux2e;
            wereg_mem <= wereg_e;
            wemem_mem <= wemem_e;

            end
    end
    
endmodule
