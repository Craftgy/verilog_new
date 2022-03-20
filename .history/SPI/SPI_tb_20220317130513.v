`include "SPI.v"
module SPI_tb;

  // Parameters
  localparam  CMD_WIDTH = 12;
  localparam  READ_WIDTH = 8;

  // Ports
  reg clk = 0;
  reg rst_n = 0;
  reg [ CMD_WIDTH-1:0] cmd_in;
  wire cmd_rdy;
  reg cmd_vld = 0;
  wire sclk;
  wire cs;
  wire mosi;
  reg miso = 0;
  wire read_vld;
  wire [READ_WIDTH-1:0] read_data;

  SPI 
  #(
    .CMD_WIDTH(CMD_WIDTH ),
    .READ_WIDTH (
        READ_WIDTH )
  )
  SPI_dut (
    .clk (clk ),
    .rst_n (rst_n ),
    .cmd_in (cmd_in ),
    .cmd_rdy (cmd_rdy ),
    .cmd_vld (cmd_vld ),
    .sclk (sclk ),
    .cs (cs ),
    .mosi (mosi ),
    .miso (miso ),
    .read_vld (read_vld ),
    .read_data  ( read_data)
  );

  initial begin
    begin
        #10 rst_n = 1;
        #10 rst_n = 0;
        #20 rst_n = 1;
      $finish;
    end
  end

  always
    #5  clk = ! clk ;
task wt;
begin
  
end
endtask
endmodule
