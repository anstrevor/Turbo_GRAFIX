`include "CCU.v"

module CCU_tb();


	reg [7:0] cmd;
	reg clk;
	reg[4:0] i;
	
	wire [23:0] Kbus;
	
	
	initial begin
    
    
        $dumpfile("test3.vcd");
        $dumpvars(2,U_CCU);

		clk = 0;
		i = 0;
        
		
		cmd = 76;
		
		/*for (i=0; i<11; i=i+1) begin
			#5 clk = ~clk;
			//$monitor("K = %b", Kbus);
			
			cmd = cmd - i;
		end*/
        
        #5 clk = ~clk;  //Xs
        cmd = 0;
        
        #5 clk = ~clk; //Ys
        cmd = 0;
        
        #5 clk = ~clk; //Xe
        cmd = 50;
        
        #5 clk = ~clk; //Ye
        cmd = 30;
        
        #5 clk = ~clk; //color
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
        
        #5 clk = ~clk;
        #5 clk = ~clk;
        #5 clk = ~clk;
        
        
        for (i=0; i<32; i=i+1) begin
			#5 clk = ~clk;
            cmd = 0;
        end


        
	
	end
	
	/*always begin
		#50000000000 clk = ~clk;
		$monitor("K = %b", Kbus);
	end*/
	
	
	CCU U_CCU(cmd, clk, Kbus);
	


	
	
endmodule

