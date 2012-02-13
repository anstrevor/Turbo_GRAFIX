module ALU(a, b, n, cc, r);

	//Inputs
	input [7:0] a;
	input [7:0] b;
	input [2:0] n;

	//Outputs
	output [7:0] r;
	output [3:0] cc;


	//Define I/O
	wire[7:0] a;
	wire[7:0] b;
	wire[2:0] n;

	reg[7:0] r;
	reg[3:0] cc;
	
	//Run on n commands
	always @ (a, b, n) begin
			
			//if(n[2] == 0) begin
			//	r = a;
			//end
			
			$display(">>%b", n);
			case (n)
				0:$display("000");
				1:$display("001");
				2:$display("010");
				3:$display("011");
				4:$display("100");
					r = a;
				5:$display("101");
					r = b;
				6:$display("110");
				7:$display("111");
				default:$display("XXX");
			endcase
			
			
			
			
	end


endmodule
		
