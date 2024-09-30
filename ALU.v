module ALU (
    input [3:0] opcode,
    input [31:0] operandA,
    input [31:0] operandB,
    output reg [31:0] result,
    output reg zero
);
    
    always @(*) begin
        case (opcode)
            4'b0000: result = operandA + operandB; // ADD
            4'b0001: result = operandA - operandB; // SUB
            4'b0010: result = operandA & operandB; // AND
            4'b0011: result = operandA | operandB; // OR
            4'b0100: result = operandA ^ operandB; // XOR
            4'b0101: result = operandA << operandB[4:0]; // SLL
            4'b0110: result = operandA >> operandB[4:0]; // SRL
            4'b0111: result = (operandA < operandB) ? 32'h1 : 32'h0; // SLT
            default: result = 32'h0; // Unknown opcode
        endcase
        zero = (result == 32'h0);
    end
    
endmodule
