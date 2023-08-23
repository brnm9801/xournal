`timescale 1ns / 1ps

module tb_riscv();
logic clk_pi;
logic reset_pi;
//logic [31 : 0] rom_o;
//logic [31 : 0] entrada_i;
logic [31 : 0] pc_addr;
logic [31 : 0] ram_addr;
logic [31 : 0] data_o;

riscv_pi dut (
.clk_pi (clk_pi),
.reset_pi (reset_pi),
//.rom_o (rom_o),
//.entrada_i (entrada_i),
.pc_addr (pc_addr),
.ram_addr (ram_addr),
.data_o (data_o)
);


initial begin
    clk_pi = 1;
    forever #10 clk_pi = ~clk_pi;
end
initial begin
    reset_pi=1;
    #10
    reset_pi=0;
    
    
end
endmodule
