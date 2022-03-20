module uart #(
  parameter CMD_WIDTH  = 16    ,
  parameter READ_WIDTH = 8     ,
  parameter BR         = 434   ,
) (
  input                       clk      ,
  input                       rst_n    ,
  input      [ CMD_WIDTH-1:0] cmd_in   ,
  input                       cmd_vld  ,
  input                       rx       ,
  output reg                  tx       ,
  output                      read_rdy ,
  output     [READ_WIDTH-1:0] read_data,
  output reg                  cmd_rdy
);

reg [4:0]           fsm_cs ;
reg [4:0]           fsm_ns ;
reg [CMD_WITHD-1:0] cmd_buf;
wire cmd_ready;
localparam IDLE              = 4'b0, //无效状态
           RW_JUDGE          = 4'b1,
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



always @(posedge clk or negedge rst_n) begin
  if(!rst_n)
    fsm_cs <= IDLE;
  else 
    fsm_cs <=fsm_ns;
end

assign cmd_ready = fsm_cs == IDLE;

always @(*) begin
case:
  RW_JUDGE:if(cmd_ready)        
  W0_StASRT_BIT   
  W0_DATA_BIT     
  W0_CHECK_BIT    
  W0_STOP_BIT     
  W_DELAY         
  W1_StASRT_BIT   
  W2_DATA_BIT     
  W3_CHECK_BIT    
  W4_STOP_BIT     
  R_CMD_START_BIT 
  R_CMD_DATA_BIT  
  R_CMD_CHEAK_BIT 
  R_CMD_STOP_BIT  
  R_DATA_START_BIT
  R_DATA_DATA_BIT 
  R_DATA_CHECK_BIT
  SEND_READ_DATA  
end