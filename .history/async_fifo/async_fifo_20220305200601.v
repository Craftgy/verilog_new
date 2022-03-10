module async_fifo #(
    parameter DATA_WIDTH = 4,
    parameter FIFO_DEPTH = 16,
    parameter FIFO_AFULL = FIFO_DEPTH-1,
    parameter FIFO_AEMPTY = 1
    )(
    input wr_clk,
    input wr_rst_n,
    input wr_en
    );

endmodule