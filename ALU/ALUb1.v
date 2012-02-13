module ALU(a, b, n, cc, r);

	//Inputs
	input [7:0] a;
	input [7:0] b;
	input [2:0] n;

	//Outputs
	output [7:0] r;
	output [3:0] cc;

	//Define I/O
	reg[7:0] a;
	reg[7:0] b;
	reg[3:0] n;

	reg[7:0] r;
	reg[3:0] cc;
	
	if (n[2] == 1) begin
		//
	end


	
	if (n[2]) == 1) begin 
		if (n[1] == 1) begin
			if (n[0] == 1) begin
				//111
			end else begin
				//110
			end
		end else begin
			if (n[0] == 1) begin
                                //101
                        end else begin
                                //100
			end
		end
	end else begin
		if (n[1] == 1) begin
			if (n[0] == 1) begin
				//011
			end else begin
				//010
			end
		end else begin
			if (n[0] == 1) begin
                                //001
                        end else begin
                                //000
								//r <= 1;
			end
		end
	end

endmodule
		
