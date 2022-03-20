module SPI #(
    parameter CMD_WIDTH = 12,
    parameter READ_WIDTH = 8
) (
    input clk,
    input rst_n,
    input [CMD_WIDTH-1:0] cmd_in,
    output cmd_rdy,
    input cmd_vld,
    output sclk,
    output cs,
    output mosi,
    input miso,
    read_vld,
    
);
    
endmodule