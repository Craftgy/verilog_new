module uart #(
  parameter CMD_WIDTH  = 16    ,
  parameter READ_WIDTH = 8     ,
  parameter BR         = 115200,
  parameter CHEAK      = 1
) (
  input                       clk      ,
  input                       rst_n    ,
  input      [ CMD_WIDTH-1:0] cmd_in   ,
  input                       cmd_vld  ,
  input                       rx       ,
  output reg                  tx       ,
  output                   read_rdy ,
  output     [READ_WIDTH-1:0] read_data,
  output reg                  cmd_rdy
);

  reg                  cmd_rdy_nxt      ;
  reg  [CMD_WIDTH-1:0] cmd_temp         ;
  reg  [         10:0] tx_temp          ;
  reg  [          8:0] br          = 434;
  reg  [          8:0] br_cnt           ;
  reg  [          3:0] tx_cnt           ;
  reg                  tx_flag          ;
  wire                 tx_nxt           ;
  wire                 work_down        ;
  reg                  work_en          ;
  wire                 tx_cnt_en        ;
  wire                 rw_flag          ;
  assign rw_flag = cmd_temp[CMD_WIDTH-1];
//开始信号
  assign work_down = (~rw_flag||tx_flag) && br_cnt ==br && tx_cnt == 10;
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      work_en <= 1'b0;
    else if(work_down)
      work_en <= 1'b0;
    else if(cmd_vld)
      work_en <= 1'b1;
  end
//握手信号
  always @(posedge clk or rst_n) begin
    if(!rst_n)
      cmd_rdy <= 1'b1;
    else if (cmd_vld)
      cmd_rdy <= 1'b0;
    else if(work_down)
      cmd_rdy <= 1'b1;
  end
//暂存数据
  always@(posedge clk or negedge rst_n)
    begin
      if((!rst_n))
        cmd_temp <= {CMD_WIDTH{1'b0}};
      else if(cmd_vld && cmd_rdy)
        cmd_temp <= cmd_in;
    end
//数据分配
  always@(posedge clk or negedge rst_n)
    begin
      if(!rst_n)
        tx_temp <= 0;
      else if(!cmd_vld && !tx_flag)
        tx_temp <= {1'b0,cmd_temp[15:8],~^cmd_temp[15:7],1'b0};
      else if(!cmd_vld && tx_flag)
        tx_temp <= {1'b0,cmd_temp[7:0],~^cmd_temp[7:0],1'b0};
    end

//波特率计数器
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      br_cnt <= 9'b0;
    else if(br_cnt == br)
      br_cnt <= 9'b0;
    else if(work_en && tx_cnt<=10)
      br_cnt <= br_cnt + 1;

  end

//发送计数器
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      tx_cnt <= 4'b0;
    else if (tx_cnt == 11)
      tx_cnt <= 4'b0;
    else if(br_cnt == br)
      tx_cnt <= tx_cnt + 1;
  end

//发送标记
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      tx_flag <= 0;
    else if(tx_cnt == 10 && rw_flag && br_cnt==br)
      tx_flag <= ~tx_flag;
  end

//发送
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      tx <= 0;
    else if(tx_cnt>=1)
      if(br_cnt)
        tx <= tx_temp[10-tx_cnt];
    else if(tx_cnt == 0)
      tx <= 1'b0;
  end

  reg  [2:0] rx_dly      ;
  wire       nedge_rx    ;
  reg        rx_work_en  ;
  reg  [7:0] rx_data_buf ;
  wire       rx_sync     ;
  wire       check_finish;
  reg        rx_work_done;
  reg   [3:0]     rx_cnt      ;
  reg  [8:0]      br_cnt2     ;
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      rx_dly <= 3'b0;
    else
      rx_dly <= {rx_dly[1:0],rx};
  end

  assign nedge_rx = rx_dly[2:1] == 2'b01;

  assign rx_sync  = rx_dly[2];

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      rx_work_en <= 1'b0;
    else if(rx_work_done)
      rx_work_en <= 1'b0;
    else if(nedge_rx)
      rx_work_en <= 1'b1;
  end

//波特率计数器
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      br_cnt2 <= 9'b0;
      else if(br_cnt2 == br)
        br_cnt2 <= 9'b0;
    else if(rx_work_en && rx_cnt<=11)
      br_cnt2 <= br_cnt2 + 1;
    
  end

//发送计数器
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      rx_cnt <= 4'b0;
    else if (rx_cnt == 11)
      rx_cnt <= 4'b0;
    else if(br_cnt == br)
      rx_cnt <= rx_cnt + 1;
  end


  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      rx_data_buf <= 8'b0;
    else if (br_cnt2)
      if((rx_cnt<9) && br_cnt2 == br/2)
        rx_data_buf <= {rx_data_buf[6:0],rx_sync};
  end

  assign work_down = br_cnt2 == br && 

  assign check_finish = br_cnt2==br/2 && rx_cnt==4'd9 && rx_sync==~^rx_data_buf;

  assign read_rdy = check_finish;

  assign read_data = rx_data_buf ;
endmodule