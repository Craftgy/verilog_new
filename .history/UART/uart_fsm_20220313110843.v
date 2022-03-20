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
wire                cmd_ready;
reg [8:0] br_cnt_1;
reg [3:0] tx_cnt;
reg [3:0] rx_cnt; 
wire check_flag;

localparam IDLE              = 4'b0, //无效状态
           RW_JUDGE          = 4'b1,
           W0_START_BIT      = 4'd2,
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
           SEND_READ_DATA    = 4'd15;



always @(posedge clk or negedge rst_n) begin
  if(!rst_n)
    fsm_cs <= IDLE;
  else 
    fsm_cs <=fsm_ns;
end

assign cmd_ready = fsm_cs == IDLE;
assign cmd_buf = cmd_in;
always @(*) begin
case(fsm_ns):
            RW_JUDGE:
                    begin
                      if(cmd_buf[15] == 1'b1)
                      fsm_ns = W0_START_BIT;
                      else if(cmd_buf[15] == 1'b0)
                      fsm_ns = R_DATA_START_BIT;
                      else 
                      fsm_ns = IDLE;
                    end        
            W0_START_BIT :
                    begin
                      if(tx_cnt == 4'd1)
                        fsm_ns = W0_DATA_BIT;
                      else 
                        fsm_ns = W0_DATA_BIT;
                    end  
            W0_DATA_BIT :
                    begin
                      if(tx_cnt == 4'd9)
                        fsm_ns = W0_CHECK_BIT;
                      else
                        fsm_ns = W0_DATA_BIT;
                    end
            W0_CHECK_BIT:
                    begin
                      if(tx_cnt == 4'd10)
                        fsm_ns = W0_STOP_BIT;
                      else
                        fsm_ns = W0_CHECK_BIT;
                    end
            W0_STOP_BIT:
                    begin
                      if(tx_cnt == 4'd11)
                        fsm_ns = W_DELAY;
                      else
                        fsm_ns = W0_STOP_BIT;
                    end
            W_DELAY:
                     begin
                       if(w_dly == 4'd15)
                         fsm_ns = W1_START_BIT;
                        else
                          fsm_ns = W_DELAY;
                     end
             W1_START_BIT :
                     begin
                       if(tx_cnt == 4'd1)
                         fsm_ns = W0_DATA_BIT;
                       else 
                         fsm_ns = W0_DATA_BIT;
                     end  
             W1_DATA_BIT :
                    begin
                      if(tx_cnt == 4'd9)
                        fsm_ns = W0_CHECK_BIT;
                      else
                        fsm_ns = W0_DATA_BIT;
                    end
             W1_CHECK_BIT:
                    begin
                      if(tx_cnt == 4'd10)
                        fsm_ns = W0_STOP_BIT;
                      else
                        fsm_ns = W0_CHECK_BIT;
                     end
             W1_STOP_BIT:
                     begin
                       if(tx_cnt == 4'd11)
                         fsm_ns = IDLE;
                       else
                         fsm_ns = W1_STOP_BIT;
                     end    
            R_CMD_START_BIT:
                     begin
                       if(rx_cnt == 4'd1)
                         fsm_ns = R_CMD_DATABIT;
                       else 
                         fsm_ns = R_CMD_START_BIT;
                     end
            R_CMD_DATA_BIT:
                     begin
                        if(rx_cnt == 4'd9)  
                          fsm_ns = R_CMD_CHEAK_BIT;
                        else
                          fsm_ns = R_CMD_DATA_BIT;
                     end     
            R_CMD_CHEAK_BIT :
                     begin
                       if(rx_cnt == 4'd10)
                        fsm_ns = R_CMD_STOP_BIT;
                       else
                        fsm_ns = R_CMD_CHEAK_BIT;
                     end
            R_CMD_STOP_BIT  :
                     begin
                       if(rx_cnt == 4'b11)
                        fsm_ns = SEND_READ_DATA;
                       else
                        fsm_ns = R_CMD_STOP_BIT;
                     end
            SEND_READ_DATA  :
                     begin
                       if(C)
                     end
end