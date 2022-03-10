module uart (
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
always @(posedge clk or rst_n) begin
    if(!rst_n)
        cmd_rdy <= 1'b1;
    else if (cmd_rdy_nxt)
end