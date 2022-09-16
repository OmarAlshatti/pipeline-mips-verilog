`timescale 1ns / 1ps

module IF_ID_Pipe#(parameter WL=32)
   (input clk,
    input ena,      //Stall
    input clr,      //Flush
    input [WL-1:0] InstrF,
    input [WL-1:0] PCp1F,
    
    output reg[WL-1:0] InstrD,
    output reg[WL-1:0] PCp1D
    );
    
    //Regsiter
    always@(posedge clk)
    begin
        if(clr) //active high clear
        begin
            InstrD <= 32'd0;
            PCp1D <= 32'd0;
        end
        else if(!ena)   //active low enable
         begin
            InstrD <= InstrF;
            PCp1D <= PCp1F;
        end
    end
            
endmodule
