`timescale 1ns / 1ps

module Fetch  #(parameter WL=32, ADDRL=8)
    (
    input clk,
    input rst,
    input PCSel,
    input Jump,
    input PCen,
    input [WL-1:0] PCBranch,
    input [WL-1:0] PCJump,
    
    output [WL-1:0] Instr,
    output [WL-1:0] PCp1F
    );
    
    wire [WL-1:0] PC_p1F_branch;
    wire [WL-1:0] PC;
    wire [WL-1:0] PCF;
    
    //Instantiating Sub-Modules
    
    //Branch Address Multiplexer
    Multiplexer2x1 #(.WL(WL)) F_Branch (.a(PCp1F), .b(PCBranch), .sel(PCSel), .out(PC_p1F_branch));

    //Jump Address Multiplexer
    Multiplexer2x1 #(.WL(WL)) F_Jump (.a(PC_p1F_branch), .b(PCJump), .sel(Jump), .out(PC));    
    
    //Program Counter
    ProgramCounter #(.WL(WL)) F_PC(.clk(clk), .rst(rst), .en(PCen), .PC(PC), .PCF(PCF));
    
    //Adder PC+1
    Adder #(.WL(WL)) F_ADD(.a(PCF), .b(32'd1), .sum(PCp1F));
    
    //Instruction Memory
    InstructionM #(.ADDRL(ADDRL),.WL(WL)) F_IM (.IMA(PCF[ADDRL-1:0]), .IMRD(Instr));
    
endmodule
