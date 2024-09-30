
module REG_1(

input wire clk,

input wire reset, 

input wire write_en, 

input wire [0:0] data_in, 

output wire [0:0] data_out
); 

reg [0:0] reg_data; 
always @(posedge clk or posedge reset) begin 
if (reset) begin 
reg_data <= 1'b0; 
end 
else if (write_en) begin

reg_data = data_in;

end

end

assign data_out = reg_data;
endmodule