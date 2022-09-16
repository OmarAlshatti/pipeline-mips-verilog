`timescale 1ns / 1ps

module MipsTop #(parameter WL=32, ADDRL=8)//ADDRL, Depth of Memories kept = 256(0 to 255)
    (
    input clk,
    input rst
    );
    
    //Interconnection
    wire PCSelD,JumpD,BranchD;
    
    wire [WL-1:0] PCBranchD,PCJumpD,InstrF,PCp1F;
    
    wire [WL-1:0] InstrD,PCp1D;
    
    wire  StallF, StallD, FlushE;
    
    wire [WL-1:0] ResultW,AluOutM,AluOutW,AluOutE;
    
    wire [4:0] RFAE,RFAM,RFAW;
    
    wire RFWED,MtoRFSelD,DMWED,ALUInSelD,RFDSelD;
    wire [2:0] ALUSelD;

    wire RFWEE,MtoRFSelE,DMWEE,ALUInSelE,RFDSelE;
    wire [2:0] ALUSelE;
    
    wire RFWEM,MtoRFSelM,DMWEM;
    
    wire RFWEW,MtoRFSelW;
    
    wire [4:0] RsD,RtD,RdD;
    wire [4:0] RsE,RtE,RdE;
    wire [4:0] ShamtE;
    
    wire [WL-1:0] DMdinE,DMdinM;
    wire [WL-1:0] SImmD, SImmE;
    
    wire [1:0] ForwardAE, ForwardBE;
    wire  ForwardAD, ForwardBD; 
    
    wire [WL-1:0] DataD1,DataD2,DataE1,DataE2;
    wire [WL-1:0] DMOutM,DMOutW;    
    
    //Instantiations
    //Fetch Stage
    Fetch #(.WL(WL),.ADDRL(ADDRL)) F
    (.clk(clk),
     .rst(rst),
     .PCSel(PCSelD),
     .Jump(JumpD),
     .PCen(StallF),
     .PCBranch(PCBranchD),
     .PCJump(PCJumpD),
     .Instr(InstrF),
     .PCp1F(PCp1F)
     );  
     
    //Fetch-Decode Pipeline
    IF_ID_Pipe #(.WL(WL)) IF_ID
    (.clk(clk),
     .ena(StallD),
     .clr(PCSelD | JumpD |rst),
     .InstrF(InstrF),
     .PCp1F(PCp1F),
     .InstrD(InstrD),
     .PCp1D(PCp1D)
    );
    
    //Decode Stage
    Decode #(.WL(WL)) D
    (.clk(clk),
     .rst(rst),
     .InstrD(InstrD),
     .PCp1D(PCp1D),
     .ResultW(ResultW),
     .AluOutM(AluOutM),
     .RFAW(RFAW),
     .RFWEW(RFWEW),
     .ForwardAD(ForwardAD),
     .ForwardBD(ForwardBD),
     .RFWED(RFWED),
     .MtoRFSelD(MtoRFSelD),
     .DMWED(DMWED),
     .ALUSelD(ALUSelD),
     .ALUInSelD(ALUInSelD),
     .RFDSelD(RFDSelD),
     .JumpD(JumpD),
     .PCSelD(PCSelD),
     .BranchD(BranchD),
     .DataD1(DataD1),
     .DataD2(DataD2),
     .RsD(RsD),
     .RtD(RtD),
     .RdD(RdD),
     .SImmD(SImmD),
     .PCBranchD(PCBranchD),
     .PCJumpD(PCJumpD)
     );     

    //Decode-Execute Pipeline
    ID_IE_Pipe #(.WL(WL)) ID_IE
    (.clk(clk),
     .clr(FlushE|rst), 
     .RFWED(RFWED),
     .MtoRFSelD(MtoRFSelD),
     .DMWED(DMWED),
     .ALUSelD(ALUSelD),
     .ALUInSelD(ALUInSelD),
     .RFDSelD(RFDSelD),
     .DataD1(DataD1),
     .DataD2(DataD2),
     .RsD(RsD),
     .RtD(RtD),
     .RdD(RdD), 
     .SImmD(SImmD),
     .ShamtD(InstrD[10:6]), //shift amount  
     .RFWEE(RFWEE),
     .MtoRFSelE(MtoRFSelE),
     .DMWEE(DMWEE),
     .ALUSelE(ALUSelE),
     .ALUInSelE(ALUInSelE),
     .RFDSelE(RFDSelE),
     .DataE1(DataE1),
     .DataE2(DataE2),
     .RsE(RsE),
     .RtE(RtE),
     .RdE(RdE), 
     .SImmE(SImmE),
     .ShamtE(ShamtE)
     );                    

    //Execute Stage
    Execute #(.WL(WL)) E
    (
     .ALUSelE(ALUSelE),
     .ALUInSelE(ALUInSelE),
     .RFDSelE(RFDSelE),
     .DataE1(DataE1),
     .DataE2(DataE2), 
     //.RsE(RsE),
     .RtE(RtE),
     .RdE(RdE), 
     .SImmE(SImmE),
     .ShamtE(ShamtE),
     .ResultW(ResultW),
     .AluOutM(AluOutM),
     .ForwardAE(ForwardAE),
     .ForwardBE(ForwardBE),  
     .AluOutE(AluOutE),
     .DMdinE(DMdinE),
     .RFAE(RFAE)
     );

    //Execute-Memory Pipeline
    IE_IM_Pipe #(.WL(WL)) IE_IM
    (.clk(clk),
     .rst(rst),
     .RFWEE(RFWEE),
     .MtoRFSelE(MtoRFSelE),
     .DMWEE(DMWEE),     
     .AluOutE(AluOutE),
     .DMdinE(DMdinE),
     .RFAE(RFAE),
     .RFWEM(RFWEM),
     .MtoRFSelM(MtoRFSelM),
     .DMWEM(DMWEM),      
     .AluOutM(AluOutM),
     .DMdinM(DMdinM),
     .RFAM(RFAM)
     );
     
     //Memory Stage
     DataM #(.ADDRL(ADDRL),.WL(WL)) M
    (.clk(clk),
     .DMWE(DMWEM),
     .DMRA(AluOutM[ADDRL-1:0]),
     .DMWD(DMdinM),
     .DMRD(DMOutM)
     );
          
    //Memory-Writeback Pipeline
     IM_IW_Pipe #(.WL(WL)) IM_IW
     (.clk(clk),
      .rst(rst),
     .RFWEM(RFWEM),
     .MtoRFSelM(MtoRFSelM), 
     .DMOutM(DMOutM),
     .AluOutM(AluOutM),
     .RFAM(RFAM),
     .RFWEW(RFWEW),
     .MtoRFSelW(MtoRFSelW), 
     .DMOutW(DMOutW),
     .AluOutW(AluOutW),
     .RFAW(RFAW)
     );

     //Write Back Stage     
     WriteBack #(.WL(WL)) WB 
     (.MtoRFSelW(MtoRFSelW), 
      .DMOutW(DMOutW),
      .AluOutW(AluOutW),  
      .ResultW(ResultW)
      );
      
      //Hazard Unit
      HazardUnit H
      (.BranchD(BranchD),
       .JumpD(JumpD),
       .RsD(RsD),
       .RtD(RtD),
       .RsE(RsE),
       .RtE(RtE),
       .RFAE(RFAE),
       .MtoRFSelE(MtoRFSelE),
       .MtoRFSelM(MtoRFSelM),
       .RFWEE(RFWEE),
       .RFWEM(RFWEM),
       .RFAM(RFAM),
       .RFWEW(RFWEW),
       .RFAW(RFAW),
       .StallF(StallF),
       .StallD(StallD),
       .FlushE(FlushE),
       .ForwardAE(ForwardAE),
       .ForwardBE(ForwardBE),
       .ForwardAD(ForwardAD),
       .ForwardBD(ForwardBD)
       );
              
                                    
endmodule
