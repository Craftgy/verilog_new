module sync_fifo # (
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 8,
    parameter AFULL_DEPTH = FIFO_DEPTH-1,
    parameter AEMPTY_DEPTH = 1,
    parameter ADDR_WIDTH  = 3,
    parameter RDATA_MODE = 1
)(
    input  clk,
    input  rst_n,
    input  wr_en,
    input  [DATA_WIDTH-1:0] wr_data,
    input  rd_en,
    output reg [DATA_WIDTH-1:0] rd_data,
    output  full,
    output  empty,
    output almost_full,
    output almost_empty,
    output overflow,
    output underflow
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
        if(wr_ptr==FIFO_DEPTH-1)
            wr_ptr <= {ADDR_WIDTH{1'b0}};
      else if(wr_en && ~full)
            wr_ptr <= wr_ptr + 1'b1;
    end 
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
         rd_ptr <= {ADDR_WIDTH{1'b0}};
     else begin
         if(rd_ptr==FIFO_DEPTH-1)
             rd_ptr <= {ADDR_WIDTH{1'b0}};
       else if(rd_en && ~empty)
             rd_ptr <= rd_ptr + 1'b1;
     end 
 end

 integer II;    

 always @(posedge clk or negedge rst_n) begin
     if(!rst_n)
        for(II=0;II<FIFO_DEPTH;II=II+1)
            buf_mem[II] <= {DATA_WIDTH{1'b0}};
        else if(wr_en && ~full)
            buf_mem[wr_ptr] <= wr_data;
 end
generate
    if(RDATA_MODE == 1)
        always @(*) begin
            rd_data <= buf_mem[rd_ptr];
        end
    else
        always @(posedge clk or negedge rst_n) begin
            if(!rst_n)
                 rd_data <= {DATA_WIDTH{1'b0}};
            else if(rd_en && ~empty)
                rd_data <= buf_mem[rd_ptr];
        end
endgenerate

always @(posedge clk or negedge nst_n) begin
    if(!rst_n)
        overflow <=1'b0;
    else if(wr_en && full)
        overflow <= 1'b1; 
end

always @(posedge clk or negedge nst_n) begin
    if(!rst_n)
        underflow <=1'b0;
    else if(rd_en && full)
        underlow <= 1'b1; 
end
 assign almost_full = fifo_cnt>AFULL_DEPTH;
 assign almost_empty = fifo_cnt<AEMPTY_DEPTH;
 assign full = FIFO_DEPTH;

 assign empty = {(ADDR_WIDTH+1){1'b0}};

endmodule