`include "ALU.v"
module ALU_tb();

reg[7:0] a;
reg[7:0] b;
reg[2:0] n;

wire[7:0] r;
wire[3:0] cc;

initial begin
	$monitor("%b %b", r, n);
	//$monitor("%b", n);
	
	a = 8'hAA;
	b = 8'hAA;
	n = 4'h0;
	
	#5 n = 4'h1;
	#10 n = 4'h2;
	#15 n = 4'h3;
	
end

ALU U_ALU(
a,
b,
n,
cc,
r
);

endmodule

