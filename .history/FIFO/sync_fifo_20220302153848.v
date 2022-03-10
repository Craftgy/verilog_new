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
    output [DATA_WIDTH-1:0] wr_data;
    output full,
    output empty,
);

reg [ADDR_WIDH-1:0] wr_ptr;
reg [ADDR_WIDH-1:0] rd_ptr;
reg [ADDR_WIDH:0]   fifo_cnt;
reg [DATA_WIDTH-1:0] buf_mem [0:FIFO_DEPTH-1];

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      wr_data = {[1'b0}
    end 
end 
    
endmodule