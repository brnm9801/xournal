`timescale 1ns / 1ps

module pcounter_pi #(
parameter W = 32                           //Parametro local para ancho de datos de entrada y salida
)(
input logic              clk100mhz_i,     // Entrada reloj 
input logic              stall, 
//output logic             en_i,            // Enable
input logic [W - 1 : 0]  pc_pi,           // Entrada datos
input logic              rst_pi,          // Reset
input logic [1 : 0]      pc_op_pi,        // Selector
output logic [W - 1 : 0] pc_po,           // Salida datos
//output logic [6 : 0]     led_po,          // Leds
output logic [W - 1 : 0] pcin_po          // Salida datos

);

//logic clk_i;                              // Reloj 10 MHz
//logic locked_o;                         


always_ff@(posedge clk100mhz_i) begin           // Ciclo para el program counter
    if (rst_pi) begin 
        pc_po = 0;
        pcin_po = 0;
    end else begin 
        //if (en_i) begin                   // Salida se activa cuando enable sea 1
            case (pc_op_pi)
                2'b00:                    // Primer modo de operaciòn
                          begin
                              pc_po   <= 0;
                              pcin_po <= 0;
                          end
                2'b01:                    // Segundo modo de operaciòn
                          begin
                              pc_po   <= pc_po;
                              pcin_po <= pcin_po;
                          end
                2'b10:                    // Tercer modo de operaciòn
                          if (stall == 0) begin
                              pc_po   <= pc_po + 4;
                              pcin_po <= 0;
                          end
                2'b11:                    // Cuarto modo de operaciòn
                          if (stall == 0) begin
                              pcin_po <= pc_po + 4;
                              pc_po   <= pc_pi + pc_po;
                          end    
                default pc_po <= 0;      
            endcase
        end
    end
//end 


endmodule