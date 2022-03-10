`include "sync_fifo.v"
module sync_fifo_tb ();
// Parameters
localparam DATA_WIDTH   = 8           ;
localparam FIFO_DEPTH   = 8           ;
localparam AFULL_DEPTH  = FIFO_DEPTH-1;
localparam AEMPTY_DEPTH = 1           ;
localparam ADDR_WIDTH   = 3           ;
localparam RDATA_MODE   = 1           ;

// Ports
reg                   clk          = 0;
reg                   rst_n        = 0;
reg                   wr_en        = 0;
reg  [DATA_WIDTH-1:0] wr_data         ;
reg                   rd_en        = 0;
wire [DATA_WIDTH-1:0] rd_data         ;
wire                  full            ;
wire                  empty           ;
wire                  almost_full     ;
wire                  almost_empty    ;
wire                  overflow        ;
wire                  underflow       ;

sync_fifo #(
  .DATA_WIDTH  (DATA_WIDTH  ),
  .FIFO_DEPTH  (FIFO_DEPTH  ),
  .AFULL_DEPTH (AFULL_DEPTH ),
  .AEMPTY_DEPTH(AEMPTY_DEPTH),
  .ADDR_WIDTH  (ADDR_WIDTH  ),
  .RDATA_MODE  (RDATA_MODE  )
) sync_fifo_out (
  .clk         (clk         ),
  .rst_n       (rst_n       ),
  .wr_en       (wr_en       ),
  .wr_data     (wr_data     ),
  .rd_en       (rd_en       ),
  .rd_data     (rd_data     ),
  .full        (full        ),
  .empty       (empty       ),
  .almost_full (almost_full ),
  .almost_empty(almost_empty),
  .overflow    (overflow    ),
  .underflow   (underflow   )
);

initial begin
  begin
    #5 rst_n=1;
    wr_data =0;
    wr_en=0;
    rd_en=0;
    #100 rst_n=0;
    #200;
    rst_n=1;
    #5000
      $finish;
  end
end
initial begin
  #500;
  send_wr;
  #500;
  send_rd;
end

always #5  clk = ~clk ;

task  send_wr;
  begin
    @(posedge clk)
      begin
        wr_en<=1'b1;
        wr_data=8'ha5;
      end
    @(posedge clk)
      begin
        wr_en<=1'b1;
        wr_data<=8'ha6;
      end
    @(posedge clk)
      begin
        wr_en<=1'b1;
        wr_data<=8'ha7;
      end
    @(posedge clk)
      begin
        wr_en<=1'b1;
        wr_data<=8'h;
      end
  end
endtask

task send_rd;
  begin
    @(posedge clk)
      begin
        rd_en<=1'b1;
      end
    @(posedge clk)
      begin
        rd_en<=1'b1;
      end
    @(posedge clk)
      begin
        rd_en<=1'b0;
      end
    @(posedge clk)
      begin
        rd_en<=1'b1;
      end
  end
endtask

/*iverilog */
initial
  begin
    $dumpfile("wave.vcd");        //生成的vcd文件名称
    $dumpvars;
  end

endmodule