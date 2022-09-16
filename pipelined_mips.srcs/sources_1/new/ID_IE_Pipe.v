`timescale 1ns / 1ps


module ID_IE_Pipe#(parameter WL=32)
    (
    input clk,
    input clr,      //flush
    input  RFWED,
    input  MtoRFSelD,
    input  DMWED,
    input  [2:0] ALUSelD,
    input  ALUInSelD,
    input  RFDSelD,
    input  [WL-1:0] DataD1,
    input  [WL-1:0] DataD2,
    input  [4:0] RsD,
    input  [4:0] RtD,
    input  [4:0] RdD,
    input  [WL-1:0] SImmD,
    input [4:0] ShamtD,    
    
    output  reg RFWEE,
    output  reg MtoRFSelE,
    output  reg DMWEE,
    output  reg [2:0] ALUSelE,
    output  reg ALUInSelE,
    output  reg RFDSelE,
    output  reg [WL-1:0] DataE1,
    output  reg [WL-1:0] DataE2,
    output  reg [4:0] RsE,
    output  reg [4:0] RtE,
    output  reg [4:0] RdE,
    output  reg [WL-1:0] SImmE,
    output  reg [4:0] ShamtE  
    );
    
    //Pipeline Regsiter
    always@(posedge clk)
    begin
    if(clr)
    begin
        RFWEE <= 1'b0;
        DMWEE <= 1'b0;
        RsE   <= 5'b0;
        RtE   <= 5'b0;
        RdE   <= 5'b0;        
    end
    else
    begin
        RFWEE <= RFWED;
        MtoRFSelE <= MtoRFSelD;
        DMWEE <= DMWED;
        ALUSelE <= ALUSelD;
        ALUInSelE <=ALUInSelD;
        RFDSelE <= RFDSelD;
        DataE1 <= DataD1;
        DataE2 <= DataD2;
        RsE   <= RsD;
        RtE   <= RtD;
        RdE   <= RdD;
        SImmE <= SImmD;
        ShamtE <= ShamtD;
    end
    end
    
endmodule
