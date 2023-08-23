`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2023 18:37:22
// Design Name: 
// Module Name: imem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imem(


    input logic [31:0] a,
    output logic [31:0] rd
    
    );
    
    logic [31:0] RAM[100:0];
 
    initial
        $readmemh("c3.txt",RAM);
    
    assign rd = RAM[a[31:2]]; // word aligned


endmodule
