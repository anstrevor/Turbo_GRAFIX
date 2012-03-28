`include "CCU.v"

module CCU_tb();


	reg [7:0] cmd;
	reg clk;
	reg[4:0] i;
	
	wire [23:0] Kbus;
	
	
	initial begin
		clk = 0;
		i = 0;
		
		cmd = 76;
		
		for (i=0; i<11; i=i+1) begin
			#5 clk = ~clk;
			//$monitor("K = %b", Kbus);
			
			cmd = cmd - i;
		end
	
	end
	
	/*always begin
		#50000000000 clk = ~clk;
		$monitor("K = %b", Kbus);
	end*/
	
	
	CCU U_CCU(cmd, clk, Kbus);
	


	
	
endmodule

