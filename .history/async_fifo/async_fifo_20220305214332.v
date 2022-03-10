module async_fifo #(
  parameter DATA_WIDTH  = 4           ,
  parameter FIFO_DEPTH  = 16          ,
  parameter FIFO_AFULL  = FIFO_DEPTH-1,
  parameter FIFO_AEMPTY = 1
) (
  input                       wr_clk  ,
  input                       wr_rst_n,
  input                       wr_en   ,
  input      [DATA_WIDTH-1:0] wr_data ,
  input                       rd_clk  ,
  input                       rd_rst_n,
  input                       rd_en   ,
  ouput                       rd_data ,
  output reg                  full    ,
  ouput  reg                  empty   ,
  ouput  reg                  afull   ,
  output reg                  aempty
);

localparam ADDR_WIDTH = $clog2(FIFO_DEPTH); //位宽

reg [ADDR_WIDTH:0] rd_addr;
reg [ADDR_WIDTH:0] rd_addr_nxt;

reg [ADDR_WIDTH:0] wr_addr;
reg [ADDR_WIDTH:0] wr_addr_nxt;

wire [ADDR_WIDTH:0] wr_addr_gray_nxt;
reg  [ADDR_WIDTH:0] wr_addr_gray;
reg  [ADDR_WIDTH:0] wr_addr_gray_rsyn1;
reg  [ADDR_WIDTH:0] wr_addr_gray_rsyn2;
wire [ADDR_WIDTH:0] wr_addr_gray_rsyn;

wire [ADDR_WIDTH:0] rd_addr_gray_nxt;
reg  [ADDR_WIDTH:0] rd_addr_gray;
reg  [ADDR_WIDTH:0] rd_addr_gray_wsyn1;
reg  [ADDR_WIDTH:0] rd_addr_gray_wsyn2;
wire [ADDR_WIDTH:0] rd_addr_gray_wsyn;

wire [ADDR_WIDTH:0] rd_addr_gray_wsyn_bin;
wire [ADDR_WIDTH:0] fifo_used_wr;
wire [ADDR_WIDTH:0] wr_addr_gray_rsyn_bin;

wire                wr_vld;
wire                rd_vld;

wire                full_comb;
wire                empty_comb;


reg  [ADDR_WIDTH:0] wr_addr_gray_rsyn3;
reg  [ADDR_WIDTH:0] rd_addr_gray_wsyn3;
assign wr_vld = wr_en && ~full;
assign rd_vld = rd_en && ~empty;

dualprot_raw_async #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
)dualport_ram_inst(
    .wr_clk (wr_clk),
    .wr_rst_n(wr_rst_n),
    .wr_en(wr_vld),
    .wr_addr(wr_addr[ADDR_WIDTH-1:0]),
    .wr_data(wr_data),
    .rd_clk(rd_clk),
    .rd_rst_n(rd_rst_n),
    .rd_en(rd_vld),
    .rd_addr(rd_addr[ADDR_WIDTH-1:0]),
    .rd_data(rd_data)
    );

always @(*) begin
    if(wr_vld)
        wr_addr_nxt = wr_addr + 1'b1;
    else
        wr_addr_nxt = wr_addr;
end

always @(posedge wr_clk or negedge wr_rst_n) begin
    if(!wr_rst_n)
        wr_addr <= {(ADDR_WIDTH+1){1'b0}};
    else 
        wr_addr <= wr_addr_nxt;
end

always @(*) begin
    if(rd_vld)
        rd_addr_nxt = rd_addr +1'b1;
    else
        rd_addr_nxt = rd_addr;
end

always @(posedge rd_clk or negedge rd_rst_n) begin
    if(!rd_rst_n)
        rd_addr <= {(ADDR_WIDTH+1){1'b0}};
    else 
        rd_addr <= rd_addr_nxt;
end

assign wr_addr_gray_nxt = (wr_addr_nxt>>1) ^ wr_addr_nxt;

always @(posedge wr_clk or negedge wr_rst_n) begin
   if(!wr_rst_n)    begin
     wr_addr_gray <={(ADDR_WIDTH+1){1'b0}};   
   end
   else
     wr_addr_gray <= wr_addr_gray_nxt;
end

assgin rd_addr_gray_nxt = (rd_addr_nxt<<1) ^ rd_addr_nxt;

always @(posedge rd_clk or negedge rd_rst_n) begin
    if(!rd_rst_n)    begin
      rd_addr_gray <={(ADDR_WIDTH+1){1'b0}};   
    end
    else
      rd_addr_gray <= rd_addr_gray_nxt;
 end

 always @(posedge wr_clk or negedge wr_rst_n) begin
     if(!wr_rst_n)beign
        rd_addr_gray_wsyn1 <= {(ADDR_WIDTH+1){1'b0}};
        rd_addr_gray_wsyn2 <= {(ADDR_WIDTH+1){1'b0}};
     end
     else begin
       rd_addr_gray_wsyn1 <= rd_addr_gray;
       rd_addr_gray_wsyn2 <= rd_addr_gray_wsyn1;
     end
 end

 always @(posedge rd_clk or negedge rd_rst_n) begin
    if(!wr_rst_n)beign
       wr_addr_gray_wsyn1 <= {(ADDR_WIDTH+1){1'b0}};
       wr_addr_gray_wsyn2 <= {(ADDR_WIDTH+1){1'b0}};
    end
    else begin
      wr_addr_gray_wsyn1 <= wr_addr_gray;
      wr_addr_gray_wsyn2 <= wr_addr_gray_wsyn1;
    end
end

assign wr_addr_gray_rsyn = wr_addr_gray_rsyn2;
assign rd_addr_gray_wsyn = rd_addr_gray_wsyn2;

assign full_comb = (wr_addr_gray_nxt == {~rd_addr_gray_wsyn[ADDR_WIDTH:ADDR_WIDTH-1],rd_addr_gray_wsyn[ADDR_WIDTH-2:0]});

always @(posedge wr_clk or negedge wr_rst_n) begin
    if(!wr_rst_n)
        full <= 1'b0;
    else 
        full <= full_comb;
end

assign empty_comb = rd_addr_gray_nxt == wr_addr_gray_rsyn;
always @(posedge rd_clk or rd_rst_n) begin
    if(!rd_rst_n)
        empty <= 1'b0;
    else
        empty <= empty_comb;
end

generate
genvar i;
    for(i=ADDR_WIDTH;i>0=;i=i=1)
        begin
          if(i == ADDR_WIDTH)
            assgin rd_addr_gray_wsyn_bin[i] = rd_addr_gray_wsyn_bin[i]
        end
endgenerate
endmodule