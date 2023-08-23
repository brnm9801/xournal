`timescale 1ns / 1ps


module riscv_pi(

input logic clk_pi,
input logic reset_pi,
//input logic [31 : 0] rom_o,      //Instrucciones de la rom 
//input logic [31 : 0] entrada_i,  //Salida de la ram que entra al mux 
output logic [31 : 0] pc_addr,   //Direccion de rom
output logic [31 : 0] ram_addr, //Direccion de ram
output logic [31 : 0] data_o  //Salida del registro fuente 2
    );
    

logic [31 : 0] rom_o;
logic [31 : 0] entrada_i;


logic we_reg;  
logic we_mem;
//logic [2 : 0] demuxsel;
//logic [7 : 0] we_demux;
logic [7 : 0] pc_ad;
logic [31 : 0] alu_do1;
logic [31 : 0] alu_do2;
logic [31 : 0] alu_o;
logic [31 : 0] mux_a;
logic [31 : 0] mux_b;
logic [31 : 0] data_in_i;
logic [3 : 0] alu;
logic zero;
logic muxsel1;
logic muxsel2;
logic muxsel3;
logic [1 : 0] pcsel;
logic [31 : 0] pc_pi;
logic [31 : 0] pcin_po;
logic [4 : 0] mux_imm;


logic [31:0] rs1;

logic [31:0] pc_id;
logic [31:0] instruction_id;

logic [11 : 0] mux3_o;
assign mux3_o = {instruction_id[31 : 25], mux_imm};

logic [31:0] pc_e;
logic [31:0] extend1_id;
logic [31:0] extend2_id;
logic [31:0] rs1e;
logic [31:0] rs2e;
logic [1:0] pcsel_e;
logic [4:0] rs1_e;
logic [4:0] rs2_e;
logic [4:0] rd_e;
logic [3 : 0] alu_e;
logic mux1_e;
logic mux2_e;
logic we_rege;
logic we_meme;
logic [4:0] rd_mem;
logic [31:0] data_e;

logic wemem_mem;
logic wereg_mem;
logic mux2_mem;
logic [31:0] data_mem;
logic [31:0] datamem;

logic [1:0] forward_a;
logic [1:0] forward_b;

logic lwh;
logic stall;
logic [31:0] stall_control;
logic [31:0] control_o;

logic we;
logic mux2wb;
logic [31:0] alu_wb;
logic [4:0] rdwb;
/*dist_mem_gen_0 rom (
  .a(pc_addr[12 : 2]),      // input wire [10 : 0] a        Acople para quitar los dos últimos bits.
  .spo(rom_o)  // output wire [31 : 0] spo
);

dist_mem_gen_1 ram (
  .a(ram_addr[12 : 2]),      // input wire [10 : 0] a
  .d(data_o),      // input wire [31 : 0] d
  .clk(clk_pi),  // input wire clk
  .we(we),    // input wire we
  .spo(entrada_i)  // output wire [31 : 0] spo
);*/








    
dmem RAM(
  .a(ram_addr),      // input wire [5 : 0] a
  .wd(data_mem),      // input wire [31 : 0] d
  .clk(clk_pi),  // input wire clk
  .we(wemem_mem),    // input wire we
  .rd(datamem)  // output wire [31 : 0] spo
);

imem ROM (
  .a(pc_addr),      // input wire [5 : 0] a
  .rd(rom_o)  // output wire [31 : 0] spo
);
    
    
    
mux1_pi mux1 (
.sel (mux1_e),
.a (mux_a),
.b (data_e),
.c (alu_do2)
);

mux1_pi mux2 (
.sel (mux2wb),
.a (entrada_i),
.b (alu_wb),
.c (data_in_i)
);

/*mux_p mux_3 (
.sel (ram_addr[0]),
.a (entrada_i),
.b (ram_addr),
.c (data_in_i)
);*/

mux2_pi mux_3p1 (
.sel (control_o[5]),
.i_20_24 (instruction_id[24 : 20]),
.i_7_11 (instruction_id[11 : 7]),
.imm_0_4 (mux_imm)
);


alu_pi alu_mod (
.do1 (alu_do1),
.do2 (alu_do2),
.alu_opcode (alu_e),
.zero (zero),
.alu_o (alu_o)
);

pcounter_pi pc (
.clk100mhz_i (clk_pi),
.stall       (stall),
.pc_pi (pc_pi),
.rst_pi (reset_pi),
.pc_op_pi (pcsel_e),
.pc_po (pc_addr),
.pcin_po (pcin_po)
);


regfile_pi registros (
.clk_i (clk_pi),
.rst_i (reset_pi),
.we_i (we),
.addr_rs1_i (instruction_id [19 : 15]),
.addr_rs2_i (instruction_id [24 : 20]),
.addr_rd_i (rdwb),
.data_in_i (data_in_i),
.rs1_o (rs1),
.rs2_o (data_o)
);


//demux_pi demux (
//.sel_d (demuxsel),
//.w_enable (we),
//.we_demux (we_demux)
//);

control_pi control (
.funct7 (instruction_id[31 : 25]),
.funct3 (instruction_id[14 : 12]),
.opcode (instruction_id[6 : 0]),
.alu_zero (zero),
.alu (stall_control[15:12]),
.lw  (stall_control[8]),
.pcsel (stall_control[2:1]),
.muxsel1 (stall_control[3]),
.muxsel2 (stall_control[4]),
.muxsel3 (stall_control[5]),
//.demuxsel (demuxsel),
.we_reg (stall_control[6]),
.we_mem (stall_control[7])
);


imm1_pi extend1 (
.in (mux3_o),
.out (extend1_id)
);

imm2_pi extend2 (
.in (instruction_id [11 : 7]),
.in2 (instruction_id [31 : 25]),
.out (extend2_id)
);

mux3 primero (
.a  (rs1e),
.b  (data_in_i),
.c  (ram_addr),
.sel  (forward_a),
.out3  (alu_do1)
);

mux3 segundo (
.a  (rs2e),
.b  (data_in_i),
.c  (ram_addr),
.sel  (forward_b),
.out3  (data_e)
);

forward_pi adelantamiento (
     .RS1         (rs1_e),
     .RS2         (rs2_e),
     .EX_MEM_rd   (rd_mem),
     .MEM_WB_rd   (rdwb),
     .EX_MEM_RegWrite (wereg_mem),
     .MEM_WB_RegWrite (we),
     .Forward_A       (forward_a),
     .Forward_B       (forward_b)
);

reg_if_id instr (
    .clk_i               (clk_pi),
    .rst_i               (reset_pi),
    .stall               (stall),
    .pc_if               (pc_addr),
    .instruction_if      (rom_o),
    .pc_id               (pc_id),
    .instruction_id      (instruction_id)
);

reg_id_ex ejecucion (
.clk               (clk_pi),
.reset             (reset_pi),
.rs1               (rs1),
.stall             (stall),
.rs2               (data_o),
.rs1_id            (instruction_id [19 : 15]),
.rs2_id            (instruction_id [24 : 20]),
.rd_id             (instruction_id [11 : 7]),
.in_pc_id          (pc_id),
.extend1_id        (extend1_id),
.extend2_id        (extend2_id),
.alu_id            (control_o[15:12]),
.mux1_id           (control_o[3]),
.mux2_id           (control_o[4]),
.pcsel_id          (stall_control[2:1]),
.we_regid          (control_o[6]),
.we_memid          (control_o[7]),
.lw                (control_o[8]),

.rs1e              (rs1e),
.rs2e              (rs2e),
.rs1_e             (rs1_e),
.rs2_e             (rs2_e),
.rd_e              (rd_e),
.pc_e              (pc_e),
.extend1_e         (mux_a),
.extend2_e         (pc_pi),
.alu_e             (alu_e),
.mux1_e            (mux1_e),
.mux2_e            (mux2_e),
.pcsel_e           (pcsel_e),
.we_rege           (we_rege),
.we_meme           (we_meme),
.lw_o              (lwh)
);

reg_ex_mem memory (
.clk            (clk_pi),
.rst            (reset_pi),
.aluout_e       (alu_o),
.data_e         (data_e),
.rde            (rd_e),
.mux2e          (mux2_e),
.wereg_e        (we_rege),
.wemem_e        (we_meme),

.aluout_mem     (ram_addr),
.data_mem       (data_mem),
.rd_mem         (rd_mem),
.mux2_mem       (mux2_mem),
.wereg_mem      (wereg_mem),
.wemem_mem      (wemem_mem)
);

reg_mem_wb writeback (
.clk          (clk_pi),
.rst          (reset_pi),
.alumem       (ram_addr),
.datamem      (datamem),
.rdmem        (rd_mem),
.mux2mem      (mux2_mem),
.weregmem     (wereg_mem),

.alu_wb       (alu_wb),
.data_wb      (entrada_i),
.rdwb         (rdwb),
.mux2wb       (mux2wb),
.weregwb      (we)
);


hazard_pi riesgos (
.IF_ID_RS1          (instruction_id [19 : 15]),
.IF_ID_RS2          (instruction_id [24 : 20]),
.ID_EX_rd           (rd_e),
.ID_EX_MemRead      (lwh),
.stall              (stall)
);

mux1_pi control_mux (
.sel          (stall),
.a            (stall_control), 
.b            ('0),
.c            (control_o)
);



endmodule

