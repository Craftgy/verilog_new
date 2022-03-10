module CRCCYC(Clock,Data_In,CRC_En,CRC_Clr,CRC_Out);
input Clock,CRC_En,CRC_Clr;
input [31:0] Data_In;
output [9:0] CRC_Out;
reg [9:0] CRC_Temp;
reg crcfb;
integer i;
always @(posedge Clock) begin
    if(CRC_Clr)
        begin
          CRC_Temp=0;
        end
    else if(CRC_En)
        begin
          for(i=31;i>=0;i=i-1)
          begin
            crcfb = CRC_Temp[9];
            CRC_Temp[9] = CRC_Temp[8]^crcfb;
            CRC_Temp[8] = CRC_Temp[7];
            CRC_Temp[7] = CRC_Temp[6];
            CRC_Temp[6] = CRC_Temp[5];
            CRC_Temp[5] = CRC_Temp[4]^crcfb;
            CRC_Temp[4] = CRC_Temp[3]^crcfb;
            CRC_Temp[3] = CRC_Temp[2];
            CRC_Temp[2] = CRC_Temp[1];
            CRC_Temp[1] = CRC_Temp[0]^crcfb;
            CRC_Temp[0] = Data_In[i]^crcfb;
          end
        end 
end 
assign CRC_Out = CRC_Temp;
endmodule
