
module IMMEDIATE_ADDER (

input wire [31:0] operand,

input wire [31:0] immediate,

output wire [31:0] result
);

assign result = operand + immediate;

endmodule

