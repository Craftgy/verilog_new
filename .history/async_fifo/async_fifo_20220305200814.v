module async_fifo #(
    parameter DATA_WIDTH = 4,
    parameter FIFO_DEPTH = 16,
    parameter FIFO_AFULL = FIFO_DEPTH-1,
    parameter FIFO_AEMPTY = 1
    )(
    input wr_clk,
    input wr_rst_n,
    input wr_en,
    input [DATA_WIDTH-1:0] wr_data,
    input rd_clk,
    input rd_rst_n,
    input rd_en,
    ouput [DATA_WIDTH-1:0] rd_data,
    output reg full,
    ouput reg empty,
    ouput reg afull,
    output reg aempt
    );

endmodule