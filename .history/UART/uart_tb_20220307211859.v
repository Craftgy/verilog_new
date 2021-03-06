`include "uart.v"
module uart_tb;

  // Parameters

  // Ports
  reg clk = 0;
  reg rst_n = 0;
  reg [15:0] cmd_in;
  reg cmd_vld = 0;
  reg rx = 0;
  wire tx;
  wire read_rdy;
  wire [7:0] read_data;
  wire cmd_rdy;

  uart uart_dut (
    .clk (clk ),
    .rst_n (rst_n ),
    .cmd_in (cmd_in ),
    .cmd_vld (cmd_vld ),
    .rx (rx ),
    .tx (tx ),
    .read_rdy (read_rdy ),
    .read_data (read_data ),
    .cmd_rdy  ( cmd_rdy)
  );
  uart uart_dut (
    .clk (clk ),
    .rst_n (rst_n ),
    .cmd_in (cmd_in ),
    .cmd_vld (cmd_vld ),
    .rx (rx ),
    .tx (tx ),
    .read_rdy (read_rdy ),
    .read_data (read_data ),
    .cmd_rdy  ( cmd_rdy)
  );

  initial begin
    begin
        rst_n = 1;
        cmd_vld = 0;
        rx = 0;
        #10 rst_n = 0;
        #10 rst_n = 1;
        #1000;
      $finish;
    end
  end
  initial begin
      wt;
  end
task wt;
begin
    #100;
    @(posedge clk)
    begin
        cmd_in = 16'ha;      
    end
    @(posedge clk)
        cmd_vld = 1;
    #10;
    @(posedge clk)
        cmd_vld =0;    
end
endtask

task rd;
begin
    #100;
    @(posedge clk)
        rx = ;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
        @(posedge clk)
        rx = tx;
end
endtask
  always
    #5  clk = ! clk ;


    initial
    begin
      $dumpfile("wave.vcd");        //?????????vcd????????????
      $dumpvars;
    end
endmodule
