module sync_fifo # (
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 8,
    parameter ADDR_WIDH  = 3
)(
    input clk,
    input rst_n,
    input wr_en,
    input [DATA_WIDTH-1:0] wr_data [0:FIFO_DEPTH-1],
    input rd_en,
    output [DATA_WIDTH-1:0] wr_data [0:FIFO_DEPTH-1];
    output full,
    output empty,
);

reg [ADDR_WIDH-1:0] wr_ptr;
reg [ADDR_WIDH-1:0] rd_ptr;
reg fifo_cnt
    
endmodule