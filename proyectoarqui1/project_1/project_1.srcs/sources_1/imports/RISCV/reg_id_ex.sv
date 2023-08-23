`timescale 1ns / 1ps

module reg_id_ex(
input logic clk,
input logic reset,

input logic [31:0] rs1,
input logic [31:0] rs2,
input logic [4:0] rs1_id,
input logic [4:0] rs2_id,
input logic [4:0] rd_id,
input logic [31:0] in_pc_id,

input logic [31:0] extend1_id,
input  logic [31:0] extend2_id,

input logic [3:0] alu_id,
input logic mux1_id,
input logic mux2_id,
input logic stall,
input lw,
//input logic mux3_in,
//input logic demux_in,
input logic [1:0] pcsel_id,
input logic we_regid,
input logic we_memid,

output logic lw_o,
output logic [31:0] rs1e,
output logic [31:0] rs2e,
output logic [4:0] rs1_e,
output logic [4:0] rs2_e,
output logic [4:0] rd_e,
output logic [31:0] pc_e,
output logic [31:0] extend1_e,
output logic [31:0] extend2_e,

output logic [3:0] alu_e,
output logic mux1_e,
output logic mux2_e,
output logic [1:0] pcsel_e,
output logic we_rege,
output logic we_meme
    );
    
        always_ff @ (posedge clk) begin
        if (reset) begin
            rs1e <= 0;
            rs2e <= 0;
            rs1_e <= 0;
            rs2_e <= 0;
            rd_e <= 0;
            pc_e <= 0;
            extend1_e <= 0;
            extend2_e <= 0;
            alu_e <= 0;
            mux1_e <= 0;
            mux2_e <= 0;
            pcsel_e <= 0;;
            we_rege <= 0;
            we_meme <= 0;
            lw_o <= 0;
            end
        
        else begin
            rs1e <= rs1;
            rs2e <= rs2;
            rs1_e <= rs1_id;
            rs2_e <= rs2_id;
            rd_e <= rd_id;
            pc_e <= in_pc_id;
            extend1_e <= extend1_id;
            extend2_e <= extend2_id;
            alu_e <= alu_id;
            mux1_e <= mux1_id;
            mux2_e <= mux2_id;
            pcsel_e <= pcsel_id;
            we_rege <= we_regid;
            we_meme <= we_memid;
            lw_o <= lw;
            end
    end
    
    
endmodule
