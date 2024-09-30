module BRANCH_UNIT (

input wire [6:0] opcode,

input wire [6:0] funct3,

input wire [31:0] imm,

output wire branch_taken,

output wire [31:0] branch_target
);

assign branch_taken = (opcode==7'b1101111) || ((opcode==7'b1100111) && (funct3 == 3'b000));

assign branch_target = (branch_taken) ? imm : 32'b0;

endmodule
