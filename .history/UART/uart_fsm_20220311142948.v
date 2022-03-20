





localparam IDLE = 4'b0; //无效状态
localparam RW_JUDGE =4'b1,
  W0_StASRT_BIT =4'b2,
  W0_DATA_BIT =4'b3,
  W0_CHECK_BIT =4'b4,
  W0_STOP_BIT=4'b4,
  W_D