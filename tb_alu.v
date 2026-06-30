module tb_alu;
reg [3:0]a;
reg [3:0]b;
reg [3:0]op;
wire [3:0]y;
wire zero;
wire carry;
wire ovfl;

alu uut(
	.a(a),
	.b(b),
	.op(op),
	.y(y),
	.zero(zero),
	.carry(carry),
	.ovfl(ovfl)
);
initial begin
	op=4'b0000; a=4'h2; b=4'h2; #10;
	op=4'b0001; a=4'h2; b=4'h2; #10;
	op=4'b0010; a=4'h2; b=4'h2; #10;
	op=4'b0011; a=4'h2; b=4'h2; #10;
	op=4'b0101; a=4'h2; b=4'h2; #10;
	op=4'b0100; a=4'h2; b=4'h2; #10;
	op=4'b0110; a=4'h2; b=4'h2; #10;
	op=4'b0111; a=4'h2; b=4'h2; #10;

	$finish;#100;
end
initial begin
	$dumpfile("tb.fsdb");
	$dumpvars(0,tb_alu);
end
endmodule



