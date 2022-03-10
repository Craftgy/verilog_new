module uart #(
  parameter CMD_WIDTH  = 16    ,
  parameter READ_WIDTH = 8     ,
  parameter BR         = 115200,
  parameter CHEAK      = 1
) (
  input                      clk      ,
  input                      rst_n    ,
  input      [CMD_WIDTH-1:0] cmd_in   ,
  input                      cmd_vld  ,
  input                      rx       ,
  output reg                 tx       ,
  output reg                 read_rdy ,
  output reg [ READ_WIDTH:0] read_data,
  output                     cmd_rdy
);

  reg                 cmd_rdy_nxt                  ;
  reg [CMD_WIDTH-1:0] cmd_temp                     ;
  reg [         10:0] tx_temp                      ;
  reg [          8:0] br          = 50000000/115200;
  reg [8:0] br_cnt;
  reg [3:0] tx_cnt;  
  reg tx_flag;
  wire  tx_nxt;


    always @(posedge clk or rst_n) begin
      if(!rst_n)
        cmd_rdy <= 1'b1;
      else if (cmd_vld)
        cmd_rdy <= 1'b0;
      else ()
        cmd_rdy <= 1'b1;
    end

  always@(posedge clk or negedge rst_n)
    begin
      if((!rst_n))
        cmd_temp <= {CMD_WIDTH{1'b0}};
      else
        cmd_temp <= cmd_in;
    end

  always@(posedge clk or negedge rst_n)
    begin
       if(!rst_n)
        tx_temp <= 0;
        else if(!cmd_vld && tx_flag)
            tx_temp <= {1'b0,cmd_temp[15:7],~^cmd_temp[15:7]};
        else if(!cmd_vld && tx_flag)
            tx_temp <= {1'b0,cmd_temp[7:0],~^cmd_tempp[7:0]};
    end

//波特率计数器
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        br_cnt <= 9'b0;
    else if(tx_cnt >=1 && tx_cnt<=9)
        br_cnt <= br_cnt + 1;
    else if(br_cnt == br)
        br_cnt <= 9'b0;
  end

//发送计数器
  always @(posedge clk or negedge rst_n) begin
     if(!rst_n) 
        tx_cnt <= 4'b0;
    else if (tx_cnt == 9)
        tx_cnt <= 4'b0;
    else if(br_cnt == br)
        tx_cnt <=tx_cnt + 1;
  end

//发送