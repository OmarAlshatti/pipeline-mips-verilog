`timescale 1ns / 1ps

module HazardUnit(
    input BranchD,
    input JumpD,
    input [4:0] RsD,
    input [4:0] RtD,
    input [4:0] RsE,
    input [4:0] RtE,
    input [4:0] RFAE,
    input MtoRFSelE,
    input MtoRFSelM,
    input RFWEE,
    input RFWEM,
    input [4:0] RFAM,
    input RFWEW,
    input [4:0] RFAW,
    
    output reg StallF=1'b0,
    output reg StallD=1'b0,
    output reg FlushE=1'b0,
    output reg  ForwardAD=1'b0,
    output reg  ForwardBD=1'b0,
    output reg [1:0] ForwardAE=2'b0,
    output reg [1:0] ForwardBE=2'b0
    );
    
    reg LWStall=1'b0;
    reg BranchStall=1'b0;
    
    //Data Hazard Due to Load Instruction//
    //Solution : Stall
    always@ *
     LWStall = MtoRFSelE && ((RsD==RtE) || (RtD==RtE));//
     //LWStall = 1'b0;
    //Data Hazard
    //Solution Forwarding
    //ForwardAE Multiplexer
    always@ *
    begin
        if((RsE!=0) && (RsE==RFAM) && (RFWEM==1))
            ForwardAE = 2'b10;
        else if((RsE!=0) && (RsE==RFAW) && (RFWEW==1)) 
            ForwardAE = 2'b01;
        else
            ForwardAE = 2'b00;
    end

    //ForwardBE Multiplexer
    always@ *
    begin
        if((RtE!=0) && (RtE==RFAM) && (RFWEM==1))
            ForwardBE = 2'b10;
        else if((RtE!=0) && (RtE==RFAW) && (RFWEW==1)) 
            ForwardBE = 2'b01;
        else
            ForwardBE = 2'b00;
    end 
    
    //Forwarding due to Data dependencies for Branch Instruction
     //ForwardAD Multiplexer
    always@ *
        ForwardAD = ((RsD!=0) && (RsD==RFAM) && (RFWEM==1));


    //ForwardBD Multiplexer
    always@ *
        ForwardBD = ((RtD!=0) && (RtD==RFAM) && (RFWEM==1));
    
    
    //Control Hazard: Branch STall
    always@ *
     BranchStall = (BranchD && RFWEE && ((RsD==RFAE) || (RtD==RFAE))) || (BranchD && MtoRFSelM && ((RsD==RFAM) || (RtD==RFAM)));
    
    //
    always@ *
    begin
        StallF = LWStall || BranchStall;   
        StallD = LWStall || BranchStall; 
        FlushE = LWStall || BranchStall || JumpD; 
    end
endmodule
