`include "ALU.v"
module ALU_tb();

reg[7:0] a;
reg[7:0] b;
reg[2:0] n;

wire[7:0] r;
wire[3:0] cc;

initial begin
	//$monitor("%b %b", r, n);
	//$monitor("%b", n);
    $monitor("CCReg = %b", cc);
	
	a = 8'h0F;
	b = 8'h01;
	n = 4'h0;
	
	#5 n = 4'h1;
	#10 n = 4'h2;
	#15 n = 4'h3;
    #20 n = 4'h4;
    #25 n = 4'h5;
    #30 n = 4'h6;
    #35 n = 4'h7;
	
end

ALU U_ALU(
a,
b,
n,
cc,
r
);

endmodule

