module uart #
parameter CMD_WIDTH = 16,
parameter BR = 
   )(
  input             clk      ,
  input             rst_n    ,
  input      [15:0] cmd_in   ,
  input             cmd_vld  ,
  input             rx       ,
  output reg        tx       ,
  output reg        read_rdy ,
  output reg [ 7:0] read_data,
  output            cmd_rdy
);

reg cmd_rdy_nxt;
reg 
always @(posedge clk or rst_n) begin
    if(!rst_n)
        cmd_rdy <= 1'b1;
    else if (cmd_rdy_nxt)
        cmd_rdy <= 1'b0;
    else 
        cmd_rdy_nxt <= 1'b1;
end

