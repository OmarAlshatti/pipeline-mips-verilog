`timescale 1ns / 1ps

module DataM #(ADDRL=8,WL=32)
    (
    input clk,
    input DMWE,
    input [ADDRL-1:0]DMRA,
    input [WL-1:0] DMWD,
    
    output [WL-1:0] DMRD
    );
    

    //Memory Array
    reg [WL-1:0] MEM [0:2**ADDRL -1];
    
    //Initializing with Data File
    initial
    begin
        MEM[0] = 17;
    MEM[1] = 31;
    MEM[2] = -5;
    MEM[3] = -2;
    MEM[4] = 250;
    end
        
        
    // READ PORT
    assign DMRD = MEM[DMRA];
    
    //WRITE PORT
    always @(posedge clk)
    begin
    if (DMWE)        //active high write enable
        MEM[DMRA] <= DMWD;
    end    
endmodule
