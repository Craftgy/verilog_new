`timescale 1ns / 1ps
`include "Crc.v"
reg clk;
initial begin
    clk=0;
end
forever begin
    #5 clk=~clk;
end
