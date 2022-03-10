module uart #
parameter CMD_WIDTH = 16,
parameter READ_WIDTH = 8,
parameter BR = 115200,
parameter CHEAK = 1
   )(
  input             clk      ,
  input             rst_n    ,
  input      [CMD_WIDTH-1:0] cmd_in   ,
  input             cmd_vld  ,
  input             rx       ,
  output reg        tx       ,
  output reg        read_rdy ,
  output reg [READ_WIDTH:0] read_data,
  output            cmd_rdy
);

reg cmd_rdy_nxt;
reg [CMD_WIDTH-1:0] cmd_temp;
reg [10:0] tx_temp;
reg [8:0] br = BR
always @(posedge clk or rst_n) begin
    if(!rst_n)
        cmd_rdy <= 1'b1;
    else if (cmd_rdy_nxt)
        cmd_rdy <= 1'b0;
    else 
        cmd_rdy_nxt <= 1'b1;
end

always@(posedge clk or negedge rst_n)
begin
    if((!rst_n))
        cmd_temp <= {CMD_WIDTH{1'b0}};
    else 
        cmd_temp <= cmd_in;
end

always @(posedge clk or negedge rst_n) begin
    
end
