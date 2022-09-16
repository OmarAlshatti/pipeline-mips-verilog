`timescale 1ns / 1ps

module IM_IW_Pipe #(parameter WL=32)
    (
    input clk,
    input rst,
    input RFWEM,
    input MtoRFSelM,
    input [WL-1:0] DMOutM,
    input [WL-1:0] AluOutM,
    input [4:0] RFAM,

    output reg RFWEW,
    output reg MtoRFSelW,
    output reg [WL-1:0] DMOutW,
    output reg [WL-1:0] AluOutW,
    output reg [4:0] RFAW        
    
    );
    
        //Pipeline Register
    always @(posedge clk)
    begin
        if(rst)
        begin
            RFWEW <= 1'b0;
            MtoRFSelW <= 1'b0;
            DMOutW <= 32'b0;
            AluOutW <= 32'b0;
            RFAW <= 5'b0;
        end
        else
        begin    
            RFWEW <= RFWEM;
            MtoRFSelW <= MtoRFSelM;
            DMOutW <= DMOutM;
            AluOutW <= AluOutM;
            RFAW <= RFAM;
        end    
    end
    
endmodule
