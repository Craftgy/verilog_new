module SPI #(
  parameter CMD_WIDTH  = 12,
  parameter READ_WIDTH = 8
) (
  input                   clk      ,
  input                   rst_n    ,
  input  [ CMD_WIDTH-1:0] cmd_in   ,
  output                  cmd_rdy  ,
  input                   cmd_vld  ,
  output                  sclk     ,
  output                  cs       ,
  output                  mosi     ,
  input                   miso     ,
  output                  read_vld ,
  output [READ_WIDTH-1:0] read_data
);
reg [3:0] fsm_cs;
reg [3:0] fsm_ns;

localparam IDLE     = 4'd0,
           START    = 4'd1,
           W_DATA   = 4'd2,
           WR_DATA  = 4'd3,
           RR_DATA  = 4'd4, 
           W_FINISH = 4'd5,
           R_FINISH = 4'd6;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        fsm_cs < 
end



endmodule