module timer_counter(

    input wire clk,rst_n ,write_en , read_en,
    input wire [7:0] addr,
    input wire [31:0] wdata,
    output reg [31:0] rdata,
    output reg ready, timer_irq

);

localparam LOAD   = 8'h00,COUNT  = 8'h04, CTRL   = 8'h08,STATUS = 8'h0C;

reg [31:0] timer_load, timer_count;
reg ctrl_en, ctrl_auto_reload , status_timeout;


// Ready operation
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        ready <= 0;
    else
        ready <= (write_en || read_en) && !ready;
end

// tish is for inityialy set or move the value

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
        timer_load <= 0;
        timer_count <= 0;
        ctrl_en <= 0;
        ctrl_auto_reload <= 0;
        status_timeout <= 0;
        timer_irq <= 0;
    end
    else
    begin
        timer_irq <= 0;

        // ithu  Register Write ku
        if(write_en)
        begin
            case(addr)
                LOAD   : timer_load <= wdata;
                CTRL :
                begin
                    ctrl_en <= wdata[0];
                    ctrl_auto_reload <= wdata[1];
                end
                STATUS :
                    if(wdata[0])
                        status_timeout <= 0;
            endcase
        end

        // ithu Timer Operation ku
        if(ctrl_en)
        begin
            if(timer_count == 0)
            begin
                if(!status_timeout)
                    timer_count <= timer_load;
                else
                begin
                    timer_irq <= 1;

                    if(ctrl_auto_reload)
                        timer_count <= timer_load;
                end
            end
            else
                timer_count <= timer_count - 1;
        end
    end
end



always @(*)
begin
    case(addr)
        LOAD   : rdata = timer_load;
        COUNT  : rdata = timer_count;
        CTRL   : rdata = {30'd0, ctrl_auto_reload, ctrl_en};
        STATUS : rdata = {31'd0, status_timeout};
        default: rdata = 32'd0;
    endcase
end

endmodule




