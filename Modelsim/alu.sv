
`include "alucodes.sv"  
module alu #(parameter n =8) (
   input logic [n-1:0] a, b, // ALU operands
   input logic [2:0] func, // ALU function code
   output logic flag, // ALU flags V,N,Z,C
   output logic [n-1:0] result // ALU result
);       
//------------- code starts here ---------

// create an n-bit adder 
// and then build the ALU around the adder
logic[n-1:0] ar,b1; // temp signals
logic [15:0]Rmul;
signed_mult m(.out(Rmul), .a(a), .b({b[n-2:0],1'b0}));
always_comb
begin
   if((func==`RSUB)||(func==`RSUBI))
      b1 = ~b + 1'b1; // 2's complement subtrahend
   else b1 = b;

   ar = a+b1; // n-bit adder
end // always_comb
   
// create the ALU, use signal ar in arithmetic operations
always_comb
begin
  //default output values; prevent latches 
  flag = 1'b0;
  result = a; // default
  case(func)
  	`RA : result = a;
	//`RB   : result = b;
     `RADD, `RADDI, `RSUB,  `RSUBI  : begin
	     result = ar; // arithmetic addition

		end

    `RMUL  : result = Rmul[14:7];
   endcase
	 
 
    // calculate flags Z and N
  flag = result == {n{1'b0}}; // Z

 
 end //always_comb

endmodule //end of module ALU


