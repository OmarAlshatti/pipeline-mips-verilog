`timescale 1ns / 1ps

module ProgramCounter #(parameter WL=32)
    (
    input clk,
    input rst,
    input en,
    input [WL-1:0] PC,
    
    output reg [WL-1:0] PCF
    );

    // Register
    always@(posedge clk)
    begin
        if(rst)         //active-high reset
            PCF <= 32'd0;
        else if(!en)    //active-low enable
            PCF <= PC;
    end
    
endmodule
