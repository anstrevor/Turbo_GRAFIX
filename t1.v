
module t1 (a, b, n, cc, r)

//Inputs
input a[7:0];
input b[7:0];
input n[2:0];

//Outputs
output r[7:0];
output cc[3:0];

//Define I/O
reg[7:0] a;
reg[7:0] b;
reg[3:0] n;

reg[7:0] r;
reg[3:0] cc;


always begin
	
	if (n[2]) == 1) 
		if (n[1] == 1)
			if (n[0] == 1)
				//111
			else
				//110
		else
			if (n[0] == 1)
                                //101
                        else
                                //100
	else
		


