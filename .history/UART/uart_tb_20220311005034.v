`include "uart1.v"
module uart_tb;

// Parameters
localparam CMD_WIDTH  = 16    ;
localparam READ_WIDTH = 8     ;
localparam BR         = 115200;
localparam CHEAK      = 1     ;
// Ports
reg         clk       = 0;
reg         rst_n     = 0;
reg  [15:0] cmd_in       ;
reg         cmd_vld   = 0;
reg         rx        = 1;
wire        tx           ;
wire        read_rdy     ;
wire [ 7:0] read_data    ;
wire        cmd_rdy      ;

uart #(
  .CMD_WIDTH (CMD_WIDTH ),
  .READ_WIDTH(READ_WIDTH),
  .BR        (BR        ),
  .CHEAK     (CHEAK     )
) uart_dut (
  .clk      (clk      ),
  .rst_n    (rst_n    ),
  .cmd_in   (cmd_in   ),
  .cmd_vld  (cmd_vld  ),
  .rx       (rx       ),
  .tx       (tx       ),
  .read_rdy (read_rdy ),
  .read_data(read_data),
  .cmd_rdy  (cmd_rdy  )
);


initial begin
  begin
    rst_n = 1;
    cmd_vld = 0;
    rx = 1;
    #10 rst_n = 0;
    #10 rst_n = 1;
    #100000;
    $finish;
  end
end
initial begin
  wt;
  #100
    rd;
end
task wt;
  begin
    #100;
    @(posedge clk)
      begin
        cmd_in = 16'haaaa;
      end
    @(posedge clk)
      cmd_vld = 1;
    #100;
    @(posedge clk)
      cmd_vld =0;
  end
endtask

task rd;
  begin
    #100;
    @(posedge clk)
      rx = 0;
    @(posedge clk)
      rx = 1;
    @(posedge clk)
      rx = 1;
    @(posedge clk)
      rx = 1;
    @(posedge clk)
      rx = 0;
    @(posedge clk)
      rx = 1;
    @(posedge clk)
      rx = 0;
    @(posedge clk)
      rx = 1;
    @(posedge clk)
      rx = 0;
    @(posedge clk)
      rx = 1;
    @(posedge clk)
      rx = 0;
    @(posedge clk)
      rx = 1;
    @(posedge clk)
      rx = 1;
    @(posedge clk)
      rx = 1;
    @(posedge clk)
      rx = 0;
    @(posedge clk)
      rx = 1;
    @(posedge clk)
      rx = 0;
    @(posedge clk)
      rx = 1;
    @(posedge clk)
      rx = 1;
    @(posedge clk)
      rx = 0;


  end
endtask
always
  #5  clk = ! clk ;


initial
  begin
    $dumpfile("wave.vcd");        //生成的vcd文件名称
    $dumpvars;
  end
endmodule
