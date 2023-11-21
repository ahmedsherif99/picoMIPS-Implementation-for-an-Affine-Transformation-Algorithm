// signed multiplier 
module signed_mult(output logic signed [15:0] out, input logic signed [7:0] a, b); 
	assign out = a * b; 
endmodule