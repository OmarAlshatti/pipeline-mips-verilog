`timescale 1ns / 1ps

module MipsTopTb();

    //
    reg clk;
    reg rst;
    
    MipsTop UUT (clk,rst);
    
    always #10 clk = ~ clk;
    
    initial begin
    clk=0;
    rst=1;
    #20;
    rst=0;
    end
    
endmodule
