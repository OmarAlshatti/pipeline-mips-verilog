`timescale 1ns / 1ps

module ControlUnit(
    input [5:0] Op,
    input [5:0] Funct,
    
    output reg RFWE,
    output reg MtoRFSel,
    output reg DMWE,
    output reg [2:0] ALUSel,
    output reg ALUInSel,
    output reg RFDSel,
    output reg Branch=1'b0,
    output reg Jump=1'b0
    );
    
always@(*)
    begin
        case(Op)
        6'b000000://ALU Operations: R-type
        begin
            RFDSel      = 1'b1; 
            RFWE        = 1'b1; 
            ALUInSel    = 1'b0; 
            DMWE        = 1'b0; 
            MtoRFSel    = 1'b0; 
            Branch      = 1'b0;
            Jump        = 1'b0;
            case (Funct)
                6'b100000: ALUSel = 3'b010;//ADD
                6'b100010: ALUSel = 3'b110;//SUB                    
                6'b100100: ALUSel = 3'b000;//AND 
                6'b100101: ALUSel = 3'b001; //OR 
                6'b000000: ALUSel = 3'b011; //SLL 
                6'b000010: ALUSel = 3'b100; //SRL
                6'b000100: ALUSel = 3'b101; //SLLV
                6'b000111: ALUSel = 3'b111; //SRAV  
                default: ALUSel = 3'bxxx;        
            endcase       
        end 
        
        //I-type Instructions
        
        6'b100011: //Load Word
        begin
            RFDSel      = 1'b0; 
            RFWE        = 1'b1;
            ALUInSel    = 1'b1; 
            ALUSel      = 3'b010; //ADD
            DMWE        = 1'b0; 
            MtoRFSel    = 1'b1; 
            Branch      = 1'b0;
            Jump        = 1'b0;
        end
            
        6'b101011://Store Word
        begin
            RFDSel      = 1'bx; //NOT REQUIRED
            RFWE        = 1'b0; 
            ALUInSel    = 1'b1; 
            ALUSel      = 3'b010; //ADD
            DMWE        = 1'b1; 
            MtoRFSel    = 1'bx; //NOT REQUIRED
            Branch      = 1'b0;
            Jump        = 1'b0;
        end
        
        6'b001000://ADDI 
        begin
            RFDSel      = 1'b0;
            RFWE        = 1'b1; 
            ALUInSel    = 1'b1; 
            ALUSel      = 3'b010; //ADD
            DMWE        = 1'b0; 
            MtoRFSel    = 1'b0; 
            Branch      = 1'b0;
            Jump        = 1'b0;
        end   
    
        6'b000100://Branch 
        begin
            RFDSel      = 1'bx;
            RFWE        = 1'b0; 
            ALUInSel    = 1'b0; 
            ALUSel      = 3'b110; //SUB
            DMWE        = 1'b0; 
            MtoRFSel    = 1'bx; 
            Branch      = 1'b1;
            Jump        = 1'b0;
        end 
        
        6'b000010://Jump
        begin
            RFDSel      = 1'bx;
            RFWE        = 1'b0; 
            ALUInSel    = 1'bx; 
            ALUSel      = 3'bxxx;
            DMWE        = 1'b0; 
            MtoRFSel    = 1'bx;
            Branch      = 1'b0;
            Jump        = 1'b1; 
        end    
                    
        default:
        begin
            RFDSel      = 1'bx; 
            RFWE        = 1'b0; 
            ALUInSel    = 1'bx;
            ALUSel      = 3'bxxx; 
            DMWE        = 1'b0; 
            MtoRFSel    = 1'bx; 
            Branch      = 1'b0;
            Jump      = 1'b0;
        end 
        endcase
    end           
endmodule
