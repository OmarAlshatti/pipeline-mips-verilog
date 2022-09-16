`timescale 1ns / 1ps

module Decode #(parameter WL=32)
    (
    input clk,
    input rst,
    input [WL-1:0] InstrD,
    input [WL-1:0] PCp1D,
    input [WL-1:0] ResultW,
    input [WL-1:0] AluOutM,
    input [4:0] RFAW,
    input RFWEW,
    input ForwardAD,
    input ForwardBD,
    
    output  RFWED,
    output  MtoRFSelD,
    output  DMWED,
    output  [2:0] ALUSelD,
    output  ALUInSelD,
    output  RFDSelD,
    output  JumpD,
    output  PCSelD,
    output  BranchD,
    output  [WL-1:0] DataD1,
    output  [WL-1:0] DataD2,
    output  [4:0] RsD,
    output  [4:0] RtD,
    output  [4:0] RdD,
    output  [WL-1:0] SImmD,   
    output  [WL-1:0] PCBranchD ,
    output  [WL-1:0] PCJumpD  
    );
    
    wire [WL-1:0] RFRD1;
    wire [WL-1:0] RFRD2;
    wire [WL-1:0] BranchRD1;
    wire [WL-1:0] BranchRD2;
    
    wire EqualD;
    
 //Instantiating Sub-Modules
 //Register File
    RegisterFile #(.WL(32)) D_RF
    (.clk(clk),
     .rst(rst),
     .RFRA1(InstrD[25:21]), //Rs
     .RFRA2(InstrD[20:16]), //Rt
     .RFWA(RFAW),           //Destination Address
     .RFWD(ResultW),
     .RFWE(RFWEW),
     .RFRD1(RFRD1),
     .RFRD2(RFRD2)     
    ); 

//ForwardAD Multiplexer
    Multiplexer2x1 #(.WL(WL)) D_MA (.a(RFRD1), .b(AluOutM), .sel(ForwardAD), .out(BranchRD1));   
    
//ForwardBD Multiplexer
    Multiplexer2x1 #(.WL(WL)) D_MB (.a(RFRD2), .b(AluOutM), .sel(ForwardBD), .out(BranchRD2));  
    
//Comparartor: Equal to
    Comparator #(.WL(WL)) D_CMP (.a(BranchRD1), .b(BranchRD2), .equal(EqualD));  
    
//Sign Extender
    SignExtend #(.IMMsize(16),.WL(WL)) D_SIMM (.Imm(InstrD[15:0]), .SEImm(SImmD));     
    
//Branch Address : Adder 
    Adder #(.WL(WL)) D_ADD(.a(SImmD), .b(PCp1D), .sum(PCBranchD));  
    
//Control Unit
    ControlUnit D_CU
    (.Op(InstrD[31:26]),
     .Funct(InstrD[5:0]),
     .RFWE(RFWED),
     .MtoRFSel(MtoRFSelD),
     .DMWE(DMWED),
     .ALUSel(ALUSelD),
     .ALUInSel(ALUInSelD),
     .RFDSel(RFDSelD),
     .Branch(BranchD),
     .Jump(JumpD)
     );

//Logic for branch Prediction
    assign PCSelD = BranchD & EqualD;
    
//Jump Address
    assign PCJumpD = {PCp1D[31:28],InstrD[25:0]};

//
    assign RsD = InstrD[25:21];
    assign RtD = InstrD[20:16];
    assign RdD = InstrD[15:11];
    assign DataD1 = RFRD1;
    assign DataD2 = RFRD2;
    
    
                                 
endmodule
