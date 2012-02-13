'include "ALU.v"
module ALU_tb();

reg[7:0] a;
reg[7:0] b;
reg[2:0] n;

reg[7:0] r;
reg[3:0] cc;

initial begin
	$monitor("%b", r)
	
	a = 8'hAA
	b = 8'hAA
	n = 4'h00
	
end

ALU U_ALU(
a,
b,
n,
cc,
r
);

endmodule

