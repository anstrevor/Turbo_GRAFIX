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
	//reg [24:0] Kbus;
	
	
	initial begin
		state = 0;
		Pstate = 0;
		Lstate = 0;
        outEnable = 0;
	end
	
	//Run at clock
	always @ (posedge clk or negedge clk) begin
    
        //outEnable = 0;
		
		//Idle state
		if(state == 0)
		begin
			case (cmd)
				76:line;
				80:point;
			endcase
            
		end
        else begin
        
            //$monitor("Lstate = %d", Lstate);
            $display("Lstate = %d", Lstate);
		
		
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
                        
                        outEnable = ~outEnable;
                        
                        Pstate = 0;
                        state = 0;
                        end
                endcase
            end
            
            
            //Line State.  Run that algorithm
            if(state == 2)
            begin
                //$display("Lstate = %d", Lstate);
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
                        $display("State 13");
                        n = 0;
                        Rbus = 9;
                        Abus = 9;
                        Bbus = 12;
                        tx = tx + 1;
                        
                        outEnable = ~outEnable;
                        Lstate = Lstate + 1;
                        end
                    14: begin //Main loop: check error < 0
                        //$display("State 14");
                        n = 6;
                        Rbus = 14;
                        Abus = 2;
                        Bbus = 13;
                        if (cc[3] == 1) begin
                            //Set error = error + EnoInc
                            Lstate = 15;
                            end
                        else begin
                            //Set Y = Y +1   + Set Error = Error + EInc
                            Lstate = 16;
                            end
                        end
                    15: begin //Main loop: Set error = error + EnoInc 
                        $display("State 15");
                        n = 0;
                        Rbus = 2;
                        Abus = 2;
                        Bbus = 4;
                        Lstate = 18;
                        end
                    16: begin //Main loop: Set Y = Y + 1.  P1 of 2.
                        //$display("State 16");
                        n = 0;
                        Rbus = 10;
                        Abus = 10;
                        Bbus = 12;
                        Lstate = Lstate + 1;
                        end
                    17: begin //Set error = error + EInc
                        //$display("State 17");
                        n = 0;
                        Rbus = 2;
                        Abus = 2;
                        Bbus = 3;
                        Lstate = 18;
                        end
                    18: begin //End of loop.  Detrmine if the loop should continue
                        $display("State 18");
                        if (tx <= txe) begin
                            Lstate = 13;
                        end
                        else begin
                            Lstate = 0;
                            state = 0;
                        end
                        end
                        
                        
                endcase
            end
        end
						
	end
    
    
    //Task: Loop
    /*task loop;
    begin
        while (tx <= txe) begin
        
            //X = X + 1
            n = 0;
            Rbus = 9;
            Abus = 9;
            Bbus = 12;
            tx = tx + 1;
            
            //outEnable = 1;
            
            //Check Error < 0
            n = 6;
            Rbus = 14;
            Abus = 2;
            Bbus = 13;
            if (cc[3] == 1) begin
                //Set error = error + EnoInc
                n = 0;
                Rbus = 2;
                Abus = 2;
                Bbus = 4;
                end
            else begin
                //Set Y = Y +1
                n = 0;
                Rbus = 10;
                Abus = 10;
                Bbus = 12;
                
                //Set Error = Error + EInc
                n = 0;
                Rbus = 2;
                Abus = 2;
                Bbus = 3;
                end
            end
        
        Lstate = 0;
        state = 0;
    end
    endtask*/
        
        
            
                
	
	

	/*//Task: InitError
	task initError;
	begin
		n = 1;
		Abus = 4;
		Bbus = 0;
		Rbus = 2;
	end
	endtask*/
	
	
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
	
	
	
	DPU U_DPU(Abus, Bbus, Rbus, n, cc, Kbus, mData, outEnable);
	
	
endmodule
	
	
	
	
	