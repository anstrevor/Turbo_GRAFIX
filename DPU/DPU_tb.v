`include "DPU.v"

module DPU_tb();

	

	reg[3:0] Abus;
	reg[3:0] Bbus;
	reg[3:0] Rbus;
	reg[2:0] n;
	
	wire[23:0] k;
	wire[3:0] cc;
	
	initial begin
		$monitor("K = %b", k);
		
		 /*Abus <= 4'h2;
		 Bbus <= 4'h0;
		 Rbus <= 4'h0;
		
		 n <= 4'h4;*/
		 
		 Abus <= 4'hB;
		 Bbus <= 4'h8;
		 Rbus <= 4'h9;
		 n <= 4'h0;
		 
		 #10 Abus <= 4'h3;
		 Bbus <= 4'hA;
		 Rbus <= 4'hA;
		 n <= 4'h4;
		 
		 #10 Abus <= 4'h0;
		 Bbus <= 4'h0;
		 Rbus <= 4'hB;
		 n <= 4'h4;
		 
		
	end
	
DPU U_DPU(Abus, Bbus, Rbus, n, cc, k);

endmodule