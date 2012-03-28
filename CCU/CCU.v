`include "DPU.v"

module CCU(cmd, clk, Kbus);

	//Inputs
	input [7:0] cmd;
	input clk;
	
	//Outputs
	output [23:0] Kbus;
	
	//Wires
	wire cmd;
	wire clk;
	wire [23:0] Kbus;
	wire [3:0] cc;
	
	
	//Registers
	reg [1:0] state;
	reg [3:0] Pstate;
	reg [6:0] Lstate;
	reg[3:0] Abus;
	reg[3:0] Bbus;
	reg[3:0] Rbus;
	reg[3:0] n;
	reg[7:0] mData;
    reg [7:0] tx;
    reg [7:0] txe;
	//reg [24:0] Kbus;
	
	
	initial begin
		state = 0;
		Pstate = 0;
		Lstate = 0;
	end
	
	//Run at clock
	always @ (posedge clk) begin
		
		//Idle state
		if(state == 0)
		begin
			case (cmd)
				76:line;
				80:point;
			endcase
		end
		
		
		//Point state.  Fill X, Y, Color registers.  That's it for now.
		if(state == 1)
		begin
			case (Pstate)
				1:begin
					n = 8;
					Rbus = 9;
					mData = cmd;
					Pstate = Pstate + 1;
				    end
				2:begin
					n = 8;
					Rbus = 10;
					mData = cmd;
					Pstate = Pstate + 1;
				    end
				3:begin
					n = 8;
					Rbus = 11;
					mData = cmd;
					Pstate = 0;
					state = 0;
				    end
			endcase
		end
		
		
		//Line State.  Run that algorithm
		if(state == 2)
		begin
			case (Lstate)
				1:begin //Xs
					n = 8;
					Rbus = 5;
					mData = cmd;
					Lstate = Lstate + 1;
					end
				2:begin //Ys
					n = 8;
					Rbus = 7;
					mData = cmd;
					Lstate = Lstate + 1;
				    end
				3:begin //Xe
					n = 8;
					Rbus = 6;
					mData = cmd;
                    txe = cmd;
					Lstate = Lstate + 1;
				    end
				4:begin //Ye
					n = 8;
					Rbus = 8;
					mData = cmd;
					Pstate = Pstate + 1;
				    end
				5:begin //Colour
					n = 8;
					Rbus = 11;
					mData = cmd;
					Pstate = Pstate + 1;
				    end
				6:begin //Dy
                    n = 1;
                    Rbus = 1;
                    Abus = 8;
                    Bbus = 7;
                    Pstate = Pstate + 1;
                    end
				7:begin //Dx
                    n = 1;
                    Rbus = 0;
                    Abus = 6;
                    Bbus = 5;
                    Pstate = Pstate + 1;
                    end
                8:begin //EnoInc
                    n = 2;
                    Rbus = 4;
                    Abus = 1;
                    Pstate = Pstate + 1;
                    end
                9:begin //Error
                    n = 1;
                    Rbus = 2;
                    Abus = 4;
                    Bbus = 0;
                    Pstate = Pstate + 1;
                    end
                10:begin //EInc
                    n = 1;
                    Rbus = 3;
                    Abus = 2;
                    Bbus = 0;
                    Pstate = Pstate + 1;
                    end
                11:begin //X
                    n = 8;
                    Rbus = 9;
                    mData = cmd;
                    tx = cmd;
                    Pstate = Pstate + 1;
                    end
                12:begin //Y
                    n = 8;
                    Rbus = 10;
                    mData = cmd;
                    Pstate = Pstate + 1;
                    end
                //11:loop; //Main loop
                    
			endcase
		end
						
	end
    
    
    //Task: Loop
    task loop;
    begin
        while (tx <= txe) begin
            n = 0;
            Rbus = 9;
            Abus = 9;
            //HC one
        
	
	
	//
	//Task: InitError
	task initError;
	begin
		n = 1;
		Abus = 4;
		Bbus = 0;
		Rbus = 2;
	end
	endtask
	
	
	//Task: Plot point
	task point;
	begin
		state = 1;
		Pstate = 1;
		$display("Point");
		
	end
	endtask
	
	
	
	//Task: Plot line
	task line;
	begin
		state = 2;	
		Lstate = 1;
		$display("Line");
	end
	endtask
	
	
	
	DPU U_DPU(Abus, Bbus, Rbus, n, cc, Kbus, mData);
	
	
endmodule
	
	
	
	
	