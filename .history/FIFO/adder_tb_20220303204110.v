`include 'adder_tb.v
`timescale 1ns/1ns
module adder_tb();
	reg [3:0] a;
	reg [3:0] b;
	wire [7:0] c;

	reg clk,rst_n;

	adder DUT (
		.clk(clk),
		.rst_n(rst_n),
		.a(a),
		.b(b),
		.c(c)
	);

	always begin
		#10 clk = 0;
		#10 clk = 1;
	end

	initial begin
		rst_n = 1;
		test(4'b1111, 4'b1111, 5'b11110);
		$finish;
	end
	task test;
		input [3:0] in;
		input [3:0] in2;
		input [7:0] e;
		begin
			a = in;
			b = in2;
			@(posedge clk);
			@(negedge clk);
			if (c == e) begin
				$display("It works");
			end else begin
				$display("opps %d + %d ~= %d, expect %d", in, in2, c, e);
			end
		end
	endtask
endmodule