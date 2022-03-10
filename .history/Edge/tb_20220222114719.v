`timescale 1ns / 1ps
`include "Rising.v"
module test;
reg clk=0;
reg rstn,din;
wire pulse;
always #5 clk=~clk;
initial
   begin
   rstn=0;
   din=0;
   #5 rstn=1;
   #11 din=1;
   #19 din=0;
   #50 din=1;
   #10 rstn=0;
   #10 rstn=1;
   #20 din=0;
   end
Redge redge(rstn,clk,din,pulse);
/*iverilog */
initial
begin            
    $dumpfile("wave.vcd");        //生成的vcd文件名称
    $dumpvars(0, test);     //tb模块名称
    #1000 $finish;
end
/*iverilog */
endmodule