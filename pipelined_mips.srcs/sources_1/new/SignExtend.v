`timescale 1ns / 1ps

module SignExtend#(parameter IMMsize=16, WL=32)
    (
    input  [IMMsize-1:0] Imm,
    output reg [WL-1:0] SEImm
    );
    
    always@ *
    
        //Using Replication Operator
        //MSB of Imm is replicated by IMMsize
        SEImm = {{IMMsize{Imm[IMMsize-1]}},Imm};
endmodule
