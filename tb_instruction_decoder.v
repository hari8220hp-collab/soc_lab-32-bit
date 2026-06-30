module tb_instruction_decoder;

    reg  [15:0] instr;
    reg         zero_flag;

    wire [3:0] opcode;
    wire [3:0] rd_addr;
    wire [3:0] rs1_addr;
    wire [3:0] rs2_addr;
    wire [7:0] imm;
    wire [3:0] alu_op;
    wire       reg_wr_en;
    wire       imm_sel;
    wire       branch_en;

    instruction_decoder DUT (
        .instr(instr),
        .zero_flag(zero_flag),
        .opcode(opcode),
        .rd_addr(rd_addr),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .imm(imm),
        .alu_op(alu_op),
        .reg_wr_en(reg_wr_en),
        .imm_sel(imm_sel),
        .branch_en(branch_en)
    );

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb_instruction_decoder);
    end

    initial begin

        $display("-----------------");
        $display("Time  Instr   OPC RD RS1 RS2 IMM ALU WR IM BR");
        $display("-----------------");

        $monitor("%0t %h %h %h %h %h %h %h %b %b %b",
                  $time, instr, opcode, rd_addr,
                  rs1_addr, rs2_addr, imm,
                  alu_op, reg_wr_en,
                  imm_sel, branch_en);

        
        zero_flag = 0;
        instr = 16'b0000_0001_0010_0011;
        #10;

        
        instr = 16'b0001_0100_0101_0110;
        #10;

        
        instr = 16'b0010_0010_0011_0101;
        #10;

       
        instr = 16'b0011_0111_0001_0010;
        #10;

      
        instr = 16'b0100_1000_0011_0100;
        #10;

      
        instr = 16'b1000_0000_0000_0011;
        zero_flag = 0;
        #10;

       
        zero_flag = 1;
        #10;

        $finish;#100;
 end
endmodule
