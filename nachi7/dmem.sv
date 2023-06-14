

`timescale 1ns/100ps

module dmem
// n=bit length of register; r=bit length of addr to limit memory and not crash your verilog emulator
    #(parameter n = 32, parameter r = 6)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic           clk, write_enable,
    input  logic [(n-1):0] addr, writedata,
    output logic [(n-1):0] readdata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [(n-1):0] RAM[0:(2**r-1)];

    assign readdata = RAM[addr[(n-1):2]]; // word aligned (ignores lower 2 bits of address)

    always @(posedge clk) // write on posedge
        if (write_enable) RAM[addr[(n-1):2]] <= writedata;

endmodule