`timescale 1ns / 1ps

module Execute #(parameter WL=32)
    (
     input  [2:0] ALUSelE,
     input  ALUInSelE,
     input  RFDSelE,
     input  [WL-1:0] DataE1,
     input  [WL-1:0] DataE2,
     //input  [4:0] RsE,
     input  [4:0] RtE,
     input  [4:0] RdE,
     input  [4:0] ShamtE,
     input  [WL-1:0] SImmE,
     input  [WL-1:0] ResultW,
     input  [WL-1:0] AluOutM,     
     input  [1:0] ForwardAE,
     input  [1:0] ForwardBE,
      
     output  [WL-1:0] AluOutE,
     output  [WL-1:0] DMdinE,
     output  [4:0] RFAE     
        
    );
    
    wire [WL-1:0] AluInAE;
    wire [WL-1:0] AluInBE;
    
 //Instantiating Sub-Modules
//ForwardAE Multiplexer
     Multiplexer4x1 #(.WL(WL)) E_MA (.a(DataE1), .b(ResultW), .c(AluOutM), .d(), .sel(ForwardAE), .out(AluInAE));
//ForwardBE Multiplexer
     Multiplexer4x1 #(.WL(WL)) E_MB (.a(DataE2), .b(ResultW), .c(AluOutM), .d(), .sel(ForwardBE), .out(DMdinE));     
//ALU Source B Multiplexer
     Multiplexer2x1 #(.WL(WL)) E_MALU (.a(DMdinE), .b(SImmE), .sel(ALUInSelE), .out(AluInBE));  
//RF Destination Address Multiplexer
     Multiplexer2x1 #(.WL(5)) E_MRFA (.a(RtE), .b(RdE), .sel(RFDSelE), .out(RFAE));  
//ALU
    Alu #(.WL(WL)) E_ALU (.a(AluInAE), .b(AluInBE), .ShamtE(ShamtE), .AluControl(ALUSelE), .AluOut(AluOutE));     
                  
endmodule
