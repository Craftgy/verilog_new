module sync_fifo #(
  parameter DATA_WIDTH   = 8           ,
  parameter FIFO_DEPTH   = 8           ,
  parameter AFULL_DEPTH  = FIFO_DEPTH-1,
  parameter AEMPTY_DEPTH = 1           ,
  parameter ADDR_WIDTH   = 3           ,
  parameter RDATA_MODE   = 0
        rd_data <= buf_mem[rd_ptr];
      end
    else
      always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
          rd_data <= {DATA_WIDTH{1'b0}};
        else if(rd_en && ~empty)
          rd_data <= buf_mem[rd_ptr];
      end
  endgenerate

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      overflow <= 1'b0;
    else if(wr_en && full)
      overflow <= 1'b1;
  end

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      underflow <= 1'b0;
    else if(rd_en && empty)
      underflow <= 1'b1;
  end
  assign almost_full = fifo_cnt>=AFULL_DEPTH;

  assign almost_empty = fifo_cnt<=AEMPTY_DEPTH;

  assign full = FIFO_DEPTH;

  assign empty = {(ADDR_WIDTH+1){1'b0}};

endmodule