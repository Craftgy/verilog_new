`timescale 1ns / 1ps
`include "Rising.v"
module test;
reg clk=0;
always@*

/*iverilog */
initial
begin            
    $dumpfile("wave.vcd");        //生成的vcd文件名称
    $dumpvars(0, test);     //tb模块名称
end
/*iverilog */
endmodule