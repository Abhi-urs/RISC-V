module DECODER(
    input [2:0] opcode,
    output [7:0] control_signals
);

assign control_signals = (opcode == 3'b000) ? 8'b00000001 :
                        (opcode == 3'b001) ? 8'b00000010 :
                        (opcode == 3'b010) ? 8'b00000100 :
                        (opcode == 3'b011) ? 8'b00001000 :
                        (opcode == 3'b100) ? 8'b00010000 :
                        (opcode == 3'b101) ? 8'b00100000 :
                        (opcode == 3'b110) ? 8'b01000000 :
                        (opcode == 3'b111) ? 8'b10000000 :
                        8'b00000000;

endmodule

