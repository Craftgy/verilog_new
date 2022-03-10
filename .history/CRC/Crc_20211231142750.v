module CRCCYC(Clock,Data_In,CRC_En,CRC_Clr,CRC_Out);
input Clock,CRC_En,CRC_Clr;
input [31:0] Data_In;
output reg [9:0] CRC_Out;
reg [9:0] CRC_Temp;
always @(poesdge Clock) begin
    if(CRC_Clr)
        begin
          CRC_Temp
        end
end 