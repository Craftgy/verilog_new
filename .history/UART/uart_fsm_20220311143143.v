





localparam IDLE = 4'b0; //无效状态
localparam RW_JUDGE =4'b1,
  W0_StASRT_BIT =4'b2,
  W0_DATA_BIT =4'b3,
  W0_CHECK_BIT =4'b4,
  W0_STOP_BIT=4'b4,
  W_DELAY,
  W1_StASRT_BIT =4'b2,
  W2_DATA_BIT =4'b3,
  W3_CHECK_BIT =4'b4,
  W4_STOP_BIT=4'b4,
  R_CMD_START_BIT,
  R_CMD_DATA_BIT,
  R_CMD_CHEAK_BIT;
  