

module testbench;

logic clock; 
logic[7:0] LED;
logic [9:0] SW;

picoMIPS4test pico0(
  .fastclk(clock),  // 50MHz Altera DE0 clock
  .SW(SW), // Switches SW0..SW9
  .LED(LED));

initial 
begin
  clock = 1'b0; 
  forever #10ns clock = ~clock; 
end

initial
  begin
  SW[9] = '0;
  #50ns SW[9] = '1;
  #10ns SW[9] = '0;
  SW[8] = '0;
#50ns SW[7:0]= 8'b00000100;
  #70ns SW[8] = '1;
  #100ns SW[8] = '0;
  #10ns SW[7:0]= 8'b00001000;
  #60ns SW[8] = '1;
  #60ns SW[8] = '0;
  #300ns SW[8] = '1;
  #100ns SW[8] = '0;
#50ns SW[7:0]= 8'b00010000;
  #70ns SW[8] = '1;
  #100ns SW[8] = '0;
   #10ns SW[7:0]= 8'b00100000;
  #60ns SW[8] = '1;
  #60ns SW[8] = '0;
  #300ns SW[8] = '1;
  #100ns SW[8] = '0;
  end

endmodule