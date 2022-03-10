module async_fifo_tb;

  // Parameters
  localparam  DATA_WIDTH = 4;
  localparam  FIFO_DEPTH = 16;
  localparam  FIFO_AFULL = FIFO_DEPTH-1;
  localparam  FIFO_AEMPTY = 1;

  // Ports
  reg wr_clk = 0;
  reg wr_rst_n = 0;
  reg wr_en = 0;
  reg [DATA_WIDTH-1:0] wr_data;
  reg rd_clk = 0;
  reg rd_rst_n = 0;
  reg rd_en = 0;
  wire [DATA_WIDTH-1:0] rd_data;
  wire full;
  wire empty;
  wire afull;
  wire aempty;

  async_fifo 
  #(
    .DATA_WIDTH(DATA_WIDTH ),
    .FIFO_DEPTH(FIFO_DEPTH ),
    .FIFO_AFULL(FIFO_AFULL ),
    .FIFO_AEMPTY (
        FIFO_AEMPTY )
  )
  async_fifo_dut (
    .wr_clk (wr_clk ),
    .wr_rst_n (wr_rst_n ),
    .wr_en (wr_en ),
    .wr_data (wr_data ),
    .rd_clk (rd_clk ),
    .rd_rst_n (rd_rst_n ),
    .rd_en (rd_en ),
    .rd_data (rd_data ),
    .full (full ),
    .empty (empty ),
    .afull (afull ),
    .aempty  ( aempty)
  );

  initial begin
    begin
      wr_rst_n = 0;
      rd_rst_n = 0;
      #50;
      wr_rst_n = 1;
      rd_rst_n = 1;
      $finish;
    end
  end

task wr_task;
begin
    @(posedge wr_clk)
        begin
            wr_en <= 1;
            wr_data <= 8'ha;
        end
        @(posedge wr_clk)
        begin
            wr_en <= 1;
            wr_data <= 8'hb;
        end
        @(posedge wr_clk)
        begin
            wr_en <= 1;
            wr_data <= 8'hc;
        end
        @(posedge wr_clk)
        begin
            wr_en <= 1;
            wr_data <= 8'hd;
        end
        @(posedge wr_clk)
        begin
            wr_en <= 1;
            wr_data <= 8'he;
        end
        @(posedge wr_clk)
        begin
            wr_en <= 1;
            wr_data <= 8'hf;
        end
        @(posedge wr_clk)
        begin
            wr_en <= 0;
        end
        @(posedge wr_clk)
        begin
            wr_en <= 1;
            wr_data <= 8'hg;
        end
        @(posedge wr_clk)
        begin
            wr_en <= 0;
        end
end
endtask
task rd_task;
begin
    @(posedge rd_clk)
        rd_en
end


  always
    #5  wr_clk = ! wr_clk ;
  always
    #10  rd_clk = ! rd_clk ;

    /*iverilog */
initial
begin
  $dumpfile("wave.vcd");        //生成的vcd文件名称
  $dumpvars;
end
endmodule
