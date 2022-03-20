module SPI #(
  parameter CMD_WIDTH  = 12,
  parameter READ_WIDTH = 8
) (
  input                   clk      ,
  input                   rst_n    ,
  input  [ CMD_WIDTH-1:0] cmd_in   ,
  output      reg         cmd_rdy  ,
  input                   cmd_vld  ,
  output      reg            sclk     ,
  output      reg            cs       ,
  output      reg            mosi     ,
  input                   miso     ,
  output       reg           read_vld ,
  output [READ_WIDTH-1:0] read_data
);
reg [3:0] fsm_cs;
reg [3:0] fsm_ns;
reg [CMD_WIDTH-1:0] buff;
wire work_en;
wire w_start_en;
wire w_start_down;
reg [3:0] w_cnt;
reg [3:0] r_cnt;
wire r_start_en;
wire r_start_down;
reg [3:0] clk_cnt;
reg [7:0] dly_cnt;
reg [7:0] data_buf;
localparam IDLE     = 4'd0,
           START    = 4'd1,
           JUDGE    = 4'd2,
           W_START  = 4'd3,
           W_DATA   = 4'd4,
           W_FINISH = 4'd5,
           R_START  = 4'd6,
           WR_DATA  = 4'd7,
           R_DELAY  = 4'd8,
           RR_DATA  = 4'd9, 
           R_FINISH = 4'd10;
// localparam DATA_WIDTH = 1,
//            FIFO_DEPTH = 8,
//            FIFO_AFULL = 1,
//            FIFO_AEMPTY = 1;
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
            if(w_start_en)
                fsm_ns = W_DATA;
            else
                fsm_ns = W_START;
        end
        W_DATA  :
        begin
            if(w_cnt == 4'd12)
                fsm_ns = W_FINISH;
            else
                fsm_ns = W_DATA;
        end
        W_FINISH :
        begin
            if(w_start_down)
                fsm_ns = IDLE;
            else
                fsm_ns = W_FINISH;
        end
        R_START :
        begin
            if(r_start_en)
                fsm_ns = WR_DATA;
            else
                fsm_ns = R_START;
        end
        WR_DATA :
        begin
            if(r_cnt == 4'd4)
                fsm_ns = R_DELAY;
            else
                fsm_ns = WR_DATA;
        end
        R_DELAY :
        begin
            if(dly_cnt == 8'd100)
                fsm_ns = RR_DATA;
            else
                fsm_ns = R_DELAY;
        end
        RR_DATA :
        begin
            if(r_cnt == 4'd8)
                fsm_ns = R_FINISH;
            else
                fsm_ns = RR_DATA;
        end
        R_FINISH :
        begin
          if(r_start_down)
            fsm_ns = IDLE;
        else
            fsm_ns = R_FINISH;
        end
        default:
            fsm_ns = IDLE;
    endcase
end

assign w_start_en = buff[15] && cmd_rdy;
assign w_start_down = w_cnt == 4'd12;
assign r_start_en = ~buff[15] && cmd_rdy;
assign r_start_down = w_cnt == 4'd8;
always @(posedge clk or negedge rst_n) begin
    case (fsm_cs)
        IDLE   :
            begin
              w_cnt <= 4'b0;
            end 
        START  :
            begin
              buff <= cmd_in;
            end
        JUDGE  :
            begin
              cmd_rdy <= 1'b0;  
            end
        W_START :
            ;
        W_DATA  :
        begin
            cs <= 1'b0;
            if(clk_cnt == 4'd8)  
              begin
                w_cnt <= w_cnt + 1'b1;
                mosi <= buff[w_cnt];
                clk_cnt <= 4'd0; 
                sclk <= ~sclk;
              end
            else if(clk_cnt == 4'd4)
              sclk <= ~sclk;
            else 
              begin
              clk_cnt <= clk_cnt + 1'b1;
              mosi <= buff[w_cnt];
              end
          end
        W_FINISH  :
        begin
          cs <= 1'b1;
          cmd_rdy = 1'b1;
          mosi <= 1'b0;
        end
        R_START   :
            rbuff
        WR_DATA   :
        begin
            cs <= 1'b0;
            if(clk_cnt == 4'd8)  
              begin
                r_cnt <= r_cnt + 1'b1;
                mosi <= buff[w_cnt];
                clk_cnt <= 4'd0; 
                sclk <= ~sclk;
              end
            else if(clk_cnt == 4'd4)
              sclk <= ~sclk;
            else 
              begin
              clk_cnt <= clk_cnt + 1'b1;
              mosi <= buff[w_cnt];
              end
          end
        R_DELAY:
        begin
            cs <= 1'b1;
            mosi <= 1'b0;
            dly_cnt = dly_cnt + 1'b1;
        end
        RR_DATA   :
          begin
            cs <= 1'b0;
            read_vld <= 1'b1;
            if(clk_cnt == 4'd8)  
              begin
                r_cnt <= r_cnt + 1'b1;
                data_buf <= {data_buf[6:0],miso};
                clk_cnt <= 4'd0; 
                sclk <= ~sclk;
              end
            else if(clk_cnt == 4'd4)
              sclk <= ~sclk;
            else 
              begin
              clk_cnt <= clk_cnt + 1'b1;
              end
          end
        R_FINISH:
          begin
            read_vld = 1'b0;
            cmd_rdy = 1'b1;
          end
    endcase
    
end


endmodule