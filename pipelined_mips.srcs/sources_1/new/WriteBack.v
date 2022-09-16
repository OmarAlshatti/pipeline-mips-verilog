`timescale 1ns / 1ps

module WriteBack #(parameter WL=32)
    (
     input [WL-1:0] AluOutW,
     input [WL-1:0] DMOutW,
     input MtoRFSelW,
     
     output [WL-1:0] ResultW
    );

//Write back Multiplexer
//Selects between ALU Out and  Data Memory out
    Multiplexer2x1 #(.WL(WL)) W_M (.a(AluOutW), .b(DMOutW), .sel(MtoRFSelW), .out(ResultW));
    
        
endmodule
