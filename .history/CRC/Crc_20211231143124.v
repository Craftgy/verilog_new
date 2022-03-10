module CRCCYC(Clock,Data_In,CRC_En,CRC_Clr,CRC_Out);
input Clock,CRC_En,CRC_Clr;
input [31:0] Data_In;
output reg [9:0] CRC_Out;
reg [9:0] CRC_Temp;
reg crcfb;
always @(poesdge Clock) begin
    if(CRC_Clr)
        begin
          CRC_Temp<=0;
        end
    else if(CRC_En)
        begin
          for(i=31;i>=0;i--)
        end 
end 