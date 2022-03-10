`timescale 1ns / 1ps
`include "Crc.v"
module test();
reg clk;
reg [31:0] Data_In;
reg CRC_En;
reg CRC_Clr;
wire [9:0] CRC_Out;
initial begin
    clk=0;
    Data_In=32'b1100_0001_0001_1111_1100_0001_1111_0101;
    #5 CRC_En=0;
       CRC_Clr=1;
    #10 CRC
    #100 CRC_En=1;
    #1000 $finish;
end
always #5 clk=~clk;
CRCCYC Crc(.Clock(clk),
        .Data_In(Data_In),
        .CRC_En(CRC_En),
        .CRC_Clr(CRC_Clr),
        .CRC_Out(CRC_Out));

/*iverilog */
initial
begin            
    $dumpfile("wave.vcd");        //生成的vcd文件名称
    $dumpvars(0, test);     //tb模块名称
end
/*iverilog */
endmodule