module uart (
    input clk,
    input rst_n,
    input [15:0] cmd_in,
    input cmd_vld,
    input rx,
    output reg tx,
    output reg read_rdy,
    output [7:0] read_data,
    output  cmd_rdy
);
    reg rx1;
    reg rx2;
    wire cb_nxt1;
    wire cb_nxt2;
    reg cb1;
    reg cb2;
    reg read_vld_temp;
    reg [21:0] tx_nxt;
    reg [21:0] rx_nxt;
    // 奇校验位
    assign cb_nxt1 = ~^cmd_in[7:0];
    assign cb_nxt2 = ~^cmd_in[15:8];
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
        begin
            cb2 <= 1'b0;
            cb1 <= 1'b0;
        end
        else 
        begin
            cb2 <= cb_nxt2;
            cb1 <= cb_nxt1;
        end
    end
  
    //处理数据
   always @(posedge clk or negedge rst_n) begin
       if(!rst_n)
            tx_nxt <= 22'b0;
        else if(cmd_vld)
            tx_nxt <= {1'b0,cmd_in[15:8],cb_nxt2,1'b1,1'b0,cmd_in[7:0],cb_nxt1,1'b1};
   end
   //发送数据
   reg [4:0] count;
   reg cmd_ready_nxt;
   assign cmd_rdy = cmd_ready_nxt;
   always @(posedge clk or negedge rst_n) begin
       if(!rst_n)
        cmd_ready_nxt <= 1'b1;
        else if(cmd_vld)
        cmd_ready_nxt <= 1'b0;
   end

   always @(posedge clk or negedge rst_n) begin
       if(!rst_n)
        count <= 4'b0;
       else if(!cmd_rdy)
            begin
                if(count == 22)
                begin
                    cmd_ready_nxt <= 1'b1;
                    count <= 4'b0;
                end
             else
            count <= count + 1'b1;
        end
    end
    
   always @(posedge clk or negedge rst_n) begin
      if(!rst_n)
            tx <= 1'b1;
      else if(!read_rdy)
            begin
            tx_nxt <= {tx_nxt[14:0],tx_nxt[15]};
            tx <= tx_nxt;
            end
   end

//读数据
   always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            rx=1'b1;
        else 
            begin
            rx1 <= rx;
            rx2 <= rx2;
            end
   end
reg rx_temp;
reg [3:0] rx_count;
   always @(posedge clk or negedge rst_n ) begin
        if(!rst_n)
        begin
            rx_temp <= 1'b0;
            rx_count <= 4'b0;
        end
        else if(!rx2 && (rx_count != 11))
            begin
            rx_temp <= 1'b1;
            rx_count <= rx_count+1;
            end
        else if(rx_count ==11)
            rx_count <= 4'b0;
    end
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            rx_nxt <= 22'b0;
        else if(rx_temp)
            begin
            rx_nxt[21] <= rx2;
            rx_nxt <= {rx[20:0],rx[21]};
            end     
    end
    reg rbx1;
    reg rbx2;
    assign rbx1 = ~^rx_nxt[20:13];
    assign rbx2 = ~^rx_nxt[:]
    always @(posedge clk or negedge rst_n) begin
       if(!rst_n)
            read_data <= 8'b0;
        else if 
    end
endmodule