module Redge(
    clk,
    din,
    pulse
);
input wire clk;
input wire din;
output wire pulse;
reg din_dly;

always@(posedge clk)
    begin
        din_dly<=din;
    end
