module ram8_8(
    input clk,
    input rst,
    input wr_enb,
    input [3:0]wr_addr,
    input [7:0]data_in,
    input rd_enb,
    input [3:0]rd_addr,
    output reg [7:0]data_out
);

    reg [7:0] mem [7:0];
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 8; i = i + 1)
                mem[i] <= 8'd0;
        end
        else if (wr_enb) begin
            mem[wr_addr] <= data_in;
        end
    end

    always @(posedge clk) begin
        if (rd_enb)
            data_out <= mem[rd_addr];
    end

endmodule

