`timescale 1ns / 1ps
`include "Crc.v"
/*iverilog */
initial
begin            
    $dumpfile("wave.vcd");        //生成的vcd文件名称
    $dumpvars(0, test);     //tb模块名称
end
/*iverilog */
endmodule