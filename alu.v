module  alu (
	input [3:0] a,
	input [3:0] b,
	input [3:0] op,
        output reg [3:0]y,
	output reg zero,
	output reg carry,
	output reg ovfl
 );
 always @ (*) begin
	 y=4'b0000;
    case (op)
	    
	    4'b0000: y=(a+b);
            4'b0001: y=(a-b);
	    4'b0010: y=(a&&b);
	    4'b0011: y=(a||b);
	    4'b0100: y=(a^b);
	    4'b0101: y=(! a);
	    4'b0110: y=(a<<b);
	    4'b0111: y=(a>>b);
     endcase
  end
  endmodule
