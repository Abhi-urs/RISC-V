module IMMEDIATE_GEN (

input [31:0] ins, input [2:0] imm_type_in,

input wire [1:0] opcode,

input wire clk, rst,

output reg [31:0] immediate_out);

reg [31:0] imm_temp;

reg [5:0] imm_type_out;

always @(posedge clk or posedge rst) begin

if (rst) begin

imm_temp <= 0;

imm_type_out <= 0;

end

else begin

case (imm_type_in)

3'b000: imm_temp <= {ins [31], ins[31:21]};

3'b001: imm_temp <= {ins [31], ins [31:12]}; 

3'b110: imm_temp <= {ins [31], ins[31:25]};

3'b011: imm_temp <= {ins [31], ins [31:10]};

default: imm_temp <= 0;

endcase

imm_type_out =  imm_type_in;
end

end

always @(posedge clk or posedge rst) begin

if (rst) begin

immediate_out <= 0;

end

else begin

case (opcode)

2'b00,2'b01,2'b10,2'b11:immediate_out <= imm_temp;

default: immediate_out <= imm_temp;

endcase

end

end

endmodule
