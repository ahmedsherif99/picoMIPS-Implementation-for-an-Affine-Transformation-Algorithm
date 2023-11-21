
module regs #(parameter n = 8) // n - data bus width
(input logic clk, w, // clk and write control
 input logic [n-1:0] Wdata,
 input logic [2:0] Raddr1, Raddr2,
 output logic [n-1:0] Rdata1, Rdata2,
input logic [8:0] SW,
output logic [7:0]out);

 	// Declare 4 n-bit registers 
	logic [n-1:0] gpr [3:0];
	assign out =gpr[1];
	// write process, dest reg is Raddr2
	always_ff @ (posedge clk)
	begin
		if (w)
            gpr[Raddr2-3] <= Wdata;

	end

	// read process, output 0 if %0 is selected, output SW[8] if %1,
	// output SW[7:0] if %2
	always_comb
	begin
	   if (Raddr1==3'd0)
	         Rdata1 =  {n{1'b0}};
	else if (Raddr1==3'b001)
		Rdata1={7'b0000000,SW[8]};
	else if (Raddr1==3'b010)
		Rdata1=SW[7:0];
        else  Rdata1 = gpr[Raddr1-3];
	 
        if (Raddr2==3'd0)
	        Rdata2 =  {n{1'b0}};

	else if (Raddr2==3'b010)
		Rdata2=SW[7:0];
	  else  Rdata2 = gpr[Raddr2-3];
	end	
	

endmodule // module regs