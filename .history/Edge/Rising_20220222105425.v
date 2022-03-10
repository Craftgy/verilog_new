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

always@(posedge clk or negedge )
    begin
        din_dly<=din;
    end  
