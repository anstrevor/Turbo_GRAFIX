module ALU(a, b, n, cc, r);

	//Inputs
	input [7:0] a;
	input [7:0] b;
	input [2:0] n;

	//Outputs
	output [7:0] r;
	output [3:0] cc;


	//Define I/O
	wire[7:0] a;
	wire[7:0] b;
	wire[2:0] n;

	reg[7:0] r;
	reg[3:0] cc;
	
    
	//Run on n commands
	always @ (a, b, n) begin
			
			//if(n[2] == 0) begin
			//	r = a;
			//end
			
			//$display(">>%b", n);
            
            //Case through all commands
			case (n)
				0:add;
				1:subtract;
				2:multiplyA;
				3:divideA;
				4:passA;
				5:passB;//$display("101");
					//r = b;
				6:$display("110");
				7:$display("111");
				default:$display("XXX");
			endcase
			
			
			
			
	end
    
    
    //Task: Addition
    task add;
    begin
        r = a + b;
        //Need to set flags here
        $display("%b + %b = %b", a, b, r);
    end
    endtask
    
    
    //Task: Subtraction
    task subtract;
    begin
        r = a - b;
        //SetFlags
        $display("%b - %b = %b", a, b, r);
    end
    endtask
    
    
    //Task: Multiply A by 2
    task multiplyA;
    begin
        r = a*2;
        //SetFlags
        $display("%b -> %b", a, r);
    end
    endtask

    
    //Task: Divide A by 2
    task divideA;
    begin
        r = a/2;
        //Set flags    
        $display("%b -> %b", a, r);
    end
    endtask

    
    //Task: Pass through B bus
    task passB;
    begin
        $display("101");
        r = b;
    end
    endtask
    
    
    //Task: Pass through bus A
    task passA;
    begin
        $display("100");
        r = a;
    end
    endtask
    
    
    //Task: Max of A and B
    task max;
    begin
    
        $display("%b , %b  MAX= %b", a, b, r);
    end
    endtask



endmodule
		
