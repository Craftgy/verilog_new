module sysc_fifo_tb();
module sync_fifo_tb;

  // Parameters
  localparam  DATA_WIDTH = 8;
  localparam  FIFO_DEPTH = 8;
  localparam  AFULL_DEPTH = FIFO_DEPTH-1;
  localparam  AEMPTY_DEPTH = 1;
  localparam  ADDR_WIDTH = 3;
  localparam  RDATA_MODE = 1;

  // Ports
  reg clk = 0;
  reg rst_n = 0;
  reg wr_en = 0;
  reg [DATA_WIDTH-1:0] wr_data;
  reg rd_en = 0;
  wire [DATA_WIDTH-1:0] rd_data;
  wire full;
  wire empty;
  wire almost_full;
  wire almost_empty;
  wire overflow;
  wire underflow;

  sync_fifo 
  #(
    .DATA_WIDTH(DATA_WIDTH ),
    .FIFO_DEPTH(FIFO_DEPTH ),
    .AFULL_DEPTH(AFULL_DEPTH ),
    .AEMPTY_DEPTH(AEMPTY_DEPTH ),
    .ADDR_WIDTH(ADDR_WIDTH ),
    .RDATA_MODE (RDATA_MODE )
  )
  sync_fifo_ (
    .clk (clk ),
    .rst_n (rst_n ),
    .wr_en (wr_en ),
    .wr_data (wr_data ),
    .rd_en (rd_en ),
    .rd_data (rd_data ),
    .full (full ),
    .empty (empty ),
    .almost_full (almost_full ),
    .almost_empty (almost_empty ),
    .overflow (overflow ),
    .underflow  ( underflow)
  );

  initial begin
    begin
      $finish;
    end
  end

  always
    #5  clk = ! clk ;


endmodule