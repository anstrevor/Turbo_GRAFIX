`include "ALU.v"

module DPU(Abus, Bbus, Rbus, n, cc, Kbus, mData, outEnable);

	//Inputs
	input [3:0] Abus;
	input [3:0] Bbus;
	input [3:0] Rbus;
	input [3:0] n;
	input [7:0] mData;
    input outEnable;
	

	//Outputs
	output [23:0] Kbus;
	output [3:0] cc;
	
	//Memory Block
	reg [7:0] regFile[15:0];
    reg [7:0] accuA;
    reg [7:0] accuB;
	
	//Define I/O
	wire[3:0] Abus;
	wire[3:0] Bbus;
	wire[3:0] Rbus;
	wire[3:0] n;
	wire[3:0] cc;	
	wire[7:0] tr;
	wire[7:0] mData;
    wire outEnable;
    wire writeEnable;

	
	reg[23:0] Kbus;
	//reg[3:0] cc;
	reg [3:0] i;
	
	
	//Fill RegFile with something
	initial begin 
		regFile [12] = 1;
        regFile [13] = 0;
	end
	
	
	//Pass through data to regFile
	always @ (n, Rbus) begin
		if(n == 8) begin
			regFile [Rbus] = mData;
			//$display(" New Data  = %b.  Rbus = %d", regFile [Rbus], Rbus);
			//Kbus = (regFile[9] << 16) + (regFile[10] << 8) + (regFile[11]);
			//$monitor(" Kbus @ new data = %b", Kbus);
		end
        else begin
            accuA = regFile [Abus];
            accuB = regFile [Bbus];
        end
	end
			
		
	
	
	//Run ALU
	ALU U_ALU(
		accuA,
		accuB,
		n,
		cc,
		tr,
        writeEnable
		);
	
	
	//Update the 'Kbus'.  This is causing problems.  THe @ Tr is not ideal and since Rbus might
	// not change... The good data gets lost... added cc??
	always @ (tr, writeEnable) begin
        if (writeEnable == 1) begin 
            $display("Here: RBus = %d,  tr = %b", Rbus, tr);
            regFile [Rbus] = tr;
            //Kbus = regFile [Rbus];
        end
	end
    
	
	    
    //Print registers
    always @ (Rbus) begin
        $display("Printout:");
        for (i=0; i<12; i=i+1) begin
            $display("Bit #%d -> %d", i, regFile[i]);
        end
        $display("\n");
    end
    
    
    //Output to Screen (Video)
    always @ (outEnable) begin
        begin
        $display("\nVideo Out:");
        $display("X -> %b", regFile[9]);
        $display("Y -> %b", regFile[10]);
        $display("Colour -> %b", regFile[11]);
        end
    end
            
	
	
	
	//For right now, just fill the regFile with 0 to 13...
	task fill;
	begin
		for (i=0; i<14; i=i+1) begin
			regFile [i] = i;
		end
	end
	endtask
	
	
	
endmodule
