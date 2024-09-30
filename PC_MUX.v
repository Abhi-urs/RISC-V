module PC_MUX (

input wire [31:0] pc_if,

input wire [31:0] pc_id,

input wire pc_sel,

output reg [31:0] pc_out

);

always @(pc_sel or pc_if or pc_if)

begin

if (pc_sel == 1'b0)
    pc_out = pc_if;

else
pc_out = pc_id;

end

endmodule


