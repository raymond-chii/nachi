//`include "dataMemory.sv"
//`include "imem.sv"
//`include "MIPSprocessor.sv"
//`include "dmem.sv"

///////////////////////////////////////////////////////////////////////////////
//
// mips single cycle
//
// This module is a mips single cycle
//
// module: mips single cycle
// hdl: Verilog
//
// author: Arav Sharma <arav.sharma@cooper.edu>
// author: Lei(Raymond) Chi <lei.chi@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module testbench();

    logic clk; 
    logic reset;
    wire [31:0] writedata, dataadr; 
    wire memwrite;

    top dut (.clk(clk), .reset(reset), .writedata(writedata), .dataadr(dataadr), .memwrite(memwrite));



    // initial 

    // $monitor("writedata=%d, dataadr=%d, memwrite=%d",writedata, dataadr, memwrite);

    initial begin
        reset <= 1; #22;
        reset <= 0; #22;
    end

    always begin
        clk <= 1; #5;
        clk <= 0; #5;
    end
	
	initial
    begin
        $dumpfile("waveForm.vcd");
        
        $dumpvars(1, dut);
    end

        
    always @(negedge clk) begin
        if (memwrite) begin
            if (dataadr == 84 && writedata == 7) begin 
                $stop;
            end else if (dataadr != 80) begin 
                $stop;
            end 
        end
    end 
endmodule

module top (input wire clk, reset,
            output wire [31:0] writedata, dataadr,
            output wire memwrite ); 
        
        
        wire [31:0] pc, instr, readdata;

    MIPSprocessor mips(clk, reset, pc, instr, memwrite, dataadr,writedata, readdata); 
    imem imem(pc[7:2], instr);
    //dataMemory dmem(rest, clk, memwrite, dataadr, writedata, readdata); 
    dmem dmem(clk, memwrite, dataadr, writedata, readdata); 



endmodule