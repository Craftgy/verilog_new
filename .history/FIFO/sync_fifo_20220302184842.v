module sync_fifo # (
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 8,
    parameter ADDR_WIDH  = 3
)(
    input  clk,
    input  rst_n,
    input  wr_en,
    input  [DATA_WIDTH-1:0] wr_data,
    input  rd_en,
    output [DATA_WIDTH-1:0] rd_data,
    output full,
    output empty
);

reg [ADDR_WIDH-1:0] wr_ptr;
reg [ADDR_WIDH-1:0] rd_ptr;
reg [ADDR_WIDH:0]   fifo_cnt;
reg [DATA_WIDTH-1:0] buf_mem [0:FIFO_DEPTH-1];

always @(posedge clk) begin
    if(wr_en) begin
      buf_mem[wr_ptr] <= wr_data;
      wr_ptr <= wr_ptr+1;
      fifo_cnt <= fifo_cnt+1;
    end 
end 

always @(posedge clk ) begin
    if(rd_en) begin
      rd_data <= buf_mem[rd_prt];
      rd_prt <= rd_ptr+1;
      fifo_cnt <= fifo_cnt-1;
    end
end

always @(posedge clk ) begin
    if(fifo_cnt == 0) begin
      empty <= 1;
      full <= 0
    end 
    else if(fifo_cnt == {(ADDR_WIDH){1'b1}}) begin
      full <= 1;
      empty <= 0
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      rd_ptr = 0;
      wr_ptr = 0;
      
    end
end
endmodule