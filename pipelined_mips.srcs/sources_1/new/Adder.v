`timescale 1ns / 1ps

module Adder #(parameter WL=32)
    (
    input [WL-1:0] a,
    input [WL-1:0] b,
    
    output reg [WL-1:0] sum
    );
    
    always@ *
    begin
        sum = a + b;
    end
    
endmodule
