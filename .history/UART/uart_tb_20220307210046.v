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

  uart 
  uart_dut (
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
        cmd
      $finish;
    end
  end

  always
    #5  clk = ! clk ;



endmodule
