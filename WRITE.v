module WRITE (

input wire clk,

input wire rst,

input wire control,

input wire enable,

output reg write_enable 
);

always @(posedge clk or posedge rst) begin

if (rst) begin

write_enable <= 0;

end 

else begin

write_enable <= 1 ;

end

end

endmodule

