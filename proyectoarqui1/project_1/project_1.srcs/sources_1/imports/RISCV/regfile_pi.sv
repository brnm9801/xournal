`timescale 1ns / 1ps

module regfile_pi #(
    parameter ANCHO = 32,
    parameter SEL = 5 //SEL me da el 2^N registro, cada uno de un ancho ANCHO de bits
    )(
    input  logic                clk_i, //clock de 100MHz de entrada
    input  logic                rst_i, //reset
    input  logic                we_i,  //wirte enable                          
    input  logic [SEL-1:0]      addr_rs1_i, //dirección 1 salida del registro 
    input  logic [SEL-1:0]      addr_rs2_i,//dirección 2 salida del registro 
    input  logic [SEL-1:0]      addr_rd_i,  //indice de escritura
    input  logic [ANCHO-1:0]    data_in_i,    //entrada                        
    output logic [ANCHO-1:0]    rs1_o, //salida de datos
    output logic [ANCHO-1:0]    rs2_o // salida de datos
    
    );
   logic locked_o;
   
  
    integer i; 
    logic [ANCHO-1:0] [2**SEL-1:0] regfile;
    
    //MUX 1 - MUX 2
    
    always_ff @(negedge clk_i) begin
    rs1_o <= regfile[addr_rs1_i];
    rs2_o <= regfile[addr_rs2_i];
    end
    //assign regfile[0] = '0;
    
    always_ff @(posedge clk_i)
        begin
            if(rst_i)
                begin
                    for (i = 0; i < 2**SEL; i = i+1)
                        begin                                 //2**SEL cubre todos los registros
                            regfile[i] <= 0;                  //limpie todos los registros
                        end
                end
            else
                begin
                    if(we_i)
                        begin                                //si write enable esta activado
                            regfile[addr_rd_i] = data_in_i; //escribame en el registro regfile(#reg) lo que quiero escribir, osea WD_i
                        end
                end
            regfile[0] <= 0;
        end
endmodule