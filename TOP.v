module TOP
 (input msriscv32_mp_clk_in,
  input msriscv32_mp_rst_in,
  input [63:0] msriscv32_mp_rc_in,
  output[31:0] msriscv32_mp_imaddr_out,
  input [31:0] msriscv32_mp_instr_in,
  input msriscv32_mp_instr_hready_in,
  output[31:0] msriscv32_mp_dmaddr_out,
  output msriscv32_mp_dmwr_req_out,
  output[3:0] msriscv32_mp_dmwr_mask_out,
  output[3:0] msriscv32_mp_dmdata_out,
  input[31:0] msriscv32_mp_data_in,
  input msriscv32_mp_data_hready_in,
  input msriscv32_mp_hresp_in,
  output [1:0] msrisc32_mp_data_htrans_out,
  input msriscv32_mp_eirq_in,
  input  msriscv32_mp_tirq_in,
  input msriscv32_mp_sirq_in
  );
 
  wire [31:0] iaddr;
  wire [31:0] pc;
  wire [31:0] pc_plus_4;
  wire  misaligned_instr;
  wire [31:0] pc_mux;
  wire [31:0] rs2;  
  wire  mem_wr_req;
  wire flush;
  wire [6:0] opcode;
  wire [2:0] funct3;
  wire [6:0] funct7;
  wire [4:0] rs1_addr;
  wire [4:0] rs2_addr;
  wire [4:0] rd_addr;
  wire [11:0] csr_addr;
  wire [31:0] instr_31_to_7;
  wire [31:0] rs1;
  wire [31:0] imm;
  wire iaddr_src;
  wire wr_en_csr_file;
  wire wr_en_integer_file;
  wire [11:0] csr_addr_reg;
  wire [2:0]  csr_op_reg;
  wire [31:0] imm_reg;
  wire [31:0] rs1_reg;
  wire [31:0] pc_reg2;
  wire i_or_e;
  wire set_cause;
  wire [3:0] cause;
  wire set_epc;
  wire instret_inc;
  wire mie_clear;
  wire mie_set;
  wire misaligned_exception;
  wire mie;
  wire meie_out;
  wire mtie_out;
  wire msie_out;
  wire wr_en_in;
  wire [2:0] wb_mux_sel_reg;
  wire [31:0] lu_output;
  wire [31:0] alu_result;
  wire [31:0] csr_data;
  wire [31:0] pc_plus_4_reg;
  wire [31:0] iaddr_out_reg;
  wire [31:0] rs2_reg;
  wire alu_src_reg;
  wire [31:0] wb_mux_out;
  wire [31:0] alu_2nd_src_mux;
  wire illegal_instr;
  wire branch_taken;
  wire [31:0] next_pc;
  reg [31:0] pc_reg;
  wire misaligned_load;
  wire misaligned_store;
  wire [3:0] cause_in;
  wire [1:0] pc_src;
  wire trap_taken;
  wire [1:0] load_size_reg;
  wire [3:0] alu_opcode_reg;
  wire load_unsigned_reg;
  wire [31:0] iaddr_out;
  wire [31:0] epc;
  wire [31:0] trap_address;
  wire [3:0] alu_opcode;
  wire [3:0] mem_wr_mask;
  wire [1:0] load_size;
  wire load_unsigned;
  wire alu_src;
  wire csr_wr_en;
  wire rf_wr_en;
  wire [2:0] imm_type;
  wire [2:0] csr_op;
  wire [31:0] su_data_out;
  wire [31:0] su_d_addr;
  wire [3:0] su_wr_mask;
  wire su_wr_req;
      
    
   PC_MUX Pc(.rst_in(msriscv32_mp_rst_in),
   .ahb_ready_in(msriscv32_mp_instr_hready_in),
   .pc_src_in(pc_src),
   .epc_in(epc),
   .trap_address_in(trap_address),
   .branch_taken_in(branch_taken),
   .iaddr_in(iaddr[31:1]),
   .pc_in(pc),
   .pc_plus_4_out(pc_plus_4),
   .misaligned_instr_out(misaligned_instr),
   .pc_mux_out(pc_mux),
   .i_addr_out(msriscv32_mp_imaddr_out)
   );
   
   REG_1 reg1(.clk_in(msriscv32_mp_clk_in),
   .rst_in(msriscv32_mp_rst_in),
   .pc_mux_in(pc_mux),
   .pc_out(pc)
   );
   
   INSTRUCTION instruc(.flush_in(flush),
   .instr_in(msriscv32_mp_instr_in),
   .opcode_out(opcode),
   .funct3_out(funct3),
   .funct7_out(funct7),
   .rs1_addr_out(rs1_addr),
   .rs2_addr_out(rs2_addr),
   .rd_addr_out(rd_addr),
   .csr_addr_out(csr_addr),
   .instr_31_7_out(instr_31_to_7)
   );
   
    STORE_UNIT store(.funct3_in(funct3[1:0]),
   .ahb_ready_in(msriscv32_mp_data_hready_in),
   .iaddr_in(iaddr),
   .rs2_in(rs2),
   .data_out(ms_riscv32_mp_dmdata_out), 
   .d_addr_out(ms_riscv32_mp_dmaddr_out), 
   .wr_mask_out(ms_riscv32_mp_dmwr_mask_out), 
   .wr_req_out(ms_riscv32_mp_dmwr_req_out), 
   .ahb_htrans_out (ms_riscv32_mp_data_htrans_out)
   );
   
    DECODER dec (.opcode_in(opcode),

   .funct7_5_in(funct7[5]),

   .funct3_in(funct3),
 
   .iadder_1_to_0_in(iaddr[1:0]),

   .trap_taken_in (trap_taken),

   .alu_opcode_out(alu_opcode),

   .mem_wr_req_out (mem_wr_req),

   .load_size_out (load_size),

   .load_unsigned_out (load_unsigned),

   .alu_src_out(alu_src),

   .iadder_src_out(iadder_src),

   .csr_wr_en_out(csr_wr_en),

   .rf_wr_en_out(rf_wr_en),

   .wb_mux_sel_out(wb_mux_sel), 
    
   .imm_type_out (imm_type), 
  
   .csr_op_out(csr_op), 
  
   .illegal_instr_out(illegal_instr), 
   
   .misaligned_load_out (misaligned_load), 
  
   .misaligned_store_out (misaligned_store)
 );
 
  IMMEDIATE_GEN imM(
 .instr_in(instr_31_to_7),
 .imm_type_in(imm_type),
 .imm_out(imm)
 );
 
   IMMEDIATE_ADDER imma(
  .pc_in(pc),
  .rs1_in(rs1),
  .imm_in(imm),
  .iadder_src_in(iaddr_src),
  .iadder_out(iaddr)
  );
   
    WRITE wren (.flush_in (flush), 
   .rf_wr_en_reg_in(rf_wr_en_reg), 
   .csr_wr_en_reg_in (csr_wr_en_reg), 
   .wr_en_integer_file_out (integer_wr_en_reg_file), 
   .wr_en_csr_file_out (csr_wr_en_reg_file)
   );
   
     INTEGER int(.msriscv32_mp_clk_in(clk_in),
   .msriscv32_mp_rst_in(rst_in),
   .rs2_addr(rs_2_addr_out),
   .rd_addr(rd_addr_out),
   .wr_en_in(wr_on),
   .rd_in(rd_in),
   .rs1_addr(rs_1_addr_out),
   .rs1_out(rs_1_out),
   .rs2_out(rs_2_out)
   );
   
   BRANCH_UNIT branch_unit(.rs1_in(rs1_out) ,
    .rs2_in(rs_2_out), 
    .opcode_in(opcode),
    .funct3_in(funct3), 
    .branch_taken_out(branch_taken)
    );
    
    REG2 reg2(

 .clk_in(clk_in),
 .rst_in(rst_in),

.rd_addr_in (rd_addr_out),

.csr_addr_in(csr_addr_out),

.rs1_in(rs_1_out),

.rs2_in(rs_2_out),

.pc_in(pc_in),

.pc_plus_4_in(pc_plus_4),

.branch_taken_in (branch_taken), 
.iadder_in(iadder),

.alu_opcode_in(alu_opcode_out),

.load_size_in(load_size_out), 
.load_unsigned_in(load_unsigned_out),
.alu_src_in(alu_src_out),
.csr_wr_en_in(csr_wr_en_out), 
.rf_wr_en_in(rf_wr_en_out),
.wb_mux_sel_in (wb_mux_sel_in), 
.csr_op_in(csr_op_in),
.imm_in(imm_in),
.rd_addr_reg_out(rd_addr_reg_out), 
.csr_addr_reg_out(csr_addr_in),
.rsl_out(csr_data_in),
.rs2_out(rs2_reg_out),
.pc_reg_out(pc_in),
.pc_plus_4_reg_out (pc_plus_4_reg_out), 
.iadder_out_reg_out(iaddr_in) ,
.alu_opcode_reg_out (alu_opcode_reg_out),
.Load_size_reg_out (load_size_reg_out), 
.Load_unsigned_reg_out(load_unsigned_reg_out),
.alu_src_reg_out(alu_src_reg_out),
.csr_wr_en_reg_out (csr_wr_en_reg_out),
.rf_wr_en_reg_out(rf_wr_en_reg_out), 
.wb_mux_sel_reg_out (wb_mux_sel_reg_out), 
.car_op_reg_out(csr_op_in),
.imm_reg_out (imm_reg_out)
);




ALU alu (
  .op_1_in(rs1_reg),
  .op_2_in(alu_2nd_src_mux), 
  .opcode_in (alu_opcode_reg),
  .result_out(alu_result)
   );
   
 endmodule
 

   
   


   

  
 
   
   
   
   
    
   
               
  
  
  
  
  
  
  
  
  
  
