
module REG2 (
    input wire clk,
    input wire [4:0] write_addr,
    input wire [31:0] write_data,
    input wire write_enable,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2
);

    reg [31:0] reg_file [31:0];

    always @(posedge clk) begin
        if (write_enable) begin
            reg_file[write_addr] <= write_data;
        end
        read_data1 <= reg_file[5'b00000];
        read_data2 <= reg_file[5'b00001];
    end

endmodule

