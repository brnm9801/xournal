`timescale 1ns / 1ps


module control_pi(
input logic [6 : 0] funct7,
input logic [2 : 0] funct3,
input logic [6 : 0] opcode,
input logic alu_zero,
//input logic enable,
output logic [3 : 0] alu,
output logic lw,
output logic muxsel1,
output logic muxsel2,
output logic muxsel3,
//output logic [2 : 0] demuxsel,
output logic [1 : 0] pcsel,
output logic we_reg,
output logic we_mem
    );
    
always_comb begin 
//if (enable) begin
            muxsel1 = 0; //Selecciona salida 2 de registros
            muxsel2 = 0; //Salida de alu a registros 
            muxsel3 = 0; //Cualquier valor, es para constante
            we_reg = 0;
            we_mem = 0;
            lw = 0;
            //pcsel = 2'b00;
            //demuxsel = 3'b000;
            pcsel = 2'b10;
            alu = 4'b0000;

    case (opcode)
        7'b0110011: begin                //Instruccion tipo R
            muxsel1 = 1; //Selecciona salida 2 de registros
            muxsel2 = 1; //Salida de alu a registros 
            muxsel3 = 0; //Cualquier valor, es para constante
            we_reg = 1;
            we_mem = 0;
            //pcsel = 2'b00;
            //demuxsel = 3'b000;
            pcsel = 2'b10;  
                            
            if (funct3 == 3'b000 && funct7 == 7'b0000000)begin       //ADD
                alu = 4'b0000;
                //pcsel = 2'b10;                         
            
            end
                        
            else if (funct7 == 7'b0100000 && funct3 == 0)   //SUB 
                alu = 4'b0001;
            
            else if (funct3 == 3'b111)       //AND
                alu = 4'b1110;
                
            else if (funct3 == 3'b110)       //OR
                alu = 4'b1100;
                
            else if (funct3 == 3'b100)       //XOR
                alu = 4'b1000;
                
            else if (funct3 == 3'b010)       //SLT
                alu = 4'b0100;
                
            else if (funct3 == 3'b011)       //SLTU
                alu = 4'b0110;
                
            else if (funct3 == 3'b001)       //SLL
                alu = 4'b0010;
                
            else if (funct7 == 7'b0100000 && funct3 == 3'b101)   //SRA
                alu = 4'b1011;
                
            else if (funct3 == 3'b101)      //SRL
                alu = 4'b1010;
        end
        7'b0100011: begin  //Instruccion tipo S                             
            muxsel1 = 0;   //Seleccion sign extend
            muxsel2 = 1;   //No importa, no se escribe en regfile**********
            muxsel3 = 1;   //Selecciona bits del 7 al 11
            we_mem = 1;
            we_reg = 0;
            //demuxsel = 3'b001;  //Se escribe en ram 
            pcsel = 2'b10;
            
            if (funct3 == 3'b010) begin
                alu = 4'b0000;
                //demuxsel = 3'b001;
                //muxsel3 = 1; 
                //muxsel1 = 0;
                //we_i = 1;
                end
        end
        
        
        7'b0010011: begin                  //Instruccion tipo I
            muxsel1 = 0; //Selecciona constante
            muxsel2 = 1; //Salida de alu a entrada de registros
            muxsel3 = 0; //Selecciona bits del 20 al 31
            we_reg = 1;
            we_mem = 0;
            //demuxsel = 3'b000;
            pcsel = 2'b10;
           
           if (funct3 == 3'b000)  //ADDI
               alu = 4'b0000;
               
           else if (funct3 == 3'b111)  //ANDI
               alu = 4'b1110;
               
           else if (funct3 == 3'b110)  //ORI
               alu = 4'b1100;
               
           else if (funct3 == 3'b100)  //XORI
               alu = 4'b1000;
               
           else if (funct3 == 3'b010)  //SLTI
               alu = 4'b0100;
               
           else if (funct3 == 3'b011)  //SLTIU
               alu = 4'b0110;
               
           else if (funct3 == 3'b001)  //SLLI    REVISAR
               alu = 4'b0010;
               
           else if (funct3 == 3'b101 && funct7 == 7'b0100000)  //SRAI    REVISAR
               alu = 4'b1111;
               
           else if (funct3 == 3'b101)  //SLRI    REVISAR
               alu = 4'b1010;
               
       end
                  
        7'b0000011: begin                      //Instruccion de carga  
            muxsel1 = 0;  //Selecciona inmediato
            muxsel2 = 0;  //Carga dato de memoria al banco de registros
            muxsel3 = 0;  //Selecciona bits del 20 al 31
            we_reg = 1;
            we_mem = 0;
            lw = 1;
            //demuxsel = 3'b000;       //Registro
            pcsel = 2'b10;
           
           if (funct3 == 3'b010) begin    //LW
                alu = 4'b0000;
                //muxsel2 = 0;
                //we_i = 1;
                //demuxsel = 3'b000;             //Registro                
           end
        end
        
        7'b1100011: begin                  //Instruccion tipo B
            muxsel1 = 1; //Selecciona salida del registro
            muxsel2 = 1; //No importa porque no voy a guardar en registros********
            muxsel3 = 0; //No importa porque selecciono salida de registros, no imm
            we_reg = 0;
            we_mem = 0;
            //demuxsel = 3'b000;           
            
            if (funct3 == 3'b000)begin  //BEQ
                alu = 4'b0111;
               //pcsel = 2'b11;

                if (alu_zero == 0) //Resultado de alu diferente de 0
                    pcsel = 2'b11;
                else 
                    pcsel = 2'b10;
           end
           
           else if (funct3 == 3'b001)begin  //BNE
                alu = 4'b0111;
                if (alu_zero == 0) //Resultado de alu diferente de 0
                    pcsel = 2'b10;
                else 
                    pcsel = 2'b11;
            end   
            else if (funct3 == 3'b100)begin  //BLT
                alu = 4'b0100;
                if (alu_zero == 0) //Resultado de alu 1
                    pcsel = 2'b11;
                else 
                    pcsel = 2'b10;
                    
            end        
                    
            else if (funct3 == 3'b101)begin  //BGE
                alu = 4'b0100;
                if (alu_zero == 0) //Resultado de alu 1
                    pcsel = 2'b10;
                else 
                    pcsel = 2'b11;
            end
            
            else if (funct3 == 3'b110)begin  //BLTU
                alu = 4'b0110;
                if (alu_zero == 0)
                    pcsel = 2'b11;
                else 
                    pcsel = 2'b10;
            end        
                    
                    
            else if (funct3 == 3'b111)begin  //BGEU
                alu = 4'b0110;
                if (alu_zero == 0)
                    pcsel = 2'b10;
                else 
                    pcsel = 2'b11;
            end        
        end
        default: begin
            muxsel1 = 0; //Selecciona salida 2 de registros
            muxsel2 = 0; //Salida de alu a registros 
            muxsel3 = 0; //Cualquier valor, es para constante
            we_reg = 0;
            we_mem = 0;
            //pcsel = 2'b00;
            //demuxsel = 3'b000;
            pcsel = 2'b00;
            alu = 4'b0000;
            end
endcase 
end
//end
    
endmodule