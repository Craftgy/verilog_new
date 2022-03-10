module sync_fifo # (
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 8,
    parameter ADDR_WIDTH  = 3
)(
    input  clk,
    input  rst_n,
    input  wr_en,
    input  [DATA_WIDTH-1:0] wr_data,
    input  rd_en,
    output reg [DATA_WIDTH-1:0] rd_data,
    output reg full,
    output reg empty
);

reg [ADDR_WIDTH-1:0] wr_ptr;
reg [ADDR_WIDTH-1:0] rd_ptr;
reg [ADDR_WIDTH:0]   fifo_cnt;
reg [DATA_WIDTH-1:0] buf_mem [0:FIFO_DEPTH-1];

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        fifo_cnt <= {(ADDR_WIDTH){1'b0}};
        else begin
            if(rd_en && wr_en && ~full && ~empty)
                fifo_cnt <=fifo_cnt;
            else if(wr_en && ~full)
                fifo_cnt <= fifo_cnt + 1;
            else if(rd_en && ~empty)
                fifo_cnt <= fifo_cnt-1;
        end
end 

always @(posedge clk or negedge rst_n) begin
   if(!rst_n)
        wr_ptr <= {ADDR_WIDTH{1'b0}};
    else begin
      if(wr_en)
        wr
    end 
end
endmodule