module SPI #(
  parameter CMD_WIDTH  = 12,
  parameter READ_WIDTH = 8
) (
  input                   clk      ,
  input                   rst_n    ,
  input  [ CMD_WIDTH-1:0] cmd_in   ,
  output                  cmd_rdy  ,
  input                   cmd_vld  ,
  output                  sclk     ,
  output                  cs       ,
  output                  mosi     ,
  input                   miso     ,
  output                  read_vld ,
  output [READ_WIDTH-1:0] read_data
);
reg [3:0] fsm_cs;
reg [3:0] fsm_ns;
reg [CMD_WIDTH-1:0] buff;
wire work_en;
wire start_en;
reg [3:0] w_cnt;
localparam IDLE     = 4'd0,
           START    = 4'd1
           JUDGE    = 4'd2,
           W_START  = 4'd3,
           W_DATA   = 4'd4,
           W_FINISH = 4'd5,
           R_START  = 4'd6,
           WR_DATA  = 4'd7,
           RR_DATA  = 4'd8, 
           R_FINISH = 4'd9;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        fsm_cs <= IDLE;
    else
        fsm_cs <= fsm_ns;
end

assign work_en = cmd_vld;

always @(*) begin
    case(fsm_ns)
        IDLE    :
        begin
            if(work_en)
                fsm_ns = JUDGE;
            else
                fsm_ns = IDLE;
        end  
        START   :
        begin
            if(cmd_vld)
                fsm_ns = JUDGE;
            else
                fsm_ns = START;
        end 
        JUDGE   :
        begin
            if(buff[11] == 1)
                fsm_ns = W_START;
            else if(buff[11] == 0)
                fsm_ns = R_START;
            else
                fsm_ns = JUDGE;
        end
        W_START :
        begin
            if(start_en)
                fsm_ns = W_DATA;
            else
                fsm_ns = start_en;
        end
        W_DATA  :
        begin
            if(w_cnt == 1'b11)
                fsm_ns = W_FINISH;
            else
                fsm_ns = W_DATA;
        end
        W_FINISH :
        begin
            if()
        end
        R_START 
        WR_DATA 
        RR_DATA 

    endcase
end



endmodule