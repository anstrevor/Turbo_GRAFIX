/* ALU.v
 Trevor Crone, 2012   
 
 ALU portion of GRAFIX.  ALU preforms logic operations.
 
*/
module ALU(a, b, n, cc, r, writeEnable);

	//Inputs
	input [7:0] a;
	input [7:0] b;
	input [3:0] n;

	//Outputs
	output [7:0] r;
	output [3:0] cc;
    output writeEnable;


	//Define I/O
	wire[7:0] a;
	wire[7:0] b;
	wire[3:0] n;
	reg[7:0] r;
	reg[3:0] cc;
    reg writeEnable;
	
    
	//Run on a, b or n bus activity
	always @ (a, b, n) begin
			
            //Clear CC register and write Enable
            cc = 4'h0;
            writeEnable = 0;
            
            
            //Case through all commands
			case (n)
				0:add;
				1:subtract;
				2:multiplyA;
				3:divideA;
				4:passA;
				5:passB;
				6:max;
				7:min;
				default:$display("Unknown Command");
			endcase
	end
    
    
    //Task: Addition
    task add;
    begin
    
        //Account for negative binary numbers
        if(a[7] == 1) begin
            r = b - ~a;
        end 
        else if(b[7] == 1) begin
            r = a - ~b;
        end
        else begin
            r = a + b;
        end

        
        //Set CC register
        cc[0] = 1;
        if (r == 0)
        begin
            cc[1] = 1;
        end
        
        writeEnable = 1;
    end
    endtask
    
    
    //Task: Subtraction
    task subtract;
    begin
    
        //Acount for negative binary numbers
        if(a[7] == 1) begin
            r = ~(~a + b);
        end
        else if(b[7] == 1) begin
            r = a + ~b;  
        end else begin
            r = a - b;
        end
        
        //Set CC register
        cc[0] = 1;
        if (r== 0)
        begin 
            cc[1] = 1;
        end
        
        writeEnable = 1;
    end
    endtask
    
    
    //Task: Multiply A by 2
    task multiplyA;
    begin

        r = a*2;
        
        //Set CC register
        cc[0] = 1;
        if (r==0)
        begin
            cc[1] = 1;
        end
        
        writeEnable = 1;
    end
    endtask

    
    //Task: Divide A by 2
    task divideA;
    begin

        r = a/2;
        
        //Set CC register
        cc[0] = 1;
        if (r==0)
        begin
            cc[1] = 1;
        end
        
        writeEnable = 1;
    end
    endtask

    
    //Task: Pass through B bus
    task passB;
    begin

        r = b;
        
        writeEnable = 1;
    end
    endtask
    
    
    //Task: Pass through bus A
    task passA;
    begin

        r = a;
        
        writeEnable = 1;
    end
    endtask
    
    
    //Task: Max of A and B
    task max;
    begin
        
        //Account for Negative 8 bit numbers
        if(a[7] == 1 && b[7] != 1) begin
            r = b;
            cc[3] = 1;
        end
        else if(a[7] != 1 && b[7] == 1) begin
            r = a;
            cc[2] = 1;
        end
        else if( a >= b)
        begin
            r = a;
            cc[2] = 1;
        end
        else
        begin 
            r = b;
            cc[3] = 1;
        end
        
        writeEnable = 1;
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
        
        writeEnable = 1;
    end
    endtask
        

endmodule
		
