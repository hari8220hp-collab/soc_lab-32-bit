module tb_program_counter;

    reg         clk;
    reg         rstn;
    reg         pc_en;
    reg         branch_en;
    reg  [15:0] branch_target;
    wire [15:0] pc_out;

    // Instantiate DUT
    program_counter dut (
        .clk(clk),
        .rstn(rstn),
        .pc_en(pc_en),
        .branch_en(branch_en),
        .branch_target(branch_target),
        .pc_out(pc_out)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        $display("Time\t rstn pc_en branch_en branch_target pc_out");
        $monitor("%0t\t %b\t %b\t %b\t 0x%h\t 0x%h",
                 $time, rstn, pc_en, branch_en,
                 branch_target, pc_out);

        // Initialize
        rstn = 0;
        pc_en = 0;
        branch_en = 0;
        branch_target = 16'h0000;

        // Hold reset
        #12;
        rstn = 1;

        // Normal increment
        pc_en = 1;
        branch_en = 0;
        #30;

        // Branch to address 0x0010
        branch_target = 16'h0010;
        branch_en = 1;
        #10;

        // Continue sequential execution
        branch_en = 0;
        #20;

        // Stall PC
        pc_en = 0;
        #20;

        // Resume counting
        pc_en = 1;
        #20;

        // Another branch
        branch_target = 16'h00A0;
        branch_en = 1;
        #10;

        branch_en = 0;
        #20;

        $finish;
    end

    initial begin 
	    $dumpfile("tb.vcd");
	    $dumpvars(0,tb_program_counter);
    end
    

endmodule
