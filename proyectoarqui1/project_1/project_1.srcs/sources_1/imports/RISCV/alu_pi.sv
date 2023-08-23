`timescale 1ns / 1ps


module alu_pi (
    input logic  [31:0]      do1, //Entrada a
    input logic  [31:0]      do2,//Entrada b
    input logic  [3:0]       alu_opcode,  //seleccion
    output logic zero,
    output logic [31:0]       alu_o //salida
    );
    
    always_comb begin
    alu_o = 0;
        case(alu_opcode)
            // La selección parte de 10 para que ningún dato que ingrese corresponda a un operando
             4'b0000: alu_o = do1 + do2; //ADD
             
             4'b0001: alu_o = do1 - do2; //SUB
             
             4'b0010: alu_o = do1 << do2; // SLL
             
             4'b0100: if (signed'(do1) < signed'(do2)) //SLT
                          alu_o = 1;
                      else 
                          alu_o = 0;
                          
             4'b0110: if (unsigned'(do1) < unsigned'(do2))   //SLTU
                          alu_o = 1;
                      else 
                          alu_o = 0;
             4'b0111: if (do1 == do2)  //SEQ
                          alu_o = 1;
                      else 
                          alu_o = 0;
                              
             4'b1000: alu_o = do1 ^ do2;  //XOR
             
             4'b1010: alu_o = do1 >> do2; //SRL
             
             4'b1011: alu_o = do1 >>> do2;//SRA
             
             4'b1100: alu_o = do1 | do2; //OR
             
             4'b1110: alu_o = do1 & do2; //AND
             
             4'b1111: alu_o = do1 >>> do2[4 : 0]; //SRAI
             
             default: alu_o = 0;
        endcase   
        
        if (alu_o == 0)
            zero = 1;
        else 
            zero = 0;
                     
    end
    
endmodule
