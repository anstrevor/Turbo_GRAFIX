module ALU(a, b, n, cc, r);

	//Inputs
	input [7:0] a;
	input [7:0] b;
	input [3:0] n;

	//Outputs
	output [7:0] r;
	output [3:0] cc;


	//Define I/O
	wire[7:0] a;
	wire[7:0] b;
	wire[3:0] n;

	reg[7:0] r;
	reg[3:0] cc;
	
    
	//Run on n commands
	always @ (a, b, n) begin
			
			//if(n[2] == 0) begin
			//	r = a;
			//end
			
			//$display(">>%b", n);
            
            //Clear CC register
            cc = 4'h0;
            
            //Case through all commands
			case (n)
				0:add;
				1:subtract;
				2:multiplyA;
				3:divideA;
				4:passA;
				5:passB;//$display("101");
					//r = b;
				6:max;
				7:min;
				default:$display("Unknown Command");
			endcase
			
			
			
			
	end
    
    
    //Task: Addition
    task add;
    begin
        r = a + b;
        
        cc[0] = 1;
        if (r == 0)
        begin
            cc[1] = 1;
        end
        
        $display("%b + %b = %b", a, b, r);
    end
    endtask
    
    
    //Task: Subtraction
    task subtract;
    begin
        r = a - b;
        
        cc[0] = 1;
        if (r== 0)
        begin 
            cc[1] = 1;
        end
        
        $display("%b - %b = %b", a, b, r);
    end
    endtask
    
    
    //Task: Multiply A by 2
    task multiplyA;
    begin
        r = a*2;
        
        cc[0] = 1;
        if (r==0)
        begin
            cc[1] = 1;
        end
        
        $display("%b a*2->r %b", a, r);
    end
    endtask

    
    //Task: Divide A by 2
    task divideA;
    begin
        r = a/2;
        
         cc[0] = 1;
         if (r==0)
         begin
            cc[1] = 1;
        end
        
        $display("%b a/2->r %b", a, r);
    end
    endtask

    
    //Task: Pass through B bus
    task passB;
    begin
        r = b;
        $display("%b  b=>r  %b", b, r);

    end
    endtask
    
    
    //Task: Pass through bus A
    task passA;
    begin
        r = a;
        $display("%b  a=>r  %b", a, r);

    end
    endtask
    
    
    //Task: Max of A and B
    task max;
    begin
        if( a >= b)
        begin
            r = a;
            cc[2] = 1;
        end
        else
        begin 
            r = b;
            cc[3] = 1;
        end
        
        $display("%b , %b  MAX= %b", a, b, r);
    end
    endtask
    
    
    //Task: Min of A and B
    task min;
    begin
        if( a < b)
        begin
            r = a;
            cc[3] = 1;
        end
        else
        begin
            r = b;
            cc[2] = 1;
        end
        
        $display("%b , %b  MIN= %b", a, b, r);
    end
    endtask
        

endmodule
		
