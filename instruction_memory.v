module instruction_memory(
    input  [7:0] addr,
    output [15:0] instruction
);

reg [15:0] mem [0:255];

initial begin
    mem[0] = 16'h1234;
    mem[1] = 16'h5678;
    mem[2] = 16'h9ABC;
    mem[3] = 16'hDEF0;
end
assign instruction = mem[addr];

endmodule
