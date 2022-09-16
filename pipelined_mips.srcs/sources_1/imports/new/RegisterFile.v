`timescale 1ns / 1ps

module RegisterFile #(parameter WL=32, ADDRL=5)
    (
    input clk,
    input rst,
    input [ADDRL-1:0] RFRA1,
    input [ADDRL-1:0] RFRA2,
    input [ADDRL-1:0] RFWA,
    input [WL-1:0] RFWD,
    input  RFWE,
    output [WL-1:0] RFRD1,
    output [WL-1:0] RFRD2
    );
    
    //ARRAY of registers
        reg [WL-1:0] RF [0:2**ADDRL -1];
    
    integer i;
   
    //READ PORTS
    assign RFRD1 = RF[RFRA1];
    assign RFRD2 = RF[RFRA2];
    
    //WRITE PORT
    always @(negedge clk)
    begin
        if(rst) //active high reset
        begin
            for (i =0; i <=(2**ADDRL -1); i = i +1) 
            begin
                RF[i]= 0;
            end  
        end
        
        else if (RFWE)  //active high write enable
            RF[RFWA] <= RFWD;
    end

endmodule  

