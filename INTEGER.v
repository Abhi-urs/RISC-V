module INTEGER(

input wire [4:0] address,

input wire clk,

input wire write_enable,

 input wire [21:0] data_in,

output reg [31:0] data_out
);

reg [31:0] memory [0:31]; 

always @(posedge clk) begin

if (write_enable) begin 
   memory[address] <= data_in;

end

data_out <= memory [address];
end


endmodule