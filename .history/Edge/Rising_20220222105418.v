module Redge(
    rstn,
    clk,
    din,
    pulse
);
input wire rstn;
input wire clk;
input wire din;
output wire pulse;
reg din_dly;

always@(posedge clk or )
    begin
        din_dly<=din;
    end  
