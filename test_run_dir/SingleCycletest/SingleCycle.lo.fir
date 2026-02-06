circuit SingleCycle :
  module Programcounter :
    input clock : Clock
    input reset : UInt<1>
    input io_in : SInt<32>
    output io_out : SInt<32>
    output io_pc4 : SInt<32>

    reg reg : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg) @[Programcounter.scala 11:22]
    node _io_pc4_T = add(reg, asSInt(UInt<4>("h4"))) @[Programcounter.scala 13:19]
    node _io_pc4_T_1 = tail(_io_pc4_T, 1) @[Programcounter.scala 13:19]
    node _io_pc4_T_2 = asSInt(_io_pc4_T_1) @[Programcounter.scala 13:19]
    io_out <= reg @[Programcounter.scala 14:12]
    io_pc4 <= _io_pc4_T_2 @[Programcounter.scala 13:12]
    reg <= mux(reset, asSInt(UInt<32>("h0")), io_in) @[Programcounter.scala 11:22 Programcounter.scala 11:22 Programcounter.scala 12:9]

  module InstructionMemory :
    input clock : Clock
    input reset : UInt<1>
    input io_readadress : UInt<24>
    output io_readdata : UInt<32>

    mem mem : @[InstructionMemory.scala 12:18]
      data-type => UInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => io_readdata_MPORT
      read-under-write => undefined
    node _io_readdata_T = bits(io_readadress, 9, 0) @[InstructionMemory.scala 14:23]
    io_readdata <= mem.io_readdata_MPORT.data @[InstructionMemory.scala 14:17]
    mem.io_readdata_MPORT.addr <= _io_readdata_T @[InstructionMemory.scala 14:23]
    mem.io_readdata_MPORT.en <= UInt<1>("h1") @[InstructionMemory.scala 14:23]
    mem.io_readdata_MPORT.clk <= clock @[InstructionMemory.scala 14:23]

  module ImmediateGeneration :
    input clock : Clock
    input reset : UInt<1>
    input io_instruction : UInt<32>
    output io_immd_se : UInt<32>

    node opcode = bits(io_instruction, 6, 0) @[ImmediateGeneration.scala 10:36]
    node _T = eq(UInt<2>("h3"), opcode) @[Conditional.scala 37:30]
    node imm_i = bits(io_instruction, 31, 20) @[ImmediateGeneration.scala 18:33]
    node _T_1 = eq(UInt<4>("hf"), opcode) @[Conditional.scala 37:30]
    node imm_i_1 = bits(io_instruction, 31, 20) @[ImmediateGeneration.scala 22:33]
    node _T_2 = eq(UInt<5>("h13"), opcode) @[Conditional.scala 37:30]
    node imm_i_2 = bits(io_instruction, 31, 20) @[ImmediateGeneration.scala 26:33]
    node _T_3 = eq(UInt<7>("h67"), opcode) @[Conditional.scala 37:30]
    node imm_i_3 = bits(io_instruction, 31, 20) @[ImmediateGeneration.scala 30:33]
    node _T_4 = eq(UInt<7>("h73"), opcode) @[Conditional.scala 37:30]
    node imm_i_4 = bits(io_instruction, 31, 20) @[ImmediateGeneration.scala 34:33]
    node _T_5 = eq(UInt<6>("h23"), opcode) @[Conditional.scala 37:30]
    node imm_s_hi = bits(io_instruction, 31, 25) @[ImmediateGeneration.scala 38:37]
    node imm_s_lo = bits(io_instruction, 11, 7) @[ImmediateGeneration.scala 38:59]
    node imm_s = cat(imm_s_hi, imm_s_lo) @[Cat.scala 30:58]
    node _T_6 = eq(UInt<7>("h63"), opcode) @[Conditional.scala 37:30]
    node imm_b_hi_hi = bits(io_instruction, 31, 31) @[ImmediateGeneration.scala 42:37]
    node imm_b_hi_lo = bits(io_instruction, 7, 7) @[ImmediateGeneration.scala 42:56]
    node imm_b_lo_hi = bits(io_instruction, 30, 25) @[ImmediateGeneration.scala 42:74]
    node imm_b_lo_lo = bits(io_instruction, 11, 8) @[ImmediateGeneration.scala 42:96]
    node imm_b_lo = cat(imm_b_lo_hi, imm_b_lo_lo) @[Cat.scala 30:58]
    node imm_b_hi = cat(imm_b_hi_hi, imm_b_hi_lo) @[Cat.scala 30:58]
    node imm_b = cat(imm_b_hi, imm_b_lo) @[Cat.scala 30:58]
    node _T_7 = eq(UInt<5>("h17"), opcode) @[Conditional.scala 37:30]
    node imm_u = bits(io_instruction, 31, 12) @[ImmediateGeneration.scala 46:33]
    node _T_8 = eq(UInt<6>("h37"), opcode) @[Conditional.scala 37:30]
    node imm_u_1 = bits(io_instruction, 31, 12) @[ImmediateGeneration.scala 50:33]
    node _T_9 = eq(UInt<7>("h6f"), opcode) @[Conditional.scala 37:30]
    node imm_j_hi_hi = bits(io_instruction, 31, 31) @[ImmediateGeneration.scala 54:37]
    node imm_j_hi_lo = bits(io_instruction, 19, 12) @[ImmediateGeneration.scala 54:56]
    node imm_j_lo_hi = bits(io_instruction, 20, 20) @[ImmediateGeneration.scala 54:78]
    node imm_j_lo_lo = bits(io_instruction, 30, 21) @[ImmediateGeneration.scala 54:97]
    node imm_j_lo = cat(imm_j_lo_hi, imm_j_lo_lo) @[Cat.scala 30:58]
    node imm_j_hi = cat(imm_j_hi_hi, imm_j_hi_lo) @[Cat.scala 30:58]
    node imm_j = cat(imm_j_hi, imm_j_lo) @[Cat.scala 30:58]
    node _GEN_0 = mux(_T_9, imm_j, UInt<32>("h0")) @[Conditional.scala 39:67 ImmediateGeneration.scala 55:15 ImmediateGeneration.scala 14:13]
    node _GEN_1 = mux(_T_8, imm_u_1, _GEN_0) @[Conditional.scala 39:67 ImmediateGeneration.scala 51:15]
    node _GEN_2 = mux(_T_7, imm_u, _GEN_1) @[Conditional.scala 39:67 ImmediateGeneration.scala 47:15]
    node _GEN_3 = mux(_T_6, imm_b, _GEN_2) @[Conditional.scala 39:67 ImmediateGeneration.scala 43:15]
    node _GEN_4 = mux(_T_5, imm_s, _GEN_3) @[Conditional.scala 39:67 ImmediateGeneration.scala 39:15]
    node _GEN_5 = mux(_T_4, imm_i_4, _GEN_4) @[Conditional.scala 39:67 ImmediateGeneration.scala 35:15]
    node _GEN_6 = mux(_T_3, imm_i_3, _GEN_5) @[Conditional.scala 39:67 ImmediateGeneration.scala 31:15]
    node _GEN_7 = mux(_T_2, imm_i_2, _GEN_6) @[Conditional.scala 39:67 ImmediateGeneration.scala 27:15]
    node _GEN_8 = mux(_T_1, imm_i_1, _GEN_7) @[Conditional.scala 39:67 ImmediateGeneration.scala 23:15]
    node _GEN_9 = mux(_T, imm_i, _GEN_8) @[Conditional.scala 40:58 ImmediateGeneration.scala 19:15]
    node immd_se = _GEN_9 @[ImmediateGeneration.scala 12:27]
    io_immd_se <= immd_se @[ImmediateGeneration.scala 58:14]

  module InstructionDecoder :
    input clock : Clock
    input reset : UInt<1>
    input io_instruction : UInt<32>
    output io_opcode : UInt<7>
    output io_rd : UInt<5>
    output io_func7 : UInt<7>
    output io_func3 : UInt<3>
    output io_rs1 : UInt<5>
    output io_rs2 : UInt<5>

    node opcode = bits(io_instruction, 6, 0) @[InstructionDecoder.scala 16:36]
    node rd = bits(io_instruction, 11, 7) @[InstructionDecoder.scala 17:32]
    node func7 = bits(io_instruction, 31, 25) @[InstructionDecoder.scala 18:35]
    node func3 = bits(io_instruction, 14, 12) @[InstructionDecoder.scala 19:35]
    node rs1 = bits(io_instruction, 19, 15) @[InstructionDecoder.scala 20:33]
    node rs2 = bits(io_instruction, 24, 20) @[InstructionDecoder.scala 21:33]
    io_opcode <= opcode @[InstructionDecoder.scala 23:19]
    io_rd <= rd @[InstructionDecoder.scala 24:15]
    io_func7 <= func7 @[InstructionDecoder.scala 25:18]
    io_func3 <= func3 @[InstructionDecoder.scala 26:18]
    io_rs1 <= rs1 @[InstructionDecoder.scala 27:16]
    io_rs2 <= rs2 @[InstructionDecoder.scala 28:16]

  module TypeDecoder :
    input clock : Clock
    input reset : UInt<1>
    input io_opcode : UInt<6>
    output io_r_out : UInt<1>
    output io_load_out : UInt<1>
    output io_store_out : UInt<1>
    output io_sb_out : UInt<1>
    output io_i_out : UInt<1>
    output io_jal_out : UInt<1>
    output io_jalr_out : UInt<1>
    output io_lui_out : UInt<1>

    node _T = eq(io_opcode, UInt<2>("h3")) @[TypeDecoder.scala 27:20]
    node _T_1 = eq(io_opcode, UInt<4>("hf")) @[TypeDecoder.scala 29:26]
    node _T_2 = eq(io_opcode, UInt<5>("h13")) @[TypeDecoder.scala 29:55]
    node _T_3 = or(_T_1, _T_2) @[TypeDecoder.scala 29:43]
    node _T_4 = eq(io_opcode, UInt<7>("h73")) @[TypeDecoder.scala 29:84]
    node _T_5 = or(_T_3, _T_4) @[TypeDecoder.scala 29:72]
    node _T_6 = eq(io_opcode, UInt<7>("h67")) @[TypeDecoder.scala 31:26]
    node _T_7 = eq(io_opcode, UInt<6>("h23")) @[TypeDecoder.scala 33:26]
    node _T_8 = eq(io_opcode, UInt<6>("h33")) @[TypeDecoder.scala 35:26]
    node _T_9 = eq(io_opcode, UInt<7>("h63")) @[TypeDecoder.scala 37:26]
    node _T_10 = eq(io_opcode, UInt<7>("h6f")) @[TypeDecoder.scala 39:26]
    node _T_11 = eq(io_opcode, UInt<6>("h37")) @[TypeDecoder.scala 41:26]
    node _GEN_0 = mux(_T_11, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 41:44 TypeDecoder.scala 42:20 TypeDecoder.scala 24:16]
    node _GEN_1 = mux(_T_10, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 39:44 TypeDecoder.scala 40:20 TypeDecoder.scala 23:16]
    node _GEN_2 = mux(_T_10, UInt<1>("h0"), _GEN_0) @[TypeDecoder.scala 39:44 TypeDecoder.scala 24:16]
    node _GEN_3 = mux(_T_9, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 37:44 TypeDecoder.scala 38:19 TypeDecoder.scala 20:15]
    node _GEN_4 = mux(_T_9, UInt<1>("h0"), _GEN_1) @[TypeDecoder.scala 37:44 TypeDecoder.scala 23:16]
    node _GEN_5 = mux(_T_9, UInt<1>("h0"), _GEN_2) @[TypeDecoder.scala 37:44 TypeDecoder.scala 24:16]
    node _GEN_6 = mux(_T_8, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 35:44 TypeDecoder.scala 36:18 TypeDecoder.scala 19:14]
    node _GEN_7 = mux(_T_8, UInt<1>("h0"), _GEN_3) @[TypeDecoder.scala 35:44 TypeDecoder.scala 20:15]
    node _GEN_8 = mux(_T_8, UInt<1>("h0"), _GEN_4) @[TypeDecoder.scala 35:44 TypeDecoder.scala 23:16]
    node _GEN_9 = mux(_T_8, UInt<1>("h0"), _GEN_5) @[TypeDecoder.scala 35:44 TypeDecoder.scala 24:16]
    node _GEN_10 = mux(_T_7, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 33:44 TypeDecoder.scala 34:22 TypeDecoder.scala 21:18]
    node _GEN_11 = mux(_T_7, UInt<1>("h0"), _GEN_6) @[TypeDecoder.scala 33:44 TypeDecoder.scala 19:14]
    node _GEN_12 = mux(_T_7, UInt<1>("h0"), _GEN_7) @[TypeDecoder.scala 33:44 TypeDecoder.scala 20:15]
    node _GEN_13 = mux(_T_7, UInt<1>("h0"), _GEN_8) @[TypeDecoder.scala 33:44 TypeDecoder.scala 23:16]
    node _GEN_14 = mux(_T_7, UInt<1>("h0"), _GEN_9) @[TypeDecoder.scala 33:44 TypeDecoder.scala 24:16]
    node _GEN_15 = mux(_T_6, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 31:44 TypeDecoder.scala 32:21 TypeDecoder.scala 25:17]
    node _GEN_16 = mux(_T_6, UInt<1>("h0"), _GEN_10) @[TypeDecoder.scala 31:44 TypeDecoder.scala 21:18]
    node _GEN_17 = mux(_T_6, UInt<1>("h0"), _GEN_11) @[TypeDecoder.scala 31:44 TypeDecoder.scala 19:14]
    node _GEN_18 = mux(_T_6, UInt<1>("h0"), _GEN_12) @[TypeDecoder.scala 31:44 TypeDecoder.scala 20:15]
    node _GEN_19 = mux(_T_6, UInt<1>("h0"), _GEN_13) @[TypeDecoder.scala 31:44 TypeDecoder.scala 23:16]
    node _GEN_20 = mux(_T_6, UInt<1>("h0"), _GEN_14) @[TypeDecoder.scala 31:44 TypeDecoder.scala 24:16]
    node _GEN_21 = mux(_T_5, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 29:102 TypeDecoder.scala 30:18 TypeDecoder.scala 22:14]
    node _GEN_22 = mux(_T_5, UInt<1>("h0"), _GEN_15) @[TypeDecoder.scala 29:102 TypeDecoder.scala 25:17]
    node _GEN_23 = mux(_T_5, UInt<1>("h0"), _GEN_16) @[TypeDecoder.scala 29:102 TypeDecoder.scala 21:18]
    node _GEN_24 = mux(_T_5, UInt<1>("h0"), _GEN_17) @[TypeDecoder.scala 29:102 TypeDecoder.scala 19:14]
    node _GEN_25 = mux(_T_5, UInt<1>("h0"), _GEN_18) @[TypeDecoder.scala 29:102 TypeDecoder.scala 20:15]
    node _GEN_26 = mux(_T_5, UInt<1>("h0"), _GEN_19) @[TypeDecoder.scala 29:102 TypeDecoder.scala 23:16]
    node _GEN_27 = mux(_T_5, UInt<1>("h0"), _GEN_20) @[TypeDecoder.scala 29:102 TypeDecoder.scala 24:16]
    node _GEN_28 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 27:37 TypeDecoder.scala 28:21 TypeDecoder.scala 18:17]
    node _GEN_29 = mux(_T, UInt<1>("h0"), _GEN_21) @[TypeDecoder.scala 27:37 TypeDecoder.scala 22:14]
    node _GEN_30 = mux(_T, UInt<1>("h0"), _GEN_22) @[TypeDecoder.scala 27:37 TypeDecoder.scala 25:17]
    node _GEN_31 = mux(_T, UInt<1>("h0"), _GEN_23) @[TypeDecoder.scala 27:37 TypeDecoder.scala 21:18]
    node _GEN_32 = mux(_T, UInt<1>("h0"), _GEN_24) @[TypeDecoder.scala 27:37 TypeDecoder.scala 19:14]
    node _GEN_33 = mux(_T, UInt<1>("h0"), _GEN_25) @[TypeDecoder.scala 27:37 TypeDecoder.scala 20:15]
    node _GEN_34 = mux(_T, UInt<1>("h0"), _GEN_26) @[TypeDecoder.scala 27:37 TypeDecoder.scala 23:16]
    node _GEN_35 = mux(_T, UInt<1>("h0"), _GEN_27) @[TypeDecoder.scala 27:37 TypeDecoder.scala 24:16]
    io_r_out <= _GEN_32
    io_load_out <= _GEN_28
    io_store_out <= _GEN_31
    io_sb_out <= _GEN_33
    io_i_out <= _GEN_29
    io_jal_out <= _GEN_34
    io_jalr_out <= _GEN_30
    io_lui_out <= _GEN_35

  module RegisterFile :
    input clock : Clock
    input reset : UInt<1>
    input io_regWrite : UInt<1>
    input io_rs1 : UInt<5>
    input io_rs2 : UInt<5>
    input io_rd : UInt<5>
    input io_writeData : UInt<32>
    output io_writeregester1 : UInt<32>
    output io_writeregester2 : UInt<32>

    reg reg_0 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_0) @[RegisterFile.scala 16:18]
    reg reg_1 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_1) @[RegisterFile.scala 16:18]
    reg reg_2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_2) @[RegisterFile.scala 16:18]
    reg reg_3 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_3) @[RegisterFile.scala 16:18]
    reg reg_4 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_4) @[RegisterFile.scala 16:18]
    reg reg_5 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_5) @[RegisterFile.scala 16:18]
    reg reg_6 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_6) @[RegisterFile.scala 16:18]
    reg reg_7 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_7) @[RegisterFile.scala 16:18]
    reg reg_8 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_8) @[RegisterFile.scala 16:18]
    reg reg_9 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_9) @[RegisterFile.scala 16:18]
    reg reg_10 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_10) @[RegisterFile.scala 16:18]
    reg reg_11 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_11) @[RegisterFile.scala 16:18]
    reg reg_12 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_12) @[RegisterFile.scala 16:18]
    reg reg_13 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_13) @[RegisterFile.scala 16:18]
    reg reg_14 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_14) @[RegisterFile.scala 16:18]
    reg reg_15 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_15) @[RegisterFile.scala 16:18]
    reg reg_16 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_16) @[RegisterFile.scala 16:18]
    reg reg_17 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_17) @[RegisterFile.scala 16:18]
    reg reg_18 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_18) @[RegisterFile.scala 16:18]
    reg reg_19 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_19) @[RegisterFile.scala 16:18]
    reg reg_20 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_20) @[RegisterFile.scala 16:18]
    reg reg_21 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_21) @[RegisterFile.scala 16:18]
    reg reg_22 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_22) @[RegisterFile.scala 16:18]
    reg reg_23 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_23) @[RegisterFile.scala 16:18]
    reg reg_24 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_24) @[RegisterFile.scala 16:18]
    reg reg_25 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_25) @[RegisterFile.scala 16:18]
    reg reg_26 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_26) @[RegisterFile.scala 16:18]
    reg reg_27 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_27) @[RegisterFile.scala 16:18]
    reg reg_28 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_28) @[RegisterFile.scala 16:18]
    reg reg_29 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_29) @[RegisterFile.scala 16:18]
    reg reg_30 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_30) @[RegisterFile.scala 16:18]
    reg reg_31 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_31) @[RegisterFile.scala 16:18]
    node _io_writeregester1_T = orr(io_rs1) @[RegisterFile.scala 18:38]
    node _GEN_0 = validif(eq(UInt<1>("h0"), io_rs1), reg_0) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_1 = mux(eq(UInt<1>("h1"), io_rs1), reg_1, _GEN_0) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_2 = mux(eq(UInt<2>("h2"), io_rs1), reg_2, _GEN_1) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_3 = mux(eq(UInt<2>("h3"), io_rs1), reg_3, _GEN_2) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_4 = mux(eq(UInt<3>("h4"), io_rs1), reg_4, _GEN_3) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_5 = mux(eq(UInt<3>("h5"), io_rs1), reg_5, _GEN_4) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_6 = mux(eq(UInt<3>("h6"), io_rs1), reg_6, _GEN_5) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_7 = mux(eq(UInt<3>("h7"), io_rs1), reg_7, _GEN_6) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_8 = mux(eq(UInt<4>("h8"), io_rs1), reg_8, _GEN_7) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_9 = mux(eq(UInt<4>("h9"), io_rs1), reg_9, _GEN_8) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_10 = mux(eq(UInt<4>("ha"), io_rs1), reg_10, _GEN_9) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_11 = mux(eq(UInt<4>("hb"), io_rs1), reg_11, _GEN_10) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_12 = mux(eq(UInt<4>("hc"), io_rs1), reg_12, _GEN_11) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_13 = mux(eq(UInt<4>("hd"), io_rs1), reg_13, _GEN_12) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_14 = mux(eq(UInt<4>("he"), io_rs1), reg_14, _GEN_13) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_15 = mux(eq(UInt<4>("hf"), io_rs1), reg_15, _GEN_14) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_16 = mux(eq(UInt<5>("h10"), io_rs1), reg_16, _GEN_15) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_17 = mux(eq(UInt<5>("h11"), io_rs1), reg_17, _GEN_16) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_18 = mux(eq(UInt<5>("h12"), io_rs1), reg_18, _GEN_17) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_19 = mux(eq(UInt<5>("h13"), io_rs1), reg_19, _GEN_18) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_20 = mux(eq(UInt<5>("h14"), io_rs1), reg_20, _GEN_19) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_21 = mux(eq(UInt<5>("h15"), io_rs1), reg_21, _GEN_20) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_22 = mux(eq(UInt<5>("h16"), io_rs1), reg_22, _GEN_21) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_23 = mux(eq(UInt<5>("h17"), io_rs1), reg_23, _GEN_22) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_24 = mux(eq(UInt<5>("h18"), io_rs1), reg_24, _GEN_23) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_25 = mux(eq(UInt<5>("h19"), io_rs1), reg_25, _GEN_24) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_26 = mux(eq(UInt<5>("h1a"), io_rs1), reg_26, _GEN_25) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_27 = mux(eq(UInt<5>("h1b"), io_rs1), reg_27, _GEN_26) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_28 = mux(eq(UInt<5>("h1c"), io_rs1), reg_28, _GEN_27) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_29 = mux(eq(UInt<5>("h1d"), io_rs1), reg_29, _GEN_28) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_30 = mux(eq(UInt<5>("h1e"), io_rs1), reg_30, _GEN_29) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _GEN_31 = mux(eq(UInt<5>("h1f"), io_rs1), reg_31, _GEN_30) @[RegisterFile.scala 18:29 RegisterFile.scala 18:29]
    node _reg_io_rs1 = _GEN_31 @[RegisterFile.scala 18:29]
    node _io_writeregester1_T_1 = mux(_io_writeregester1_T, _reg_io_rs1, UInt<1>("h0")) @[RegisterFile.scala 18:29]
    node _io_writeregester2_T = orr(io_rs2) @[RegisterFile.scala 19:38]
    node _GEN_32 = validif(eq(UInt<1>("h0"), io_rs2), reg_0) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_33 = mux(eq(UInt<1>("h1"), io_rs2), reg_1, _GEN_32) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_34 = mux(eq(UInt<2>("h2"), io_rs2), reg_2, _GEN_33) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_35 = mux(eq(UInt<2>("h3"), io_rs2), reg_3, _GEN_34) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_36 = mux(eq(UInt<3>("h4"), io_rs2), reg_4, _GEN_35) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_37 = mux(eq(UInt<3>("h5"), io_rs2), reg_5, _GEN_36) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_38 = mux(eq(UInt<3>("h6"), io_rs2), reg_6, _GEN_37) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_39 = mux(eq(UInt<3>("h7"), io_rs2), reg_7, _GEN_38) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_40 = mux(eq(UInt<4>("h8"), io_rs2), reg_8, _GEN_39) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_41 = mux(eq(UInt<4>("h9"), io_rs2), reg_9, _GEN_40) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_42 = mux(eq(UInt<4>("ha"), io_rs2), reg_10, _GEN_41) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_43 = mux(eq(UInt<4>("hb"), io_rs2), reg_11, _GEN_42) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_44 = mux(eq(UInt<4>("hc"), io_rs2), reg_12, _GEN_43) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_45 = mux(eq(UInt<4>("hd"), io_rs2), reg_13, _GEN_44) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_46 = mux(eq(UInt<4>("he"), io_rs2), reg_14, _GEN_45) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_47 = mux(eq(UInt<4>("hf"), io_rs2), reg_15, _GEN_46) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_48 = mux(eq(UInt<5>("h10"), io_rs2), reg_16, _GEN_47) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_49 = mux(eq(UInt<5>("h11"), io_rs2), reg_17, _GEN_48) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_50 = mux(eq(UInt<5>("h12"), io_rs2), reg_18, _GEN_49) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_51 = mux(eq(UInt<5>("h13"), io_rs2), reg_19, _GEN_50) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_52 = mux(eq(UInt<5>("h14"), io_rs2), reg_20, _GEN_51) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_53 = mux(eq(UInt<5>("h15"), io_rs2), reg_21, _GEN_52) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_54 = mux(eq(UInt<5>("h16"), io_rs2), reg_22, _GEN_53) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_55 = mux(eq(UInt<5>("h17"), io_rs2), reg_23, _GEN_54) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_56 = mux(eq(UInt<5>("h18"), io_rs2), reg_24, _GEN_55) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_57 = mux(eq(UInt<5>("h19"), io_rs2), reg_25, _GEN_56) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_58 = mux(eq(UInt<5>("h1a"), io_rs2), reg_26, _GEN_57) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_59 = mux(eq(UInt<5>("h1b"), io_rs2), reg_27, _GEN_58) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_60 = mux(eq(UInt<5>("h1c"), io_rs2), reg_28, _GEN_59) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_61 = mux(eq(UInt<5>("h1d"), io_rs2), reg_29, _GEN_60) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_62 = mux(eq(UInt<5>("h1e"), io_rs2), reg_30, _GEN_61) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _GEN_63 = mux(eq(UInt<5>("h1f"), io_rs2), reg_31, _GEN_62) @[RegisterFile.scala 19:29 RegisterFile.scala 19:29]
    node _reg_io_rs2 = _GEN_63 @[RegisterFile.scala 19:29]
    node _io_writeregester2_T_1 = mux(_io_writeregester2_T, _reg_io_rs2, UInt<1>("h0")) @[RegisterFile.scala 19:29]
    node _T = eq(io_regWrite, UInt<1>("h1")) @[RegisterFile.scala 21:22]
    node _T_1 = neq(io_rd, UInt<1>("h0")) @[RegisterFile.scala 21:39]
    node _T_2 = and(_T, _T_1) @[RegisterFile.scala 21:30]
    node _reg_io_rd = io_writeData @[RegisterFile.scala 22:20 RegisterFile.scala 22:20]
    node _GEN_64 = mux(eq(UInt<1>("h0"), io_rd), _reg_io_rd, reg_0) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_65 = mux(eq(UInt<1>("h1"), io_rd), _reg_io_rd, reg_1) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_66 = mux(eq(UInt<2>("h2"), io_rd), _reg_io_rd, reg_2) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_67 = mux(eq(UInt<2>("h3"), io_rd), _reg_io_rd, reg_3) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_68 = mux(eq(UInt<3>("h4"), io_rd), _reg_io_rd, reg_4) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_69 = mux(eq(UInt<3>("h5"), io_rd), _reg_io_rd, reg_5) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_70 = mux(eq(UInt<3>("h6"), io_rd), _reg_io_rd, reg_6) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_71 = mux(eq(UInt<3>("h7"), io_rd), _reg_io_rd, reg_7) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_72 = mux(eq(UInt<4>("h8"), io_rd), _reg_io_rd, reg_8) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_73 = mux(eq(UInt<4>("h9"), io_rd), _reg_io_rd, reg_9) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_74 = mux(eq(UInt<4>("ha"), io_rd), _reg_io_rd, reg_10) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_75 = mux(eq(UInt<4>("hb"), io_rd), _reg_io_rd, reg_11) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_76 = mux(eq(UInt<4>("hc"), io_rd), _reg_io_rd, reg_12) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_77 = mux(eq(UInt<4>("hd"), io_rd), _reg_io_rd, reg_13) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_78 = mux(eq(UInt<4>("he"), io_rd), _reg_io_rd, reg_14) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_79 = mux(eq(UInt<4>("hf"), io_rd), _reg_io_rd, reg_15) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_80 = mux(eq(UInt<5>("h10"), io_rd), _reg_io_rd, reg_16) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_81 = mux(eq(UInt<5>("h11"), io_rd), _reg_io_rd, reg_17) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_82 = mux(eq(UInt<5>("h12"), io_rd), _reg_io_rd, reg_18) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_83 = mux(eq(UInt<5>("h13"), io_rd), _reg_io_rd, reg_19) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_84 = mux(eq(UInt<5>("h14"), io_rd), _reg_io_rd, reg_20) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_85 = mux(eq(UInt<5>("h15"), io_rd), _reg_io_rd, reg_21) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_86 = mux(eq(UInt<5>("h16"), io_rd), _reg_io_rd, reg_22) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_87 = mux(eq(UInt<5>("h17"), io_rd), _reg_io_rd, reg_23) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_88 = mux(eq(UInt<5>("h18"), io_rd), _reg_io_rd, reg_24) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_89 = mux(eq(UInt<5>("h19"), io_rd), _reg_io_rd, reg_25) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_90 = mux(eq(UInt<5>("h1a"), io_rd), _reg_io_rd, reg_26) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_91 = mux(eq(UInt<5>("h1b"), io_rd), _reg_io_rd, reg_27) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_92 = mux(eq(UInt<5>("h1c"), io_rd), _reg_io_rd, reg_28) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_93 = mux(eq(UInt<5>("h1d"), io_rd), _reg_io_rd, reg_29) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_94 = mux(eq(UInt<5>("h1e"), io_rd), _reg_io_rd, reg_30) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_95 = mux(eq(UInt<5>("h1f"), io_rd), _reg_io_rd, reg_31) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:18]
    node _GEN_96 = mux(_T_2, _GEN_64, reg_0) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_97 = mux(_T_2, _GEN_65, reg_1) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_98 = mux(_T_2, _GEN_66, reg_2) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_99 = mux(_T_2, _GEN_67, reg_3) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_100 = mux(_T_2, _GEN_68, reg_4) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_101 = mux(_T_2, _GEN_69, reg_5) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_102 = mux(_T_2, _GEN_70, reg_6) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_103 = mux(_T_2, _GEN_71, reg_7) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_104 = mux(_T_2, _GEN_72, reg_8) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_105 = mux(_T_2, _GEN_73, reg_9) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_106 = mux(_T_2, _GEN_74, reg_10) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_107 = mux(_T_2, _GEN_75, reg_11) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_108 = mux(_T_2, _GEN_76, reg_12) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_109 = mux(_T_2, _GEN_77, reg_13) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_110 = mux(_T_2, _GEN_78, reg_14) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_111 = mux(_T_2, _GEN_79, reg_15) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_112 = mux(_T_2, _GEN_80, reg_16) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_113 = mux(_T_2, _GEN_81, reg_17) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_114 = mux(_T_2, _GEN_82, reg_18) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_115 = mux(_T_2, _GEN_83, reg_19) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_116 = mux(_T_2, _GEN_84, reg_20) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_117 = mux(_T_2, _GEN_85, reg_21) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_118 = mux(_T_2, _GEN_86, reg_22) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_119 = mux(_T_2, _GEN_87, reg_23) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_120 = mux(_T_2, _GEN_88, reg_24) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_121 = mux(_T_2, _GEN_89, reg_25) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_122 = mux(_T_2, _GEN_90, reg_26) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_123 = mux(_T_2, _GEN_91, reg_27) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_124 = mux(_T_2, _GEN_92, reg_28) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_125 = mux(_T_2, _GEN_93, reg_29) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_126 = mux(_T_2, _GEN_94, reg_30) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    node _GEN_127 = mux(_T_2, _GEN_95, reg_31) @[RegisterFile.scala 21:48 RegisterFile.scala 16:18]
    io_writeregester1 <= _io_writeregester1_T_1 @[RegisterFile.scala 18:23]
    io_writeregester2 <= _io_writeregester2_T_1 @[RegisterFile.scala 19:23]
    reg_0 <= _GEN_96
    reg_1 <= _GEN_97
    reg_2 <= _GEN_98
    reg_3 <= _GEN_99
    reg_4 <= _GEN_100
    reg_5 <= _GEN_101
    reg_6 <= _GEN_102
    reg_7 <= _GEN_103
    reg_8 <= _GEN_104
    reg_9 <= _GEN_105
    reg_10 <= _GEN_106
    reg_11 <= _GEN_107
    reg_12 <= _GEN_108
    reg_13 <= _GEN_109
    reg_14 <= _GEN_110
    reg_15 <= _GEN_111
    reg_16 <= _GEN_112
    reg_17 <= _GEN_113
    reg_18 <= _GEN_114
    reg_19 <= _GEN_115
    reg_20 <= _GEN_116
    reg_21 <= _GEN_117
    reg_22 <= _GEN_118
    reg_23 <= _GEN_119
    reg_24 <= _GEN_120
    reg_25 <= _GEN_121
    reg_26 <= _GEN_122
    reg_27 <= _GEN_123
    reg_28 <= _GEN_124
    reg_29 <= _GEN_125
    reg_30 <= _GEN_126
    reg_31 <= _GEN_127

  module AluopGeneration :
    input clock : Clock
    input reset : UInt<1>
    input io_opcode : UInt<7>
    output io_aluop : UInt<2>

    node _T = eq(UInt<6>("h33"), io_opcode) @[Conditional.scala 37:30]
    node _T_1 = eq(UInt<5>("h13"), io_opcode) @[Conditional.scala 37:30]
    node _T_2 = eq(UInt<7>("h63"), io_opcode) @[Conditional.scala 37:30]
    node _T_3 = eq(UInt<2>("h3"), io_opcode) @[Conditional.scala 37:30]
    node _T_4 = eq(UInt<6>("h23"), io_opcode) @[Conditional.scala 37:30]
    node _T_5 = eq(UInt<5>("h17"), io_opcode) @[Conditional.scala 37:30]
    node _T_6 = eq(UInt<6>("h37"), io_opcode) @[Conditional.scala 37:30]
    node _GEN_0 = mux(_T_6, UInt<2>("h3"), UInt<1>("h0")) @[Conditional.scala 39:67 AluopGenenation.scala 20:36 AluopGenenation.scala 11:14]
    node _GEN_1 = mux(_T_5, UInt<2>("h3"), _GEN_0) @[Conditional.scala 39:67 AluopGenenation.scala 19:36]
    node _GEN_2 = mux(_T_4, UInt<1>("h0"), _GEN_1) @[Conditional.scala 39:67 AluopGenenation.scala 18:36]
    node _GEN_3 = mux(_T_3, UInt<1>("h0"), _GEN_2) @[Conditional.scala 39:67 AluopGenenation.scala 17:36]
    node _GEN_4 = mux(_T_2, UInt<1>("h1"), _GEN_3) @[Conditional.scala 39:67 AluopGenenation.scala 16:36]
    node _GEN_5 = mux(_T_1, UInt<2>("h2"), _GEN_4) @[Conditional.scala 39:67 AluopGenenation.scala 15:36]
    node _GEN_6 = mux(_T, UInt<2>("h2"), _GEN_5) @[Conditional.scala 40:58 AluopGenenation.scala 14:36]
    io_aluop <= _GEN_6

  module Alucontrol :
    input clock : Clock
    input reset : UInt<1>
    input io_aluop : UInt<2>
    input io_opcode : UInt<7>
    input io_func7 : UInt<7>
    input io_func3 : UInt<3>
    output io_aluctrl : UInt<6>

    node _T = eq(io_aluop, UInt<1>("h0")) @[Alucontrol.scala 16:19]
    node _T_1 = eq(io_aluop, UInt<1>("h1")) @[Alucontrol.scala 17:24]
    node _T_2 = eq(io_aluop, UInt<2>("h2")) @[Alucontrol.scala 18:24]
    node _T_3 = eq(io_opcode, UInt<6>("h33")) @[Alucontrol.scala 19:26]
    node _T_4 = eq(UInt<1>("h0"), io_func3) @[Conditional.scala 37:30]
    node _T_5 = eq(io_func7, UInt<1>("h0")) @[Alucontrol.scala 22:36]
    node _T_6 = eq(io_func7, UInt<6>("h20")) @[Alucontrol.scala 23:41]
    node _GEN_0 = mux(_T_6, UInt<1>("h1"), UInt<1>("h0")) @[Alucontrol.scala 23:58 Alucontrol.scala 23:70 Alucontrol.scala 14:16]
    node _GEN_1 = mux(_T_5, UInt<1>("h0"), _GEN_0) @[Alucontrol.scala 22:53 Alucontrol.scala 22:65]
    node _T_7 = eq(UInt<1>("h1"), io_func3) @[Conditional.scala 37:30]
    node _T_8 = eq(UInt<3>("h7"), io_func3) @[Conditional.scala 37:30]
    node _T_9 = eq(UInt<3>("h6"), io_func3) @[Conditional.scala 37:30]
    node _T_10 = eq(UInt<3>("h4"), io_func3) @[Conditional.scala 37:30]
    node _T_11 = eq(UInt<3>("h5"), io_func3) @[Conditional.scala 37:30]
    node _T_12 = eq(io_func7, UInt<1>("h0")) @[Alucontrol.scala 29:36]
    node _T_13 = eq(io_func7, UInt<4>("h8")) @[Alucontrol.scala 30:41]
    node _GEN_2 = mux(_T_13, UInt<3>("h7"), UInt<1>("h0")) @[Alucontrol.scala 30:57 Alucontrol.scala 30:69 Alucontrol.scala 14:16]
    node _GEN_3 = mux(_T_12, UInt<3>("h6"), _GEN_2) @[Alucontrol.scala 29:53 Alucontrol.scala 29:65]
    node _T_14 = eq(UInt<2>("h2"), io_func3) @[Conditional.scala 37:30]
    node _T_15 = eq(UInt<2>("h3"), io_func3) @[Conditional.scala 37:30]
    node _GEN_4 = mux(_T_15, UInt<4>("h9"), UInt<1>("h0")) @[Conditional.scala 39:67 Alucontrol.scala 32:43 Alucontrol.scala 14:16]
    node _GEN_5 = mux(_T_14, UInt<4>("h8"), _GEN_4) @[Conditional.scala 39:67 Alucontrol.scala 31:43]
    node _GEN_6 = mux(_T_11, _GEN_3, _GEN_5) @[Conditional.scala 39:67]
    node _GEN_7 = mux(_T_10, UInt<3>("h5"), _GEN_6) @[Conditional.scala 39:67 Alucontrol.scala 27:43]
    node _GEN_8 = mux(_T_9, UInt<3>("h4"), _GEN_7) @[Conditional.scala 39:67 Alucontrol.scala 26:43]
    node _GEN_9 = mux(_T_8, UInt<2>("h3"), _GEN_8) @[Conditional.scala 39:67 Alucontrol.scala 25:43]
    node _GEN_10 = mux(_T_7, UInt<2>("h2"), _GEN_9) @[Conditional.scala 39:67 Alucontrol.scala 24:43]
    node _GEN_11 = mux(_T_4, _GEN_1, _GEN_10) @[Conditional.scala 40:58]
    node _T_16 = eq(io_opcode, UInt<5>("h13")) @[Alucontrol.scala 35:31]
    node _T_17 = eq(UInt<1>("h0"), io_func3) @[Conditional.scala 37:30]
    node _T_18 = eq(UInt<1>("h1"), io_func3) @[Conditional.scala 37:30]
    node _T_19 = eq(io_func7, UInt<1>("h0")) @[Alucontrol.scala 38:47]
    node _GEN_12 = mux(_T_19, UInt<2>("h2"), UInt<1>("h0")) @[Alucontrol.scala 38:64 Alucontrol.scala 38:76 Alucontrol.scala 14:16]
    node _T_20 = eq(UInt<2>("h2"), io_func3) @[Conditional.scala 37:30]
    node _T_21 = eq(UInt<2>("h3"), io_func3) @[Conditional.scala 37:30]
    node _T_22 = eq(UInt<3>("h4"), io_func3) @[Conditional.scala 37:30]
    node _T_23 = eq(UInt<3>("h5"), io_func3) @[Conditional.scala 37:30]
    node _T_24 = eq(io_func7, UInt<1>("h0")) @[Alucontrol.scala 43:36]
    node _T_25 = eq(io_func7, UInt<6>("h20")) @[Alucontrol.scala 44:41]
    node _GEN_13 = mux(_T_25, UInt<3>("h7"), UInt<1>("h0")) @[Alucontrol.scala 44:58 Alucontrol.scala 44:70 Alucontrol.scala 14:16]
    node _GEN_14 = mux(_T_24, UInt<3>("h6"), _GEN_13) @[Alucontrol.scala 43:53 Alucontrol.scala 43:65]
    node _T_26 = eq(UInt<3>("h6"), io_func3) @[Conditional.scala 37:30]
    node _T_27 = eq(UInt<3>("h7"), io_func3) @[Conditional.scala 37:30]
    node _GEN_15 = mux(_T_27, UInt<2>("h3"), UInt<1>("h0")) @[Conditional.scala 39:67 Alucontrol.scala 46:43 Alucontrol.scala 14:16]
    node _GEN_16 = mux(_T_26, UInt<3>("h4"), _GEN_15) @[Conditional.scala 39:67 Alucontrol.scala 45:43]
    node _GEN_17 = mux(_T_23, _GEN_14, _GEN_16) @[Conditional.scala 39:67]
    node _GEN_18 = mux(_T_22, UInt<3>("h5"), _GEN_17) @[Conditional.scala 39:67 Alucontrol.scala 41:43]
    node _GEN_19 = mux(_T_21, UInt<4>("h9"), _GEN_18) @[Conditional.scala 39:67 Alucontrol.scala 40:43]
    node _GEN_20 = mux(_T_20, UInt<4>("h8"), _GEN_19) @[Conditional.scala 39:67 Alucontrol.scala 39:43]
    node _GEN_21 = mux(_T_18, _GEN_12, _GEN_20) @[Conditional.scala 39:67]
    node _GEN_22 = mux(_T_17, UInt<1>("h0"), _GEN_21) @[Conditional.scala 40:58 Alucontrol.scala 37:43]
    node _GEN_23 = mux(_T_16, _GEN_22, UInt<1>("h0")) @[Alucontrol.scala 35:48 Alucontrol.scala 14:16]
    node _GEN_24 = mux(_T_3, _GEN_11, _GEN_23) @[Alucontrol.scala 19:43]
    node _GEN_25 = mux(_T_2, _GEN_24, UInt<1>("h0")) @[Alucontrol.scala 18:32 Alucontrol.scala 14:16]
    node _GEN_26 = mux(_T_1, UInt<6>("h3f"), _GEN_25) @[Alucontrol.scala 17:32 Alucontrol.scala 17:45]
    node _GEN_27 = mux(_T, UInt<1>("h0"), _GEN_26) @[Alucontrol.scala 16:27 Alucontrol.scala 16:40]
    io_aluctrl <= _GEN_27

  module Alu :
    input clock : Clock
    input reset : UInt<1>
    input io_op1 : UInt<32>
    input io_op2 : UInt<32>
    input io_aluctrl : UInt<6>
    output io_aluout : UInt<32>
    output io_zero : UInt<1>

    node _T = eq(UInt<1>("h0"), io_aluctrl) @[Conditional.scala 37:30]
    node _io_aluout_T = add(io_op1, io_op2) @[Alu.scala 16:47]
    node _io_aluout_T_1 = tail(_io_aluout_T, 1) @[Alu.scala 16:47]
    node _T_1 = eq(UInt<1>("h1"), io_aluctrl) @[Conditional.scala 37:30]
    node _io_aluout_T_2 = sub(io_op1, io_op2) @[Alu.scala 17:47]
    node _io_aluout_T_3 = tail(_io_aluout_T_2, 1) @[Alu.scala 17:47]
    node _T_2 = eq(UInt<2>("h2"), io_aluctrl) @[Conditional.scala 37:30]
    node _io_aluout_T_4 = bits(io_op2, 4, 0) @[Alu.scala 18:56]
    node _io_aluout_T_5 = dshl(io_op1, _io_aluout_T_4) @[Alu.scala 18:47]
    node _T_3 = eq(UInt<2>("h3"), io_aluctrl) @[Conditional.scala 37:30]
    node _io_aluout_T_6 = and(io_op1, io_op2) @[Alu.scala 19:47]
    node _T_4 = eq(UInt<3>("h4"), io_aluctrl) @[Conditional.scala 37:30]
    node _io_aluout_T_7 = or(io_op1, io_op2) @[Alu.scala 20:47]
    node _T_5 = eq(UInt<3>("h5"), io_aluctrl) @[Conditional.scala 37:30]
    node _io_aluout_T_8 = xor(io_op1, io_op2) @[Alu.scala 21:47]
    node _T_6 = eq(UInt<3>("h6"), io_aluctrl) @[Conditional.scala 37:30]
    node _io_aluout_T_9 = bits(io_op2, 4, 0) @[Alu.scala 22:56]
    node _io_aluout_T_10 = dshr(io_op1, _io_aluout_T_9) @[Alu.scala 22:47]
    node _T_7 = eq(UInt<3>("h7"), io_aluctrl) @[Conditional.scala 37:30]
    node _io_aluout_T_11 = asSInt(io_op1) @[Alu.scala 23:48]
    node _io_aluout_T_12 = bits(io_op2, 4, 0) @[Alu.scala 23:64]
    node _io_aluout_T_13 = dshr(_io_aluout_T_11, _io_aluout_T_12) @[Alu.scala 23:55]
    node _io_aluout_T_14 = asUInt(_io_aluout_T_13) @[Alu.scala 23:71]
    node _T_8 = eq(UInt<4>("h8"), io_aluctrl) @[Conditional.scala 37:30]
    node _io_aluout_T_15 = asSInt(io_op1) @[Alu.scala 24:51]
    node _io_aluout_T_16 = asSInt(io_op2) @[Alu.scala 24:67]
    node _io_aluout_T_17 = lt(_io_aluout_T_15, _io_aluout_T_16) @[Alu.scala 24:58]
    node _io_aluout_T_18 = mux(_io_aluout_T_17, UInt<1>("h1"), UInt<1>("h0")) @[Alu.scala 24:43]
    node _T_9 = eq(UInt<4>("h9"), io_aluctrl) @[Conditional.scala 37:30]
    node _io_aluout_T_19 = lt(io_op1, io_op2) @[Alu.scala 25:51]
    node _io_aluout_T_20 = mux(_io_aluout_T_19, UInt<1>("h1"), UInt<1>("h0")) @[Alu.scala 25:43]
    node _GEN_0 = mux(_T_9, _io_aluout_T_20, UInt<1>("h0")) @[Conditional.scala 39:67 Alu.scala 25:37 Alu.scala 13:15]
    node _GEN_1 = mux(_T_8, _io_aluout_T_18, _GEN_0) @[Conditional.scala 39:67 Alu.scala 24:37]
    node _GEN_2 = mux(_T_7, _io_aluout_T_14, _GEN_1) @[Conditional.scala 39:67 Alu.scala 23:37]
    node _GEN_3 = mux(_T_6, _io_aluout_T_10, _GEN_2) @[Conditional.scala 39:67 Alu.scala 22:37]
    node _GEN_4 = mux(_T_5, _io_aluout_T_8, _GEN_3) @[Conditional.scala 39:67 Alu.scala 21:37]
    node _GEN_5 = mux(_T_4, _io_aluout_T_7, _GEN_4) @[Conditional.scala 39:67 Alu.scala 20:37]
    node _GEN_6 = mux(_T_3, _io_aluout_T_6, _GEN_5) @[Conditional.scala 39:67 Alu.scala 19:37]
    node _GEN_7 = mux(_T_2, _io_aluout_T_5, _GEN_6) @[Conditional.scala 39:67 Alu.scala 18:37]
    node _GEN_8 = mux(_T_1, _io_aluout_T_3, _GEN_7) @[Conditional.scala 39:67 Alu.scala 17:37]
    node _GEN_9 = mux(_T, _io_aluout_T_1, _GEN_8) @[Conditional.scala 40:58 Alu.scala 16:37]
    node _io_zero_T = eq(io_aluout, UInt<1>("h0")) @[Alu.scala 37:27]
    io_aluout <= bits(_GEN_9, 31, 0)
    io_zero <= _io_zero_T @[Alu.scala 37:13]

  module Datamemory :
    input clock : Clock
    input reset : UInt<1>
    input io_memwrite : UInt<1>
    input io_memread : UInt<1>
    input io_memaddress : UInt<24>
    input io_memdata : SInt<32>
    output io_memout : SInt<32>

    mem mem : @[Datamemory.scala 13:18]
      data-type => SInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => io_memout_MPORT
      writer => MPORT
      read-under-write => undefined
    node _T = eq(io_memwrite, UInt<1>("h1")) @[Datamemory.scala 15:22]
    node _T_1 = eq(io_memread, UInt<1>("h0")) @[Datamemory.scala 15:44]
    node _T_2 = and(_T, _T_1) @[Datamemory.scala 15:30]
    node _T_3 = bits(io_memaddress, 9, 0)
    node _GEN_0 = validif(_T_2, _T_3) @[Datamemory.scala 15:53]
    node _GEN_1 = validif(_T_2, clock) @[Datamemory.scala 15:53]
    node _GEN_2 = mux(_T_2, UInt<1>("h1"), UInt<1>("h0")) @[Datamemory.scala 15:53 Datamemory.scala 13:18]
    node _GEN_3 = validif(_T_2, UInt<1>("h1")) @[Datamemory.scala 15:53]
    node _GEN_4 = validif(_T_2, io_memdata) @[Datamemory.scala 15:53]
    node _GEN_5 = mux(_T_2, asSInt(UInt<1>("h0")), asSInt(UInt<1>("h0"))) @[Datamemory.scala 15:53 Datamemory.scala 17:19 Datamemory.scala 14:15]
    node _T_4 = eq(io_memwrite, UInt<1>("h0")) @[Datamemory.scala 19:22]
    node _T_5 = eq(io_memread, UInt<1>("h1")) @[Datamemory.scala 19:44]
    node _T_6 = and(_T_4, _T_5) @[Datamemory.scala 19:30]
    node _io_memout_T = bits(io_memaddress, 9, 0) @[Datamemory.scala 20:30]
    node _GEN_6 = validif(_T_6, _io_memout_T) @[Datamemory.scala 19:53 Datamemory.scala 20:30]
    node _GEN_7 = validif(_T_6, clock) @[Datamemory.scala 19:53 Datamemory.scala 20:30]
    node _GEN_8 = mux(_T_6, UInt<1>("h1"), UInt<1>("h0")) @[Datamemory.scala 19:53 Datamemory.scala 20:30 Datamemory.scala 13:18]
    node _GEN_9 = mux(_T_6, mem.io_memout_MPORT.data, _GEN_5) @[Datamemory.scala 19:53 Datamemory.scala 20:19]
    node _T_7 = eq(io_memwrite, UInt<1>("h0")) @[Datamemory.scala 22:22]
    node _T_8 = eq(io_memread, UInt<1>("h0")) @[Datamemory.scala 22:44]
    node _T_9 = and(_T_7, _T_8) @[Datamemory.scala 22:30]
    node _GEN_10 = mux(_T_9, asSInt(UInt<1>("h0")), _GEN_9) @[Datamemory.scala 22:53 Datamemory.scala 23:19]
    io_memout <= _GEN_10
    mem.io_memout_MPORT.addr <= _GEN_6
    mem.io_memout_MPORT.en <= _GEN_8
    mem.io_memout_MPORT.clk <= _GEN_7
    mem.MPORT.addr <= _GEN_0
    mem.MPORT.en <= _GEN_2
    mem.MPORT.clk <= _GEN_1
    mem.MPORT.data <= _GEN_4
    mem.MPORT.mask <= _GEN_3

  module SingleCycle :
    input clock : Clock
    input reset : UInt<1>
    output io_Output1 : UInt<32>
    output io_datamemOut : SInt<32>
    output io_Address : UInt<24>
    output io_write : UInt<1>

    inst pc_module of Programcounter @[SingleCycle.scala 16:23]
    inst insmemory_module of InstructionMemory @[SingleCycle.scala 17:30]
    inst immgen_module of ImmediateGeneration @[SingleCycle.scala 18:27]
    inst isntdecoder_module of InstructionDecoder @[SingleCycle.scala 19:32]
    inst typeDecoder_module of TypeDecoder @[SingleCycle.scala 20:31]
    inst regfile_module of RegisterFile @[SingleCycle.scala 21:28]
    inst aluopgen_module of AluopGeneration @[SingleCycle.scala 22:29]
    inst alucontrol_module of Alucontrol @[SingleCycle.scala 23:31]
    inst alu_module of Alu @[SingleCycle.scala 24:24]
    inst datamemory_module of Datamemory @[SingleCycle.scala 25:31]
    node a = and(typeDecoder_module.io_sb_out, alu_module.io_zero) @[SingleCycle.scala 29:38]
    node _b_T = asSInt(immgen_module.io_immd_se) @[SingleCycle.scala 30:53]
    node _b_T_1 = add(pc_module.io_out, _b_T) @[SingleCycle.scala 30:26]
    node _b_T_2 = tail(_b_T_1, 1) @[SingleCycle.scala 30:26]
    node b = asSInt(_b_T_2) @[SingleCycle.scala 30:26]
    node _pc_module_io_in_T = eq(UInt<1>("h1"), a) @[Mux.scala 80:60]
    node _pc_module_io_in_T_1 = mux(_pc_module_io_in_T, b, pc_module.io_pc4) @[Mux.scala 80:57]
    node _insmemory_module_io_readadress_T = bits(pc_module.io_out, 25, 2) @[SingleCycle.scala 36:51]
    node _regWrite_T = or(typeDecoder_module.io_r_out, typeDecoder_module.io_i_out) @[SingleCycle.scala 46:44]
    node _regWrite_T_1 = or(_regWrite_T, typeDecoder_module.io_jal_out) @[SingleCycle.scala 46:74]
    node _regWrite_T_2 = or(_regWrite_T_1, typeDecoder_module.io_jalr_out) @[SingleCycle.scala 46:106]
    node _regWrite_T_3 = or(_regWrite_T_2, typeDecoder_module.io_lui_out) @[SingleCycle.scala 46:139]
    node regWrite = or(_regWrite_T_3, typeDecoder_module.io_load_out) @[SingleCycle.scala 46:171]
    node _regfile_module_io_writeData_T = asUInt(datamemory_module.io_memout) @[SingleCycle.scala 54:42]
    node _regfile_module_io_writeData_T_1 = eq(UInt<1>("h1"), typeDecoder_module.io_load_out) @[Mux.scala 80:60]
    node _regfile_module_io_writeData_T_2 = mux(_regfile_module_io_writeData_T_1, _regfile_module_io_writeData_T, alu_module.io_aluout) @[Mux.scala 80:57]
    node _alu_module_io_op2_T = eq(UInt<1>("h1"), typeDecoder_module.io_i_out) @[Mux.scala 80:60]
    node _alu_module_io_op2_T_1 = mux(_alu_module_io_op2_T, immgen_module.io_immd_se, regfile_module.io_writeregester2) @[Mux.scala 80:57]
    node _c_T = add(immgen_module.io_immd_se, regfile_module.io_writeregester1) @[SingleCycle.scala 69:34]
    node c = tail(_c_T, 1) @[SingleCycle.scala 69:34]
    node d = bits(c, 23, 0) @[SingleCycle.scala 70:10]
    node e = or(typeDecoder_module.io_load_out, typeDecoder_module.io_store_out) @[SingleCycle.scala 71:40]
    node _address_T = eq(UInt<1>("h1"), e) @[Mux.scala 80:60]
    node address = mux(_address_T, d, UInt<1>("h0")) @[Mux.scala 80:57]
    node _datamemory_module_io_memdata_T = asSInt(regfile_module.io_writeregester2) @[SingleCycle.scala 77:66]
    io_Output1 <= alu_module.io_aluout @[SingleCycle.scala 82:12]
    io_datamemOut <= datamemory_module.io_memout @[SingleCycle.scala 83:15]
    io_Address <= address @[SingleCycle.scala 84:12]
    io_write <= regWrite @[SingleCycle.scala 85:10]
    pc_module.clock <= clock
    pc_module.reset <= reset
    pc_module.io_in <= _pc_module_io_in_T_1 @[SingleCycle.scala 32:17]
    insmemory_module.clock <= clock
    insmemory_module.reset <= reset
    insmemory_module.io_readadress <= _insmemory_module_io_readadress_T @[SingleCycle.scala 36:32]
    immgen_module.clock <= clock
    immgen_module.reset <= reset
    immgen_module.io_instruction <= insmemory_module.io_readdata @[SingleCycle.scala 39:30]
    isntdecoder_module.clock <= clock
    isntdecoder_module.reset <= reset
    isntdecoder_module.io_instruction <= insmemory_module.io_readdata @[SingleCycle.scala 38:35]
    typeDecoder_module.clock <= clock
    typeDecoder_module.reset <= reset
    typeDecoder_module.io_opcode <= bits(isntdecoder_module.io_opcode, 5, 0) @[SingleCycle.scala 41:30]
    regfile_module.clock <= clock
    regfile_module.reset <= reset
    regfile_module.io_regWrite <= regWrite @[SingleCycle.scala 48:28]
    regfile_module.io_rs1 <= isntdecoder_module.io_rs1 @[SingleCycle.scala 49:23]
    regfile_module.io_rs2 <= isntdecoder_module.io_rs2 @[SingleCycle.scala 50:23]
    regfile_module.io_rd <= isntdecoder_module.io_rd @[SingleCycle.scala 51:22]
    regfile_module.io_writeData <= _regfile_module_io_writeData_T_2 @[SingleCycle.scala 52:29]
    aluopgen_module.clock <= clock
    aluopgen_module.reset <= reset
    aluopgen_module.io_opcode <= isntdecoder_module.io_opcode @[SingleCycle.scala 43:27]
    alucontrol_module.clock <= clock
    alucontrol_module.reset <= reset
    alucontrol_module.io_aluop <= aluopgen_module.io_aluop @[SingleCycle.scala 58:28]
    alucontrol_module.io_opcode <= isntdecoder_module.io_opcode @[SingleCycle.scala 59:29]
    alucontrol_module.io_func7 <= isntdecoder_module.io_func7 @[SingleCycle.scala 60:28]
    alucontrol_module.io_func3 <= isntdecoder_module.io_func3 @[SingleCycle.scala 61:28]
    alu_module.clock <= clock
    alu_module.reset <= reset
    alu_module.io_op1 <= regfile_module.io_writeregester1 @[SingleCycle.scala 63:19]
    alu_module.io_op2 <= _alu_module_io_op2_T_1 @[SingleCycle.scala 64:19]
    alu_module.io_aluctrl <= alucontrol_module.io_aluctrl @[SingleCycle.scala 67:23]
    datamemory_module.clock <= clock
    datamemory_module.reset <= reset
    datamemory_module.io_memwrite <= typeDecoder_module.io_store_out @[SingleCycle.scala 80:31]
    datamemory_module.io_memread <= regWrite @[SingleCycle.scala 79:30]
    datamemory_module.io_memaddress <= address @[SingleCycle.scala 78:33]
    datamemory_module.io_memdata <= _datamemory_module_io_memdata_T @[SingleCycle.scala 77:30]
