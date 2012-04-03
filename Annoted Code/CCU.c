/* CCU.v
 Trevor Crone, 2012
 
 CCU commands DPU and ALU
*/
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
    reg outEnable;
	
	initial begin
		state = 0;
		Pstate = 0;
		Lstate = 0;
        outEnable = 0;
	end
	
	//Run at clock
	always @ (posedge clk or negedge clk) begin
    		
		//Idle state
		if(state == 0)
		begin
			case (cmd)
				76:line;
				80:point;
			endcase
            
		end
        else begin
            //Point state.  Fill X, Y, Color registers. Output
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
                        outEnable = ~outEnable;
                        Pstate = 0;
                        state = 0;
                        end
                endcase
            end
            
            
            //Line State.  Run Bresenham algorithm
            if(state == 2)
            begin
                case (Lstate)
                    1:begin //Xs
                        n = 8;
                        Rbus = 5;
                        mData = cmd;
                        tx = cmd;
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
                        Lstate = Lstate + 1;
                        end
                    5:begin //Colour
                        n = 8;
                        Rbus = 11;
                        mData = cmd;
                        Lstate = Lstate + 1;
                        end
                    6:begin //Dy
                        n = 1;
                        Rbus = 1;
                        Abus = 8;
                        Bbus = 7;
                        Lstate = Lstate + 1;
                        end
                    7:begin //Dx
                        n = 1;
                        Rbus = 0;
                        Abus = 6;
                        Bbus = 5;
                        Lstate = Lstate + 1;
                        end
                    8:begin //EnoInc
                        n = 2;
                        Rbus = 4;
                        Abus = 1;
                        Lstate = Lstate + 1;
                        end
                    9:begin //Error
                        n = 1;
                        Rbus = 2;
                        Abus = 4;
                        Bbus = 0;
                        Lstate = Lstate + 1;
                        end
                    10:begin //EInc
                        n = 1;
                        Rbus = 3;
                        Abus = 2;
                        Bbus = 0;
                        Lstate = Lstate + 1;
                        end
                    11:begin //X, pass Xs
                        n = 4;
                        Rbus = 9;
                        Abus = 5;
                        Lstate = Lstate + 1;
                        end
                    12:begin //Y, pass Ys
                        n = 5;
                        Rbus = 10;
                        Bbus = 7;
                        Lstate = Lstate + 1;
                        end
                    13: begin //Main loop start.  X = X + 1
                        n = 0;
                        Rbus = 9;
                        Abus = 9;
                        Bbus = 12;
                        tx = tx + 1;
                        outEnable = ~outEnable;
                        Lstate = Lstate + 1;
                        end
                    14: begin //Main loop: check error < 0
                        n = 6;
                        Rbus = 14;
                        Abus = 2;
                        Bbus = 13;
                        Lstate = 19;
                        end
                    15: begin //Main loop: Set error = error + EnoInc 
                        n = 0;
                        Rbus = 2;
                        Abus = 2;
                        Bbus = 4;
                        Lstate = 18;
                        end
                    16: begin //Main loop: Set Y = Y + 1.  P1 of 2.
                        n = 0;
                        Rbus = 10;
                        Abus = 10;
                        Bbus = 12;
                        Lstate = Lstate + 1;
                        end
                    17: begin //Set error = error + EInc
                        n = 0;
                        Rbus = 2;
                        Abus = 2;
                        Bbus = 3;
                        Lstate = 18;
                        end
                    18: begin //End of loop.  Detrmine if the loop should continue
                        if (tx <= txe) begin
                            Lstate = 13;
                        end
                        else begin
                            Lstate = 0;
                            state = 0;
                        end
                        end
                    19: begin //Check CC regster for path
                        if (cc[3] == 1) begin
                            //Set error = error + EnoInc
                            Lstate = 15;
                            end
                        else begin
                            //Set Y = Y +1, Set Error = Error + EInc
                            Lstate = 16;
                            end
                        end
                endcase
            end
        end
						
	end
	
	//Task: start plot point FSM
	task point;
	begin
		state = 1;
		Pstate = 1;
	end
	endtask
	
	//Task: start plot line FSM
	task line;
	begin
		state = 2;	
		Lstate = 1;
		$display("Line");
	end
	endtask
	
	//Call DPU
	DPU U_DPU(Abus, Bbus, Rbus, n, cc, Kbus, mData, outEnable);
endmodule
	
	
	
	
	