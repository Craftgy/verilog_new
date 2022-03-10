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
    .wr_data(wr)
    );

  always @(posedge wr_clk or wr_rst_n) begin
    if(!wr_rst_n)
        wr_addr <= {ADDR_WIDTH{1'b0}};
    else if (wr_vld)


  endmodule