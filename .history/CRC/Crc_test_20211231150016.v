`timescale 1ns / 1ps
`include "Crc.v"
reg clk;
reg Data_in;
reg CRC_En;
reg CRC_Clr;
wire [9:0] CRC_Out;
initial begin
    clk=0;
end
forever begin
    #5 clk=~clk;
end
CRCCYC Crc()