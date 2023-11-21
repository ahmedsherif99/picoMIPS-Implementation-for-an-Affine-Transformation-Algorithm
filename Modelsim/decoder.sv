

`include "alucodes.sv"
`include "opcodes.sv"
//---------------------------------------------------------
module decoder
( input logic [2:0] opcode, // top 6 bits of instruction
input flag, // ALU flags
// output signals
//    PC control
output logic PCincr,/*PCabsbranch,*/PCrelbranch,
//    ALU control
output logic [2:0] ALUfunc, 
// imm mux control
output logic imm,
//   register file control
output logic w
  );
   
//------------- code starts here ---------
// instruction decoder
logic takeBranch; // temp variable to control conditional branching
always_comb 
begin
  // set default output signal values for NOP instruction
   PCincr = 1'b1; // PC increments by default
 PCrelbranch = 1'b0;
   ALUfunc = opcode[2:0]; 
   imm=1'b0; w=1'b0; 
   takeBranch =  1'b0; 
   case(opcode)

     `ADD, `LDI : begin // register-register
	        w = 1'b1; // write result to dest register
	      end
     `ADDI, `MUL: begin // register-immediate
	        w = 1'b1; // write result to dest register
		  imm = 1'b1; // set ctrl signal for imm operand MUX
	      end
	 	  
    // branches
	`BEQ: takeBranch = flag; // branch if Z==1
	`BNE: takeBranch = ~flag; // branch if Z==0

	default:
	    $error("unimplemented opcode %h",opcode);
 
  endcase // opcode
  
   if(takeBranch) // branch condition is true;
   begin
	PCincr = 1'b0;
	PCrelbranch = 1'b1; 
   end


end // always_comb


endmodule //module decoder --------------------------------