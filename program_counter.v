module program_counter (
    input  wire        clk,
    input  wire        rstn,           // Active-low asynchronous reset
    input  wire        pc_en,          // PC enable
    input  wire        branch_en,      // Branch enable
    input  wire [15:0] branch_target,  // Branch target address
    output reg  [15:0] pc_out
);

always @(posedge clk or negedge rstn) begin
    if (!rstn)
        pc_out <= 16'h0000;            // Reset PC to 0
    else if (pc_en) begin
        if (branch_en)
            pc_out <= branch_target;   // Jump/branch
        else
            pc_out <= pc_out + 16'd1;  // Sequential execution
    end
    else
        pc_out <= pc_out;              // Hold (stall)
end

endmodule




