`timescale 1ns / 1ps
`include "Crc.v"
reg clk;
reg Data_in;
reg CRC_En;
reg CRC_Clr;


initial begin
    clk=0;
end
forever begin
    #5 clk=~clk;
end
CRCCYC Crc()