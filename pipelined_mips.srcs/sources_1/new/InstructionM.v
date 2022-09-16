`timescale 1ns / 1ps

module InstructionM #(ADDRL=8,WL=32)
    (
    input [ADDRL-1:0] IMA, //Instruction Address
    
    output reg [WL-1:0] IMRD    //Instruction
    );
    
    //Memory Array
    reg [WL-1:0] MEM [0:2**ADDRL -1];
    
    //Initializing with Data File
    initial
    begin
        $readmemh("Imem.mem",MEM);
    end
    
    //
    always@ *
        IMRD = MEM[IMA];
        
endmodule
