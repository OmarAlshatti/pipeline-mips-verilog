`timescale 1ns / 1ps

module IE_IM_Pipe #(parameter WL=32)
    (
    input clk,
    input rst,
    input RFWEE,
    input MtoRFSelE,
    input DMWEE,
    input  [WL-1:0] AluOutE,
    input  [WL-1:0] DMdinE,
    input  [4:0] RFAE,    

    output reg RFWEM,
    output reg MtoRFSelM,
    output reg DMWEM,
    output reg [WL-1:0] AluOutM,
    output reg [WL-1:0] DMdinM,
    output reg [4:0] RFAM      
    );
    
    //Pipeline Register
    always @(posedge clk)
    begin
        if(rst)
        begin
            RFWEM <= 1'b0;
            MtoRFSelM <= 1'b0;
            DMWEM <= 1'b0;
            AluOutM <= 32'b0;
            DMdinM <= 32'b0;
            RFAM <= 5'b0;
        end
        else
        begin    
            RFWEM <= RFWEE;
            MtoRFSelM <= MtoRFSelE;
            DMWEM <= DMWEE;
            AluOutM <= AluOutE;
            DMdinM <= DMdinE;
            RFAM <= RFAE;
        end
    end
    
endmodule
