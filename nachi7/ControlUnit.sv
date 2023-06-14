///////////////////////////////////////////////////////////////////////////////
//
// Control Unit
//
// This module is a Control Unit
//
// module: Control Unit
// hdl: Verilog
//
// author: Arav Sharma <arav.sharma@cooper.edu>
// author: Lei(Raymond) Chi <lei.chi@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef ControlUnit
`define ControlUnit

//`include "MainDecoder.sv"
//`include "AluDecoder.sv"




module ControlUnit (Op, funct, zero, memToReg, memWrite, pcSource, aluSource, regDst, regWrite, jump, aluControl);
   //
   // ---------------- PORT DEFINITIONS ----------------
   //
   
   input wire [5:0] Op, funct;
   
   input wire zero;
   
   output wire memToReg, memWrite, pcSource, aluSource, regDst, regWrite, jump;
   
   output wire [2:0] aluControl;
   
   wire [1:0] aluOp;
   
   wire branch;
   //
   // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
   //
   
   
   MainDecoder mdec (.Op(Op), .regWrite(regWrite), .regDst(regDst), .aluSrc(aluSource), .branch(branch), .memWrite(memWrite), .memToReg(memToReg), .jump(jump), .aluOp(aluOp));
   
   
   AluDecoder adec (.F(funct), .Op(aluOp), .Ctrl(aluControl));
   
   and (pcSource, branch, zero);

endmodule

`endif 