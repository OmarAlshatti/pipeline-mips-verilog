`timescale 1ns / 1ps

module Multiplexer2x1 #(parameter WL=32)
    (
    input [WL-1:0] a,
    input [WL-1:0] b,
    input sel,
    
    output reg [WL-1:0] out
    );
    
    //
    always@ *
    begin
        if(sel)     //sel==1
            out = b;
        else        //sel==0
            out = a;
    end
        
endmodule
