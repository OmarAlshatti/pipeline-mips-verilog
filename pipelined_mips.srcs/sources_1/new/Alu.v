`timescale 1ns / 1ps

module Alu #(parameter WL=32)
    (
    input [WL-1:0] a,
    //input [4:0] RsE,
    input [4:0] ShamtE,
    input [WL-1:0] b,
    input [2:0] AluControl,
    
    output reg [WL-1:0] AluOut
    );
    
    always@ *
    begin
        case (AluControl)
            3'b000://AND
            begin
                AluOut = a & b;
            end
            
            3'b001://OR
            begin
                AluOut = a | b;
            end
            
             3'b010://Add
            begin
                AluOut = a + b;
            end
            
            3'b011://SLL
            begin
                AluOut = b << ShamtE;
            end    
            
            3'b100://SRL
            begin
                AluOut = b >> ShamtE;
            end  

            3'b101://SLLV
            begin
                AluOut = b << a;
            end

            3'b110://Sub
            begin
                AluOut = a - b;
            end            

            3'b111://SRAV
            begin
                AluOut = b >>> a;
            end 
                                     
        endcase
    end
endmodule
