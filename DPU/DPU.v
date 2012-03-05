`include "ALU.v"

module DPU(Abus, Bbus, Rbus, n, cc, Kbus);

	//Inputs
	input [3:0] Abus;
	input [3:0] Bbus;
	input [3:0] Rbus;
	input [2:0] n;
	

	//Outputs
	output [23:0] Kbus;
	output [3:0] cc;
	
	//Memory Block
	reg [7:0] regFile[15:0];
	
	//Define I/O
	wire[3:0] Abus;
	wire[3:0] Bbus;
	wire[3:0] Rbus;
	wire[2:0] n;
	wire[3:0] cc;	
	wire[7:0] tr;

	
	reg[23:0] Kbus;
	//reg[3:0] cc;
	reg [3:0] i;
	
	
	//Fill RegFile with something
	initial begin //always @ (Abus, Bbus, Rbus, n, cc, Kbus) begin
		fill;
	end
	
	
	//Pass through data to regFile
	//always @ (n, Rbus) begin
	//	if(n == 7) begin
			
		
	
	
	//Run ALU
	ALU U_ALU(
		regFile [Abus],
		regFile [Bbus],
		n,
		cc,
		tr
		);
	
	
	//Fill move tr to register, also fill K for now.
	always @ (tr) begin
		regFile [Rbus] = tr;
		//Kbus = regFile [Rbus];
		//$display("here Rbus = %b", Rbus);
		Kbus = (regFile[9] << 16) + (regFile[10] << 8) + (regFile[11]);
	end
	
	//Fill K bus
	//always @ (regFile[9], regFile[10], regFile[11]) begin
	//	Kbus = (regFile[9] << 16) + (regFile[10] << 8) + (regFile[11]);
	//end
	
	
	
	//For right now, just fill the regFile with 0 to 13...
	task fill;
	begin
		for (i=0; i<14; i=i+1) begin
			regFile [i] = i;
		end
	end
	endtask
	
	
	
endmodule
