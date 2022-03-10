`timescale 1ns / 1ps
`include "Crc.v"
reg clk;
reg [31:0] Data_in;
reg CRC_En;
reg CRC_Clr;
wire [9:0] CRC_Out;
initial begin
    clk=0;
    #5 CRC_En
end
forever begin
    #5 clk=~clk;
end
CRCCYC Crc()