module Redge(
    clk,
    din,
    pulse
);
input wire clk;
input wire din;
output wire pulse;
reg din_dly;

always@(pose)