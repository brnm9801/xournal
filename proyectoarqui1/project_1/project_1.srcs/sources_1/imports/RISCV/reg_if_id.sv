`timescale 1ns / 1ps


module reg_if_id(
    input  logic         clk_i,
    input  logic         rst_i,
    input  logic         stall,
    input  logic [31:0]  pc_if,
    input  logic [31:0]  instruction_if,
    output logic [31:0]  pc_id,
    output logic [31:0]  instruction_id
    );
    
    always_ff @ (posedge clk_i) begin
        if (rst_i) begin
            instruction_id <= 0;
            pc_id <= 0;
            end
        
        else if (stall == 0) begin
            instruction_id <= instruction_if;   
            pc_id <= pc_if;
            end
            
       // else if (stall) begin
       // instruction_id <= instruction_id;
        //pc_id <= pc_id;
        //end
    end
endmodule
