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

localparam IDLE     = 4'd0,
           JUDGE    = 4'd1,
           W_START  = 4'd2,
           W_DATA   = 4'd3,
           W_FINISH = 4'd4,
           R_START  = 4'd5,
           WR_DATA  = 4'd6,
           RR_DATA  = 4'd7, 
           R_FINISH = 4'd8;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        fsm_cs <= IDLE;
    else
        fsm_cs <= fsm_ns;
end

always @(*) begin
    case(fsm_ns)
        IDLE    :
        begin
            if(work_en)
                fsm_ns = JUDGE;
          
        end  
        JUDGE   
        W_START 
        W_DATA  
        W_FINISH
        R_START 
        WR_DATA 
        RR_DATA 
R_FINISH
        IDLE    
JUDGE   
W_START 
W_DATA  
W_FINISH
R_START 
WR_DATA 
RR_DATA 
R_FINISH
        IDLE    
JUDGE   
W_START 
W_DATA  
W_FINISH
R_START 
WR_DATA 
RR_DATA 
R_FINISH
        IDLE    
JUDGE   
W_START 
W_DATA  
W_FINISH
R_START 
WR_DATA 
RR_DATA 
R_FINISH
        IDLE    
JUDGE   
W_START 
W_DATA  
W_FINISH
R_START 
WR_DATA 
RR_DATA 
R_FINISH
        IDLE    
JUDGE   
W_START 
W_DATA  
W_FINISH
R_START 
WR_DATA 
RR_DATA 
R_FINISH
    endcase
end



endmodule