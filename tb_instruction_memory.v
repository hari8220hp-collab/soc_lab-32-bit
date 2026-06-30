module tb_instruction_memory;

reg  [7:0] addr;
wire [15:0] instruction;

instruction_memory uut (
    .addr(addr),
    .instruction(instruction)
);

initial begin
    $display("Time\tAddr\tInstruction");
    $monitor("%0t\t%0d\t%h", $time, addr, instruction);

    addr = 8'd0;
    #10;

    addr = 8'd1;
    #10;

    addr = 8'd2;
    #10;

    addr = 8'd3;
    #10;

    addr = 8'd4;   
    #10;

    $finish;
end
initial begin
	$dumpfile("tb.vcd");
	$dumpvars(0,tb_instruction_memory);
end
endmodule
