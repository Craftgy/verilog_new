module CRCCYC(Clock,Data_In,CRC_En,CRC_Clr,CRC_Out);
input Clock,CRC_En,CRC_Clr;
input [31:0] Data_In;
output reg [9:0] CrC_Out;

always @(poesdge Clock or negedge CRC_En) begin
    
end 