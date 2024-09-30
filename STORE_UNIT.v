
module STORE_UNIT (
    input wire [31:0] data_in,  // Data to be stored
    input wire [31:0] address,  // Memory address
    input wire write_enable,    // Control signal to enable write
    output wire mem_write       // Memory write control signal
);

assign mem_write = (write_enable) ? 1'b1 : 1'b0;

endmodule

