module LOAD_UNIT (
    input wire [31:0] rs1_data,
    input wire [11:0] imm,
    input wire [1:0]  funct3,
    input wire clk , rst_n,
    output reg [31:0] result,
    output reg zero
);
    
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            result <= 0;
            zero <= 1;
        end
        else begin
            zero <= 0;
            case(funct3)
                2'b000: result <= rs1_data + imm; // LOAD (LW)
                2'b001: result <= rs1_data + imm; // LOAD HALF (LH)
                2'b010: result <= rs1_data + imm; // LOAD BYTE (LB)
                2'b100: result <= rs1_data + imm; // LOAD HALF UNSIGNED (LHU)
                2'b101: result <= rs1_data + imm; // LOAD BYTE UNSIGNED (LBU)
                default: result <= 0; // Unsupported instruction
            endcase
        end
    end

endmodule
