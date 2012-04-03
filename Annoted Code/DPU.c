/* DPU.v
 Trevor Crone, 2012
 
 DPU marshals data to and from ALU and between CCU
*/
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
	
    //Define I/O
	reg [7:0] regFile[15:0];
    reg [7:0] accuA;
    reg [7:0] accuB;
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
	reg [3:0] i;
	
	//Fill RegFile constatnts
	initial begin 
		regFile [12] = 1;
        regFile [13] = 0;
	end
	
	//Pass through data to regFile from CCU or load ALU accumulators
	always @ (n, Rbus) begin
		if(n == 8) begin
			regFile [Rbus] = mData;
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
	
	//Load regFile with ALU output
	always @ (tr, writeEnable) begin
        if (writeEnable == 1) begin 
            regFile [Rbus] = tr;
        end
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
endmodule
