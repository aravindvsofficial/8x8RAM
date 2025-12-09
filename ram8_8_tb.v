`timescale 1ns/1ps

module ram8_8_tb;

    reg clk;
    reg rst;
    reg wr_enb;
    reg [3:0] wr_addr;
    reg [7:0] data_in;
    reg rd_enb;
    reg [3:0] rd_addr;
    wire [7:0] data_out;

    ram8_8 DUT (
        .clk(clk),
        .rst(rst),
        .wr_enb(wr_enb),
        .wr_addr(wr_addr),
        .data_in(data_in),
        .rd_enb(rd_enb),
        .rd_addr(rd_addr),
        .data_out(data_out)
    );

    always #5 clk = ~clk;   

    initial begin
        clk = 0;
        rst = 1;
        wr_enb = 0;
        rd_enb = 0;
        wr_addr = 0;
        rd_addr = 0;
        data_in = 0;

        #10;
        rst = 0;

        $display("Starting write operations...");
        
        write_to_ram(4'd0, 8'hA5);
        write_to_ram(4'd1, 8'h3C);
        write_to_ram(4'd2, 8'h7E);
        write_to_ram(4'd3, 8'h55);

        $display("Starting read operations...");

        read_from_ram(4'd0);
        read_from_ram(4'd1);
        read_from_ram(4'd2);
        read_from_ram(4'd3);

        #20;
        $display("Simulation Completed.");
        $finish;
    end

    task write_to_ram(input [3:0] addr, input [7:0] value);
    begin
        @(posedge clk);
        wr_enb = 1;
        wr_addr = addr;
        data_in = value;
        @(posedge clk);
        wr_enb = 0;
        $display("WRITE: addr=%0d, data=%h", addr, value);
    end
    endtask

    task read_from_ram(input [3:0] addr);
    begin
        @(posedge clk);
        rd_enb = 1;
        rd_addr = addr;
        @(posedge clk);
        rd_enb = 0;
        $display("READ: addr=%0d --> data_out=%h", addr, data_out);
    end
    endtask

endmodule
