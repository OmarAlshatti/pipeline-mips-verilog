`timescale 1ns / 1ps

module Comparator #(parameter WL=32)
    (
    input [WL-1:0] a,
    input [WL-1:0] b,
    
    output reg equal
    );
    
    always@ *
    begin
        if(a==b)
            equal = 1'b1;
        else
            equal = 1'b0;
    end
    
endmodule
