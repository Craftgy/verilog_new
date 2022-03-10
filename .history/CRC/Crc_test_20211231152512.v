`timescale 1ns / 1ps
`include "Crc.v"
reg clk;
reg [31:0] Data_in;
reg CRC_En;
reg CRC_Clr;
wire [9:0] CRC_Out;
initial begin
    clk=0;
    Data_in=32'b1100_0001_0001_1111_1100_0001_1111_0101;
    #5 CRC_En=0；
       CRC_Clr=1；
    #5 CRC_En=1；
end
forever begin
    #5 clk=~clk;
end
CRCCYC Crc(.Clock(clk),
        .Data_In(Data_In),
        .)