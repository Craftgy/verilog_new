



reg [4:0] fsm_cs;
reg [4:0] fsm_ns;

localparam IDLE = 4'b0; //ζ ζηΆζ
localparam RW_JUDGE          = 4'b1,
           W0_StASRT_BIT     = 4'd2,
           W0_DATA_BIT       = 4'd3,
           W0_CHECK_BIT      = 4'd4,
           W0_STOP_BIT       = 4'd5,
           W_DELAY           = 4'd6,
           W1_StASRT_BIT     = 4'd7,
           W2_DATA_BIT       = 4'd8,
           W3_CHECK_BIT      = 4'd9,
           W4_STOP_BIT       = 4'd10,
           R_CMD_START_BIT   = 4'd11,
           R_CMD_DATA_BIT    = 4'd12,
           R_CMD_CHEAK_BIT   = 4'd13,
           R_CMD_STOP_BIT    = 4'd14,
           R_DATA_START_BIT  = 4'd15,
           R_DATA_DATA_BIT   = 4'd16,
           R_DATA_CHECK_BIT  = 4'd17,
           SEND_READ_DATA    = 4'd18;
reg [CMD_WITHD-1:0] cmd_buf;
always @(posedge clk or negedge rst_n) begin
  if(!rst_n)
    fsm_cs <= IDLE;
  else fsm <=fsm_ns;
end

assign cmd_ready = fsm_cs == IDLE;

