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
		
		/*for (i=0; i<11; i=i+1) begin
			#5 clk = ~clk;
			//$monitor("K = %b", Kbus);
			
			cmd = cmd - i;
		end*/
        
        #5 clk = ~clk;
        cmd = 2;
        
        #5 clk = ~clk;
        cmd = 4;
        
        #5 clk = ~clk;
        cmd = 6;
        
        #5 clk = ~clk;
        cmd = 8;
        
        #5 clk = ~clk;
        cmd = 10;
        
        #5 clk = ~clk;
        cmd = 12;
        
        #5 clk = ~clk;
        cmd = 14;
        
        #5 clk = ~clk;
        cmd = 16;
        
        #5 clk = ~clk;
        cmd = 18;
        
        #5 clk = ~clk;
        cmd = 20;
        
        #5 clk = ~clk;
        cmd = 22;
        
        #5 clk = ~clk;
        cmd = 24;
        


        
	
	end
	
	/*always begin
		#50000000000 clk = ~clk;
		$monitor("K = %b", Kbus);
	end*/
	
	
	CCU U_CCU(cmd, clk, Kbus);
	


	
	
endmodule

