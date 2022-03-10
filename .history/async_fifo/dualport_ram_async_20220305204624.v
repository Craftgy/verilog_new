module dualport_ram_async #(
		parameter	DATA_WIDTH = 8,
		parameter	ADDR_WIDTH = 4  //ram depth is equal to 2^ADDR_WIDTH
		)(
		input wr_clk,
		input wr_rst_n,
		input wr_en,
		input [ADDR_WIDTH-1:0] wr_addr,
		input [DATA_WIDTH-1:0] wr_data,
		input rd_clk,
		input rd_rst_n,
		input rd_en,
		input [ADDR_WIDTH-1:0] rd_addr,
		output [DATA_WIDTH-1:0] rd_data
    );

    localparam 	RAM_DEPTH = 1<<ADDR_WIDTH;

    reg [DATA_WIDTH-1:0] mem [RAM_DEPTH-1:0];
    integer II;
    always @(posedge wr_clk or negedge wr_rst_n) begin
            if(!wr_rst_n) begin
                for(II=0;II<RAM_DEPTH;II=II+1) begin
                    mem[II] <= {DATA_WIDTH{1'b0}};
            end 
        end
            else if(wr_en) begin
                mem[wr_addr] <= wr_data;
            end
    end

    always @(posedge rd_clk or negedge rd_rst_n) begin
        if(!rd_rst_n) begin
            rd_data <= {DATA_WIDTH{1'b0}};
        end 
        else if(rd_en) begin
            rd_data = mem[rd_addr];
        end
    end

    //assign rd_data = mem[rd_addr]; //为什么用组合逻辑，而不是时序逻辑

endmodule