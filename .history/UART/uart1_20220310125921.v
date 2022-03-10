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

alw