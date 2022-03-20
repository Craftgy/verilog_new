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


//第一段
always @(posedge clk or negedge rst_n) begin
  if(!rst_n)
    fsm_cs <= IDLE;
  else 
    fsm_cs <=fsm_ns;
end

assign cmd_ready = fsm_cs == IDLE;
//第二段状态转换
always @(*) begin 
case(fsm_cs):
            IDLE:
                    begin
                      if(cmd_ready)
                        fsm_ns = RW_JUDGE;
                      else
                        fsm_ns = IDLE;
                    end
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
                       if(check_flag == 1'b1)
                        fsm_ns = IDEL;
                       else
                          fsm_ns = IDEL; 
                     end
            default:
                     fsm_ns = IDEL;
endcase
end
//第三段输出
always @(posedge clk or negedge rst_n) begin
  case(fsm_ns):   
              IDEL:
                          begin
                            cmd_buf <= {CMD_WIDTH{1'b0}};
                            tx_cnt <= 4'b0;
                            rx_cnt <= 4'b0;
                            check_flag <= 1'b0;
                            br_cnt_1 <= 9'b0;
                            br_cnt_2 <= 9'b0;

                            tx <= 1'b1;
                            read_data <= 8'b0;
                            cmd_rdy <= 1'b0;
                            read_rdy <= 1'b0;
                          end      
              RW_JUDGE:    
                              cmd_buf <= cmd_in;
              W0_START_BIT  :
                            begin
                              if(br_cnt_1)
                                
                            end
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
              SEND_READ_DATA         
end
