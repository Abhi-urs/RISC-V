module WB (
    input wire [31:0] data1,  // Input data from Execution Unit 1
    input wire [31:0] data2,  // Input data from Execution Unit 2
    input wire write_enable, // Control signal to enable writing back to the register file
    output wire [31:0] result // Output data to be written back
);

assign result = (write_enable) ? data1 : data2;

endmodule

