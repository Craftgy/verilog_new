



reg [4:0] fsm_cs;
reg [4:0] fsm_ns;

localparam IDLE = 4'b0; //ζ ζηΆζ
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
  R_CMD_STOP_BIT,
  R_DATA_START_BIT,
  R_DATA_DATA_BIT,
  R_DATA_CHECK_BIT
  SEND_READ_DATA;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        fsm_cs <= IDLE;
    else fsm <=fsm_ns;
end

always @(*) begin
    case(fsm_cs)
    IDLE:
        begin
            if(cmd_valid)
                fsm_ns = RW_JUDGE;
            else  
        end
    RW_JUDGE =4'b1,
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
      R_CMD_STOP_BIT,
      R_DATA_START_BIT,
      R_DATA_DATA_BIT,
      R_DATA_CHECK_BIT
      SEND_READ_DATA;
end
  