circuit Core :
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
    input io_readadress : UInt<32>
    output io_readdata : UInt<32>

    mem mem : @[InstructionMemory.scala 12:18]
      data-type => UInt<32>
      depth => 4096
      read-latency => 0
      write-latency => 1
      reader => io_readdata_MPORT
      read-under-write => undefined
    node _io_readdata_T = bits(io_readadress, 11, 0) @[InstructionMemory.scala 15:28]
    io_readdata <= mem.io_readdata_MPORT.data @[InstructionMemory.scala 15:17]
    mem.io_readdata_MPORT.addr <= _io_readdata_T @[InstructionMemory.scala 15:28]
    mem.io_readdata_MPORT.en <= UInt<1>("h1") @[InstructionMemory.scala 15:28]
    mem.io_readdata_MPORT.clk <= clock @[InstructionMemory.scala 15:28]

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
    input io_opcode : UInt<7>
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
    node _T_2 = eq(io_opcode, UInt<5>("h13")) @[TypeDecoder.scala 29:56]
    node _T_3 = or(_T_1, _T_2) @[TypeDecoder.scala 29:43]
    node _T_4 = eq(io_opcode, UInt<7>("h73")) @[TypeDecoder.scala 29:86]
    node _T_5 = or(_T_3, _T_4) @[TypeDecoder.scala 29:73]
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
    node _GEN_21 = mux(_T_5, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 29:104 TypeDecoder.scala 30:18 TypeDecoder.scala 22:14]
    node _GEN_22 = mux(_T_5, UInt<1>("h0"), _GEN_15) @[TypeDecoder.scala 29:104 TypeDecoder.scala 25:17]
    node _GEN_23 = mux(_T_5, UInt<1>("h0"), _GEN_16) @[TypeDecoder.scala 29:104 TypeDecoder.scala 21:18]
    node _GEN_24 = mux(_T_5, UInt<1>("h0"), _GEN_17) @[TypeDecoder.scala 29:104 TypeDecoder.scala 19:14]
    node _GEN_25 = mux(_T_5, UInt<1>("h0"), _GEN_18) @[TypeDecoder.scala 29:104 TypeDecoder.scala 20:15]
    node _GEN_26 = mux(_T_5, UInt<1>("h0"), _GEN_19) @[TypeDecoder.scala 29:104 TypeDecoder.scala 23:16]
    node _GEN_27 = mux(_T_5, UInt<1>("h0"), _GEN_20) @[TypeDecoder.scala 29:104 TypeDecoder.scala 24:16]
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

  module ImmediateGen :
    input clock : Clock
    input reset : UInt<1>
    input io_instruction : UInt<32>
    input io_pc : UInt<32>
    output io_imm_out : SInt<32>

    node opcode = bits(io_instruction, 6, 0) @[ImmediateGen.scala 12:30]
    node _i_imm_T = bits(io_instruction, 31, 31) @[ImmediateGen.scala 15:43]
    node _i_imm_T_1 = bits(_i_imm_T, 0, 0) @[Bitwise.scala 72:15]
    node i_imm_hi = mux(_i_imm_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 72:12]
    node i_imm_lo = bits(io_instruction, 31, 20) @[ImmediateGen.scala 15:64]
    node _i_imm_T_2 = cat(i_imm_hi, i_imm_lo) @[Cat.scala 30:58]
    node i_imm = asSInt(_i_imm_T_2) @[ImmediateGen.scala 15:73]
    node _s_imm_T = bits(io_instruction, 31, 31) @[ImmediateGen.scala 16:43]
    node _s_imm_T_1 = bits(_s_imm_T, 0, 0) @[Bitwise.scala 72:15]
    node s_imm_hi_hi = mux(_s_imm_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 72:12]
    node s_imm_hi_lo = bits(io_instruction, 31, 25) @[ImmediateGen.scala 16:64]
    node s_imm_lo = bits(io_instruction, 11, 7) @[ImmediateGen.scala 16:87]
    node s_imm_hi = cat(s_imm_hi_hi, s_imm_hi_lo) @[Cat.scala 30:58]
    node _s_imm_T_2 = cat(s_imm_hi, s_imm_lo) @[Cat.scala 30:58]
    node s_imm = asSInt(_s_imm_T_2) @[ImmediateGen.scala 16:95]
    node _sb_imm_T = bits(io_instruction, 31, 31) @[ImmediateGen.scala 17:44]
    node _sb_imm_T_1 = bits(_sb_imm_T, 0, 0) @[Bitwise.scala 72:15]
    node sb_imm_hi_hi_hi = mux(_sb_imm_T_1, UInt<19>("h7ffff"), UInt<19>("h0")) @[Bitwise.scala 72:12]
    node sb_imm_hi_hi_lo = bits(io_instruction, 31, 31) @[ImmediateGen.scala 18:34]
    node sb_imm_hi_lo = bits(io_instruction, 7, 7) @[ImmediateGen.scala 19:34]
    node sb_imm_lo_hi_hi = bits(io_instruction, 30, 25) @[ImmediateGen.scala 20:34]
    node sb_imm_lo_hi_lo = bits(io_instruction, 11, 8) @[ImmediateGen.scala 21:34]
    node sb_imm_lo_hi = cat(sb_imm_lo_hi_hi, sb_imm_lo_hi_lo) @[Cat.scala 30:58]
    node sb_imm_lo = cat(sb_imm_lo_hi, UInt<1>("h0")) @[Cat.scala 30:58]
    node sb_imm_hi_hi = cat(sb_imm_hi_hi_hi, sb_imm_hi_hi_lo) @[Cat.scala 30:58]
    node sb_imm_hi = cat(sb_imm_hi_hi, sb_imm_hi_lo) @[Cat.scala 30:58]
    node _sb_imm_T_2 = cat(sb_imm_hi, sb_imm_lo) @[Cat.scala 30:58]
    node _sb_imm_T_3 = asSInt(_sb_imm_T_2) @[ImmediateGen.scala 22:30]
    node _sb_imm_T_4 = asSInt(io_pc) @[ImmediateGen.scala 22:45]
    node _sb_imm_T_5 = add(_sb_imm_T_3, _sb_imm_T_4) @[ImmediateGen.scala 22:37]
    node _sb_imm_T_6 = tail(_sb_imm_T_5, 1) @[ImmediateGen.scala 22:37]
    node sb_imm = asSInt(_sb_imm_T_6) @[ImmediateGen.scala 22:37]
    node u_imm_hi = bits(io_instruction, 31, 12) @[ImmediateGen.scala 23:33]
    node _u_imm_T = cat(u_imm_hi, UInt<12>("h0")) @[Cat.scala 30:58]
    node u_imm = asSInt(_u_imm_T) @[ImmediateGen.scala 23:54]
    node _auipc_imm_T = asSInt(io_pc) @[ImmediateGen.scala 24:34]
    node _auipc_imm_T_1 = add(u_imm, _auipc_imm_T) @[ImmediateGen.scala 24:26]
    node _auipc_imm_T_2 = tail(_auipc_imm_T_1, 1) @[ImmediateGen.scala 24:26]
    node auipc_imm = asSInt(_auipc_imm_T_2) @[ImmediateGen.scala 24:26]
    node _uj_imm_T = bits(io_instruction, 31, 31) @[ImmediateGen.scala 26:44]
    node _uj_imm_T_1 = bits(_uj_imm_T, 0, 0) @[Bitwise.scala 72:15]
    node uj_imm_hi_hi_hi = mux(_uj_imm_T_1, UInt<11>("h7ff"), UInt<11>("h0")) @[Bitwise.scala 72:12]
    node uj_imm_hi_hi_lo = bits(io_instruction, 31, 31) @[ImmediateGen.scala 27:34]
    node uj_imm_hi_lo = bits(io_instruction, 19, 12) @[ImmediateGen.scala 28:34]
    node uj_imm_lo_hi_hi = bits(io_instruction, 20, 20) @[ImmediateGen.scala 29:34]
    node uj_imm_lo_hi_lo = bits(io_instruction, 30, 21) @[ImmediateGen.scala 30:34]
    node uj_imm_lo_hi = cat(uj_imm_lo_hi_hi, uj_imm_lo_hi_lo) @[Cat.scala 30:58]
    node uj_imm_lo = cat(uj_imm_lo_hi, UInt<1>("h0")) @[Cat.scala 30:58]
    node uj_imm_hi_hi = cat(uj_imm_hi_hi_hi, uj_imm_hi_hi_lo) @[Cat.scala 30:58]
    node uj_imm_hi = cat(uj_imm_hi_hi, uj_imm_hi_lo) @[Cat.scala 30:58]
    node _uj_imm_T_2 = cat(uj_imm_hi, uj_imm_lo) @[Cat.scala 30:58]
    node _uj_imm_T_3 = asSInt(_uj_imm_T_2) @[ImmediateGen.scala 31:30]
    node _uj_imm_T_4 = asSInt(io_pc) @[ImmediateGen.scala 31:45]
    node _uj_imm_T_5 = add(_uj_imm_T_3, _uj_imm_T_4) @[ImmediateGen.scala 31:37]
    node _uj_imm_T_6 = tail(_uj_imm_T_5, 1) @[ImmediateGen.scala 31:37]
    node uj_imm = asSInt(_uj_imm_T_6) @[ImmediateGen.scala 31:37]
    node _T = eq(UInt<2>("h3"), opcode) @[Conditional.scala 37:30]
    node _T_1 = eq(UInt<5>("h13"), opcode) @[Conditional.scala 37:30]
    node _T_2 = eq(UInt<7>("h67"), opcode) @[Conditional.scala 37:30]
    node _T_3 = eq(UInt<6>("h23"), opcode) @[Conditional.scala 37:30]
    node _T_4 = eq(UInt<7>("h63"), opcode) @[Conditional.scala 37:30]
    node _T_5 = eq(UInt<6>("h37"), opcode) @[Conditional.scala 37:30]
    node _T_6 = eq(UInt<5>("h17"), opcode) @[Conditional.scala 37:30]
    node _T_7 = eq(UInt<7>("h6f"), opcode) @[Conditional.scala 37:30]
    node _GEN_0 = mux(_T_7, uj_imm, asSInt(UInt<1>("h0"))) @[Conditional.scala 39:67 ImmediateGen.scala 44:35 ImmediateGen.scala 34:14]
    node _GEN_1 = mux(_T_6, auipc_imm, _GEN_0) @[Conditional.scala 39:67 ImmediateGen.scala 43:35]
    node _GEN_2 = mux(_T_5, u_imm, _GEN_1) @[Conditional.scala 39:67 ImmediateGen.scala 42:35]
    node _GEN_3 = mux(_T_4, sb_imm, _GEN_2) @[Conditional.scala 39:67 ImmediateGen.scala 41:35]
    node _GEN_4 = mux(_T_3, s_imm, _GEN_3) @[Conditional.scala 39:67 ImmediateGen.scala 40:35]
    node _GEN_5 = mux(_T_2, i_imm, _GEN_4) @[Conditional.scala 39:67 ImmediateGen.scala 39:35]
    node _GEN_6 = mux(_T_1, i_imm, _GEN_5) @[Conditional.scala 39:67 ImmediateGen.scala 38:35]
    node _GEN_7 = mux(_T, i_imm, _GEN_6) @[Conditional.scala 40:58 ImmediateGen.scala 37:35]
    io_imm_out <= _GEN_7

  module RegisterFile :
    input clock : Clock
    input reset : UInt<1>
    input io_regWrite : UInt<1>
    input io_rs1 : UInt<5>
    input io_rs2 : UInt<5>
    input io_rd : UInt<5>
    input io_writeData : UInt<32>
    output io_readData1 : UInt<32>
    output io_readData2 : UInt<32>

    reg reg_0 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_0) @[RegisterFile.scala 16:22]
    reg reg_1 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_1) @[RegisterFile.scala 16:22]
    reg reg_2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_2) @[RegisterFile.scala 16:22]
    reg reg_3 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_3) @[RegisterFile.scala 16:22]
    reg reg_4 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_4) @[RegisterFile.scala 16:22]
    reg reg_5 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_5) @[RegisterFile.scala 16:22]
    reg reg_6 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_6) @[RegisterFile.scala 16:22]
    reg reg_7 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_7) @[RegisterFile.scala 16:22]
    reg reg_8 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_8) @[RegisterFile.scala 16:22]
    reg reg_9 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_9) @[RegisterFile.scala 16:22]
    reg reg_10 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_10) @[RegisterFile.scala 16:22]
    reg reg_11 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_11) @[RegisterFile.scala 16:22]
    reg reg_12 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_12) @[RegisterFile.scala 16:22]
    reg reg_13 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_13) @[RegisterFile.scala 16:22]
    reg reg_14 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_14) @[RegisterFile.scala 16:22]
    reg reg_15 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_15) @[RegisterFile.scala 16:22]
    reg reg_16 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_16) @[RegisterFile.scala 16:22]
    reg reg_17 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_17) @[RegisterFile.scala 16:22]
    reg reg_18 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_18) @[RegisterFile.scala 16:22]
    reg reg_19 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_19) @[RegisterFile.scala 16:22]
    reg reg_20 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_20) @[RegisterFile.scala 16:22]
    reg reg_21 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_21) @[RegisterFile.scala 16:22]
    reg reg_22 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_22) @[RegisterFile.scala 16:22]
    reg reg_23 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_23) @[RegisterFile.scala 16:22]
    reg reg_24 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_24) @[RegisterFile.scala 16:22]
    reg reg_25 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_25) @[RegisterFile.scala 16:22]
    reg reg_26 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_26) @[RegisterFile.scala 16:22]
    reg reg_27 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_27) @[RegisterFile.scala 16:22]
    reg reg_28 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_28) @[RegisterFile.scala 16:22]
    reg reg_29 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_29) @[RegisterFile.scala 16:22]
    reg reg_30 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_30) @[RegisterFile.scala 16:22]
    reg reg_31 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_31) @[RegisterFile.scala 16:22]
    node _io_readData1_T = orr(io_rs1) @[RegisterFile.scala 18:33]
    node _GEN_0 = validif(eq(UInt<1>("h0"), io_rs1), reg_0) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_1 = mux(eq(UInt<1>("h1"), io_rs1), reg_1, _GEN_0) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_2 = mux(eq(UInt<2>("h2"), io_rs1), reg_2, _GEN_1) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_3 = mux(eq(UInt<2>("h3"), io_rs1), reg_3, _GEN_2) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_4 = mux(eq(UInt<3>("h4"), io_rs1), reg_4, _GEN_3) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_5 = mux(eq(UInt<3>("h5"), io_rs1), reg_5, _GEN_4) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_6 = mux(eq(UInt<3>("h6"), io_rs1), reg_6, _GEN_5) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_7 = mux(eq(UInt<3>("h7"), io_rs1), reg_7, _GEN_6) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_8 = mux(eq(UInt<4>("h8"), io_rs1), reg_8, _GEN_7) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_9 = mux(eq(UInt<4>("h9"), io_rs1), reg_9, _GEN_8) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_10 = mux(eq(UInt<4>("ha"), io_rs1), reg_10, _GEN_9) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_11 = mux(eq(UInt<4>("hb"), io_rs1), reg_11, _GEN_10) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_12 = mux(eq(UInt<4>("hc"), io_rs1), reg_12, _GEN_11) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_13 = mux(eq(UInt<4>("hd"), io_rs1), reg_13, _GEN_12) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_14 = mux(eq(UInt<4>("he"), io_rs1), reg_14, _GEN_13) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_15 = mux(eq(UInt<4>("hf"), io_rs1), reg_15, _GEN_14) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_16 = mux(eq(UInt<5>("h10"), io_rs1), reg_16, _GEN_15) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_17 = mux(eq(UInt<5>("h11"), io_rs1), reg_17, _GEN_16) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_18 = mux(eq(UInt<5>("h12"), io_rs1), reg_18, _GEN_17) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_19 = mux(eq(UInt<5>("h13"), io_rs1), reg_19, _GEN_18) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_20 = mux(eq(UInt<5>("h14"), io_rs1), reg_20, _GEN_19) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_21 = mux(eq(UInt<5>("h15"), io_rs1), reg_21, _GEN_20) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_22 = mux(eq(UInt<5>("h16"), io_rs1), reg_22, _GEN_21) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_23 = mux(eq(UInt<5>("h17"), io_rs1), reg_23, _GEN_22) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_24 = mux(eq(UInt<5>("h18"), io_rs1), reg_24, _GEN_23) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_25 = mux(eq(UInt<5>("h19"), io_rs1), reg_25, _GEN_24) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_26 = mux(eq(UInt<5>("h1a"), io_rs1), reg_26, _GEN_25) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_27 = mux(eq(UInt<5>("h1b"), io_rs1), reg_27, _GEN_26) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_28 = mux(eq(UInt<5>("h1c"), io_rs1), reg_28, _GEN_27) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_29 = mux(eq(UInt<5>("h1d"), io_rs1), reg_29, _GEN_28) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_30 = mux(eq(UInt<5>("h1e"), io_rs1), reg_30, _GEN_29) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _GEN_31 = mux(eq(UInt<5>("h1f"), io_rs1), reg_31, _GEN_30) @[RegisterFile.scala 18:24 RegisterFile.scala 18:24]
    node _reg_io_rs1 = _GEN_31 @[RegisterFile.scala 18:24]
    node _io_readData1_T_1 = mux(_io_readData1_T, _reg_io_rs1, UInt<1>("h0")) @[RegisterFile.scala 18:24]
    node _io_readData2_T = orr(io_rs2) @[RegisterFile.scala 19:33]
    node _GEN_32 = validif(eq(UInt<1>("h0"), io_rs2), reg_0) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_33 = mux(eq(UInt<1>("h1"), io_rs2), reg_1, _GEN_32) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_34 = mux(eq(UInt<2>("h2"), io_rs2), reg_2, _GEN_33) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_35 = mux(eq(UInt<2>("h3"), io_rs2), reg_3, _GEN_34) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_36 = mux(eq(UInt<3>("h4"), io_rs2), reg_4, _GEN_35) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_37 = mux(eq(UInt<3>("h5"), io_rs2), reg_5, _GEN_36) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_38 = mux(eq(UInt<3>("h6"), io_rs2), reg_6, _GEN_37) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_39 = mux(eq(UInt<3>("h7"), io_rs2), reg_7, _GEN_38) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_40 = mux(eq(UInt<4>("h8"), io_rs2), reg_8, _GEN_39) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_41 = mux(eq(UInt<4>("h9"), io_rs2), reg_9, _GEN_40) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_42 = mux(eq(UInt<4>("ha"), io_rs2), reg_10, _GEN_41) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_43 = mux(eq(UInt<4>("hb"), io_rs2), reg_11, _GEN_42) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_44 = mux(eq(UInt<4>("hc"), io_rs2), reg_12, _GEN_43) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_45 = mux(eq(UInt<4>("hd"), io_rs2), reg_13, _GEN_44) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_46 = mux(eq(UInt<4>("he"), io_rs2), reg_14, _GEN_45) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_47 = mux(eq(UInt<4>("hf"), io_rs2), reg_15, _GEN_46) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_48 = mux(eq(UInt<5>("h10"), io_rs2), reg_16, _GEN_47) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_49 = mux(eq(UInt<5>("h11"), io_rs2), reg_17, _GEN_48) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_50 = mux(eq(UInt<5>("h12"), io_rs2), reg_18, _GEN_49) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_51 = mux(eq(UInt<5>("h13"), io_rs2), reg_19, _GEN_50) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_52 = mux(eq(UInt<5>("h14"), io_rs2), reg_20, _GEN_51) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_53 = mux(eq(UInt<5>("h15"), io_rs2), reg_21, _GEN_52) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_54 = mux(eq(UInt<5>("h16"), io_rs2), reg_22, _GEN_53) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_55 = mux(eq(UInt<5>("h17"), io_rs2), reg_23, _GEN_54) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_56 = mux(eq(UInt<5>("h18"), io_rs2), reg_24, _GEN_55) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_57 = mux(eq(UInt<5>("h19"), io_rs2), reg_25, _GEN_56) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_58 = mux(eq(UInt<5>("h1a"), io_rs2), reg_26, _GEN_57) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_59 = mux(eq(UInt<5>("h1b"), io_rs2), reg_27, _GEN_58) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_60 = mux(eq(UInt<5>("h1c"), io_rs2), reg_28, _GEN_59) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_61 = mux(eq(UInt<5>("h1d"), io_rs2), reg_29, _GEN_60) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_62 = mux(eq(UInt<5>("h1e"), io_rs2), reg_30, _GEN_61) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _GEN_63 = mux(eq(UInt<5>("h1f"), io_rs2), reg_31, _GEN_62) @[RegisterFile.scala 19:24 RegisterFile.scala 19:24]
    node _reg_io_rs2 = _GEN_63 @[RegisterFile.scala 19:24]
    node _io_readData2_T_1 = mux(_io_readData2_T, _reg_io_rs2, UInt<1>("h0")) @[RegisterFile.scala 19:24]
    node _T = eq(io_regWrite, UInt<1>("h1")) @[RegisterFile.scala 21:22]
    node _T_1 = neq(io_rd, UInt<1>("h0")) @[RegisterFile.scala 21:39]
    node _T_2 = and(_T, _T_1) @[RegisterFile.scala 21:30]
    node _reg_io_rd = io_writeData @[RegisterFile.scala 22:20 RegisterFile.scala 22:20]
    node _GEN_64 = mux(eq(UInt<1>("h0"), io_rd), _reg_io_rd, reg_0) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_65 = mux(eq(UInt<1>("h1"), io_rd), _reg_io_rd, reg_1) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_66 = mux(eq(UInt<2>("h2"), io_rd), _reg_io_rd, reg_2) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_67 = mux(eq(UInt<2>("h3"), io_rd), _reg_io_rd, reg_3) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_68 = mux(eq(UInt<3>("h4"), io_rd), _reg_io_rd, reg_4) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_69 = mux(eq(UInt<3>("h5"), io_rd), _reg_io_rd, reg_5) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_70 = mux(eq(UInt<3>("h6"), io_rd), _reg_io_rd, reg_6) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_71 = mux(eq(UInt<3>("h7"), io_rd), _reg_io_rd, reg_7) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_72 = mux(eq(UInt<4>("h8"), io_rd), _reg_io_rd, reg_8) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_73 = mux(eq(UInt<4>("h9"), io_rd), _reg_io_rd, reg_9) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_74 = mux(eq(UInt<4>("ha"), io_rd), _reg_io_rd, reg_10) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_75 = mux(eq(UInt<4>("hb"), io_rd), _reg_io_rd, reg_11) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_76 = mux(eq(UInt<4>("hc"), io_rd), _reg_io_rd, reg_12) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_77 = mux(eq(UInt<4>("hd"), io_rd), _reg_io_rd, reg_13) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_78 = mux(eq(UInt<4>("he"), io_rd), _reg_io_rd, reg_14) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_79 = mux(eq(UInt<4>("hf"), io_rd), _reg_io_rd, reg_15) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_80 = mux(eq(UInt<5>("h10"), io_rd), _reg_io_rd, reg_16) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_81 = mux(eq(UInt<5>("h11"), io_rd), _reg_io_rd, reg_17) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_82 = mux(eq(UInt<5>("h12"), io_rd), _reg_io_rd, reg_18) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_83 = mux(eq(UInt<5>("h13"), io_rd), _reg_io_rd, reg_19) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_84 = mux(eq(UInt<5>("h14"), io_rd), _reg_io_rd, reg_20) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_85 = mux(eq(UInt<5>("h15"), io_rd), _reg_io_rd, reg_21) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_86 = mux(eq(UInt<5>("h16"), io_rd), _reg_io_rd, reg_22) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_87 = mux(eq(UInt<5>("h17"), io_rd), _reg_io_rd, reg_23) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_88 = mux(eq(UInt<5>("h18"), io_rd), _reg_io_rd, reg_24) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_89 = mux(eq(UInt<5>("h19"), io_rd), _reg_io_rd, reg_25) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_90 = mux(eq(UInt<5>("h1a"), io_rd), _reg_io_rd, reg_26) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_91 = mux(eq(UInt<5>("h1b"), io_rd), _reg_io_rd, reg_27) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_92 = mux(eq(UInt<5>("h1c"), io_rd), _reg_io_rd, reg_28) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_93 = mux(eq(UInt<5>("h1d"), io_rd), _reg_io_rd, reg_29) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_94 = mux(eq(UInt<5>("h1e"), io_rd), _reg_io_rd, reg_30) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_95 = mux(eq(UInt<5>("h1f"), io_rd), _reg_io_rd, reg_31) @[RegisterFile.scala 22:20 RegisterFile.scala 22:20 RegisterFile.scala 16:22]
    node _GEN_96 = mux(_T_2, _GEN_64, reg_0) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_97 = mux(_T_2, _GEN_65, reg_1) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_98 = mux(_T_2, _GEN_66, reg_2) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_99 = mux(_T_2, _GEN_67, reg_3) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_100 = mux(_T_2, _GEN_68, reg_4) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_101 = mux(_T_2, _GEN_69, reg_5) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_102 = mux(_T_2, _GEN_70, reg_6) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_103 = mux(_T_2, _GEN_71, reg_7) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_104 = mux(_T_2, _GEN_72, reg_8) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_105 = mux(_T_2, _GEN_73, reg_9) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_106 = mux(_T_2, _GEN_74, reg_10) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_107 = mux(_T_2, _GEN_75, reg_11) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_108 = mux(_T_2, _GEN_76, reg_12) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_109 = mux(_T_2, _GEN_77, reg_13) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_110 = mux(_T_2, _GEN_78, reg_14) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_111 = mux(_T_2, _GEN_79, reg_15) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_112 = mux(_T_2, _GEN_80, reg_16) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_113 = mux(_T_2, _GEN_81, reg_17) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_114 = mux(_T_2, _GEN_82, reg_18) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_115 = mux(_T_2, _GEN_83, reg_19) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_116 = mux(_T_2, _GEN_84, reg_20) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_117 = mux(_T_2, _GEN_85, reg_21) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_118 = mux(_T_2, _GEN_86, reg_22) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_119 = mux(_T_2, _GEN_87, reg_23) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_120 = mux(_T_2, _GEN_88, reg_24) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_121 = mux(_T_2, _GEN_89, reg_25) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_122 = mux(_T_2, _GEN_90, reg_26) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_123 = mux(_T_2, _GEN_91, reg_27) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_124 = mux(_T_2, _GEN_92, reg_28) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_125 = mux(_T_2, _GEN_93, reg_29) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_126 = mux(_T_2, _GEN_94, reg_30) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _GEN_127 = mux(_T_2, _GEN_95, reg_31) @[RegisterFile.scala 21:48 RegisterFile.scala 16:22]
    node _reg_WIRE_0 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_1 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_2 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_3 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_4 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_5 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_6 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_7 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_8 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_9 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_10 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_11 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_12 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_13 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_14 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_15 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_16 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_17 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_18 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_19 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_20 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_21 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_22 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_23 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_24 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_25 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_26 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_27 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_28 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_29 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_30 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    node _reg_WIRE_31 = UInt<32>("h0") @[RegisterFile.scala 16:30 RegisterFile.scala 16:30]
    io_readData1 <= _io_readData1_T_1 @[RegisterFile.scala 18:18]
    io_readData2 <= _io_readData2_T_1 @[RegisterFile.scala 19:18]
    reg_0 <= mux(reset, _reg_WIRE_0, _GEN_96) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_1 <= mux(reset, _reg_WIRE_1, _GEN_97) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_2 <= mux(reset, _reg_WIRE_2, _GEN_98) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_3 <= mux(reset, _reg_WIRE_3, _GEN_99) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_4 <= mux(reset, _reg_WIRE_4, _GEN_100) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_5 <= mux(reset, _reg_WIRE_5, _GEN_101) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_6 <= mux(reset, _reg_WIRE_6, _GEN_102) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_7 <= mux(reset, _reg_WIRE_7, _GEN_103) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_8 <= mux(reset, _reg_WIRE_8, _GEN_104) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_9 <= mux(reset, _reg_WIRE_9, _GEN_105) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_10 <= mux(reset, _reg_WIRE_10, _GEN_106) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_11 <= mux(reset, _reg_WIRE_11, _GEN_107) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_12 <= mux(reset, _reg_WIRE_12, _GEN_108) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_13 <= mux(reset, _reg_WIRE_13, _GEN_109) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_14 <= mux(reset, _reg_WIRE_14, _GEN_110) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_15 <= mux(reset, _reg_WIRE_15, _GEN_111) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_16 <= mux(reset, _reg_WIRE_16, _GEN_112) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_17 <= mux(reset, _reg_WIRE_17, _GEN_113) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_18 <= mux(reset, _reg_WIRE_18, _GEN_114) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_19 <= mux(reset, _reg_WIRE_19, _GEN_115) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_20 <= mux(reset, _reg_WIRE_20, _GEN_116) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_21 <= mux(reset, _reg_WIRE_21, _GEN_117) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_22 <= mux(reset, _reg_WIRE_22, _GEN_118) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_23 <= mux(reset, _reg_WIRE_23, _GEN_119) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_24 <= mux(reset, _reg_WIRE_24, _GEN_120) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_25 <= mux(reset, _reg_WIRE_25, _GEN_121) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_26 <= mux(reset, _reg_WIRE_26, _GEN_122) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_27 <= mux(reset, _reg_WIRE_27, _GEN_123) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_28 <= mux(reset, _reg_WIRE_28, _GEN_124) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_29 <= mux(reset, _reg_WIRE_29, _GEN_125) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_30 <= mux(reset, _reg_WIRE_30, _GEN_126) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]
    reg_31 <= mux(reset, _reg_WIRE_31, _GEN_127) @[RegisterFile.scala 16:22 RegisterFile.scala 16:22]

  module ControlDecoder :
    input clock : Clock
    input reset : UInt<1>
    input io_opcode : UInt<7>
    output io_MemWrite : UInt<1>
    output io_MemRead : UInt<1>
    output io_Branch : UInt<1>
    output io_RegWrite : UInt<1>
    output io_Mem2Reg : UInt<1>
    output io_Aluop : UInt<3>

    node _T = eq(UInt<6>("h33"), io_opcode) @[Conditional.scala 37:30]
    node _T_1 = eq(UInt<5>("h13"), io_opcode) @[Conditional.scala 37:30]
    node _T_2 = eq(UInt<6>("h23"), io_opcode) @[Conditional.scala 37:30]
    node _T_3 = eq(UInt<2>("h3"), io_opcode) @[Conditional.scala 37:30]
    node _T_4 = eq(UInt<7>("h63"), io_opcode) @[Conditional.scala 37:30]
    node _T_5 = eq(UInt<7>("h6f"), io_opcode) @[Conditional.scala 37:30]
    node _T_6 = eq(UInt<7>("h67"), io_opcode) @[Conditional.scala 37:30]
    node _T_7 = eq(UInt<6>("h37"), io_opcode) @[Conditional.scala 37:30]
    node _T_8 = eq(UInt<5>("h17"), io_opcode) @[Conditional.scala 37:30]
    node _GEN_0 = mux(_T_8, UInt<1>("h0"), UInt<1>("h0")) @[Conditional.scala 39:67 ControlDecoder.scala 89:25 ControlDecoder.scala 16:17]
    node _GEN_1 = mux(_T_8, UInt<1>("h1"), UInt<1>("h0")) @[Conditional.scala 39:67 ControlDecoder.scala 92:25 ControlDecoder.scala 19:17]
    node _GEN_2 = mux(_T_8, UInt<3>("h6"), UInt<3>("h7")) @[Conditional.scala 39:67 ControlDecoder.scala 94:22 ControlDecoder.scala 21:14]
    node _GEN_3 = mux(_T_7, UInt<1>("h0"), _GEN_0) @[Conditional.scala 39:67 ControlDecoder.scala 81:25]
    node _GEN_4 = mux(_T_7, UInt<1>("h1"), _GEN_1) @[Conditional.scala 39:67 ControlDecoder.scala 84:25]
    node _GEN_5 = mux(_T_7, UInt<3>("h6"), _GEN_2) @[Conditional.scala 39:67 ControlDecoder.scala 86:22]
    node _GEN_6 = mux(_T_6, UInt<1>("h0"), _GEN_3) @[Conditional.scala 39:67 ControlDecoder.scala 73:25]
    node _GEN_7 = mux(_T_6, UInt<1>("h1"), _GEN_4) @[Conditional.scala 39:67 ControlDecoder.scala 76:25]
    node _GEN_8 = mux(_T_6, UInt<2>("h3"), _GEN_5) @[Conditional.scala 39:67 ControlDecoder.scala 78:22]
    node _GEN_9 = mux(_T_5, UInt<1>("h0"), _GEN_6) @[Conditional.scala 39:67 ControlDecoder.scala 65:25]
    node _GEN_10 = mux(_T_5, UInt<1>("h1"), _GEN_7) @[Conditional.scala 39:67 ControlDecoder.scala 68:25]
    node _GEN_11 = mux(_T_5, UInt<2>("h3"), _GEN_8) @[Conditional.scala 39:67 ControlDecoder.scala 70:22]
    node _GEN_12 = mux(_T_4, UInt<1>("h0"), _GEN_9) @[Conditional.scala 39:67 ControlDecoder.scala 57:25]
    node _GEN_13 = mux(_T_4, UInt<1>("h1"), _GEN_9) @[Conditional.scala 39:67 ControlDecoder.scala 59:23]
    node _GEN_14 = mux(_T_4, UInt<1>("h0"), _GEN_10) @[Conditional.scala 39:67 ControlDecoder.scala 60:25]
    node _GEN_15 = mux(_T_4, UInt<2>("h2"), _GEN_11) @[Conditional.scala 39:67 ControlDecoder.scala 62:22]
    node _GEN_16 = mux(_T_3, UInt<1>("h0"), _GEN_12) @[Conditional.scala 39:67 ControlDecoder.scala 49:25]
    node _GEN_17 = mux(_T_3, UInt<1>("h1"), _GEN_12) @[Conditional.scala 39:67 ControlDecoder.scala 50:24]
    node _GEN_18 = mux(_T_3, UInt<1>("h0"), _GEN_13) @[Conditional.scala 39:67 ControlDecoder.scala 51:23]
    node _GEN_19 = mux(_T_3, UInt<1>("h1"), _GEN_14) @[Conditional.scala 39:67 ControlDecoder.scala 52:25]
    node _GEN_20 = mux(_T_3, UInt<3>("h4"), _GEN_15) @[Conditional.scala 39:67 ControlDecoder.scala 54:22]
    node _GEN_21 = mux(_T_2, UInt<1>("h1"), _GEN_16) @[Conditional.scala 39:67 ControlDecoder.scala 41:25]
    node _GEN_22 = mux(_T_2, UInt<1>("h0"), _GEN_17) @[Conditional.scala 39:67 ControlDecoder.scala 42:24]
    node _GEN_23 = mux(_T_2, UInt<1>("h0"), _GEN_18) @[Conditional.scala 39:67 ControlDecoder.scala 43:23]
    node _GEN_24 = mux(_T_2, UInt<1>("h0"), _GEN_19) @[Conditional.scala 39:67 ControlDecoder.scala 44:25]
    node _GEN_25 = mux(_T_2, UInt<3>("h5"), _GEN_20) @[Conditional.scala 39:67 ControlDecoder.scala 46:22]
    node _GEN_26 = mux(_T_1, UInt<1>("h0"), _GEN_21) @[Conditional.scala 39:67 ControlDecoder.scala 33:25]
    node _GEN_27 = mux(_T_1, UInt<1>("h0"), _GEN_22) @[Conditional.scala 39:67 ControlDecoder.scala 34:24]
    node _GEN_28 = mux(_T_1, UInt<1>("h0"), _GEN_23) @[Conditional.scala 39:67 ControlDecoder.scala 35:23]
    node _GEN_29 = mux(_T_1, UInt<1>("h1"), _GEN_24) @[Conditional.scala 39:67 ControlDecoder.scala 36:25]
    node _GEN_30 = mux(_T_1, UInt<1>("h1"), _GEN_25) @[Conditional.scala 39:67 ControlDecoder.scala 38:22]
    node _GEN_31 = mux(_T, UInt<1>("h0"), _GEN_26) @[Conditional.scala 40:58 ControlDecoder.scala 25:25]
    node _GEN_32 = mux(_T, UInt<1>("h0"), _GEN_27) @[Conditional.scala 40:58 ControlDecoder.scala 26:24]
    node _GEN_33 = mux(_T, UInt<1>("h0"), _GEN_28) @[Conditional.scala 40:58 ControlDecoder.scala 27:23]
    node _GEN_34 = mux(_T, UInt<1>("h1"), _GEN_29) @[Conditional.scala 40:58 ControlDecoder.scala 28:25]
    node _GEN_35 = mux(_T, UInt<1>("h0"), _GEN_30) @[Conditional.scala 40:58 ControlDecoder.scala 30:22]
    io_MemWrite <= _GEN_31
    io_MemRead <= _GEN_32
    io_Branch <= _GEN_33
    io_RegWrite <= _GEN_34
    io_Mem2Reg <= _GEN_32
    io_Aluop <= _GEN_35

  module Alucontrol :
    input clock : Clock
    input reset : UInt<1>
    input io_Aluop : UInt<3>
    input io_func7 : UInt<7>
    input io_func3 : UInt<3>
    output io_aluctrl : UInt<5>

    node _T = eq(io_Aluop, UInt<1>("h0")) @[Alucontrol.scala 14:20]
    node _T_1 = eq(io_Aluop, UInt<2>("h2")) @[Alucontrol.scala 14:45]
    node _T_2 = or(_T, _T_1) @[Alucontrol.scala 14:33]
    node io_aluctrl_hi_lo = bits(io_func7, 5, 5) @[Alucontrol.scala 15:43]
    node io_aluctrl_hi = cat(UInt<1>("h0"), io_aluctrl_hi_lo) @[Cat.scala 30:58]
    node _io_aluctrl_T = cat(io_aluctrl_hi, io_func3) @[Cat.scala 30:58]
    node _T_3 = eq(io_Aluop, UInt<1>("h1")) @[Alucontrol.scala 16:25]
    node _T_4 = eq(io_func3, UInt<3>("h5")) @[Alucontrol.scala 17:23]
    node io_aluctrl_hi_lo_1 = bits(io_func7, 5, 5) @[Alucontrol.scala 18:47]
    node io_aluctrl_hi_1 = cat(UInt<1>("h0"), io_aluctrl_hi_lo_1) @[Cat.scala 30:58]
    node _io_aluctrl_T_1 = cat(io_aluctrl_hi_1, io_func3) @[Cat.scala 30:58]
    node _io_aluctrl_T_2 = cat(UInt<1>("h0"), io_func3) @[Cat.scala 30:58]
    node _GEN_0 = mux(_T_4, _io_aluctrl_T_1, _io_aluctrl_T_2) @[Alucontrol.scala 17:36 Alucontrol.scala 18:24 Alucontrol.scala 20:24]
    node _T_5 = eq(io_Aluop, UInt<3>("h5")) @[Alucontrol.scala 22:25]
    node _T_6 = eq(io_Aluop, UInt<3>("h4")) @[Alucontrol.scala 22:50]
    node _T_7 = or(_T_5, _T_6) @[Alucontrol.scala 22:38]
    node _T_8 = eq(io_Aluop, UInt<2>("h3")) @[Alucontrol.scala 24:25]
    node _T_9 = eq(io_Aluop, UInt<3>("h6")) @[Alucontrol.scala 26:25]
    node _GEN_1 = mux(_T_9, UInt<1>("h0"), UInt<1>("h0")) @[Alucontrol.scala 26:38 Alucontrol.scala 27:20 Alucontrol.scala 12:16]
    node _GEN_2 = mux(_T_8, UInt<5>("h1f"), _GEN_1) @[Alucontrol.scala 24:38 Alucontrol.scala 25:20]
    node _GEN_3 = mux(_T_7, UInt<1>("h0"), _GEN_2) @[Alucontrol.scala 22:63 Alucontrol.scala 23:20]
    node _GEN_4 = mux(_T_3, _GEN_0, _GEN_3) @[Alucontrol.scala 16:38]
    node _GEN_5 = mux(_T_2, _io_aluctrl_T, _GEN_4) @[Alucontrol.scala 14:58 Alucontrol.scala 15:20]
    io_aluctrl <= _GEN_5

  module Alu :
    input clock : Clock
    input reset : UInt<1>
    input io_op1 : UInt<32>
    input io_op2 : UInt<32>
    input io_aluctrl : UInt<5>
    output io_aluout : UInt<32>

    node _T = eq(io_aluctrl, UInt<1>("h0")) @[Alu.scala 42:21]
    node _T_1 = eq(io_aluctrl, UInt<1>("h0")) @[Alu.scala 42:47]
    node _T_2 = or(_T, _T_1) @[Alu.scala 42:33]
    node _io_aluout_T = add(io_op1, io_op2) @[Alu.scala 43:29]
    node _io_aluout_T_1 = tail(_io_aluout_T, 1) @[Alu.scala 43:29]
    node _T_3 = eq(io_aluctrl, UInt<4>("h8")) @[Alu.scala 44:27]
    node _io_aluout_T_2 = sub(io_op1, io_op2) @[Alu.scala 45:29]
    node _io_aluout_T_3 = tail(_io_aluout_T_2, 1) @[Alu.scala 45:29]
    node _T_4 = eq(io_aluctrl, UInt<3>("h7")) @[Alu.scala 46:27]
    node _T_5 = eq(io_aluctrl, UInt<3>("h7")) @[Alu.scala 46:53]
    node _T_6 = or(_T_4, _T_5) @[Alu.scala 46:39]
    node _io_aluout_T_4 = and(io_op1, io_op2) @[Alu.scala 47:29]
    node _T_7 = eq(io_aluctrl, UInt<3>("h6")) @[Alu.scala 48:27]
    node _T_8 = eq(io_aluctrl, UInt<3>("h6")) @[Alu.scala 48:52]
    node _T_9 = or(_T_7, _T_8) @[Alu.scala 48:38]
    node _io_aluout_T_5 = or(io_op1, io_op2) @[Alu.scala 49:29]
    node _T_10 = eq(io_aluctrl, UInt<3>("h4")) @[Alu.scala 50:27]
    node _T_11 = eq(io_aluctrl, UInt<3>("h4")) @[Alu.scala 50:53]
    node _T_12 = or(_T_10, _T_11) @[Alu.scala 50:39]
    node _io_aluout_T_6 = xor(io_op1, io_op2) @[Alu.scala 51:29]
    node _T_13 = eq(io_aluctrl, UInt<2>("h2")) @[Alu.scala 52:27]
    node _T_14 = eq(io_aluctrl, UInt<2>("h2")) @[Alu.scala 52:53]
    node _T_15 = or(_T_13, _T_14) @[Alu.scala 52:39]
    node _T_16 = asSInt(io_op1) @[Alu.scala 53:21]
    node _T_17 = asSInt(io_op2) @[Alu.scala 53:37]
    node _T_18 = lt(_T_16, _T_17) @[Alu.scala 53:28]
    node _GEN_0 = mux(_T_18, UInt<1>("h1"), UInt<1>("h0")) @[Alu.scala 53:44 Alu.scala 54:23 Alu.scala 56:23]
    node _T_19 = eq(io_aluctrl, UInt<1>("h1")) @[Alu.scala 58:27]
    node _T_20 = eq(io_aluctrl, UInt<1>("h1")) @[Alu.scala 58:53]
    node _T_21 = or(_T_19, _T_20) @[Alu.scala 58:39]
    node _io_aluout_T_7 = bits(io_op2, 4, 0) @[Alu.scala 59:39]
    node _io_aluout_T_8 = dshl(io_op1, _io_aluout_T_7) @[Alu.scala 59:30]
    node _io_aluout_T_9 = bits(_io_aluout_T_8, 31, 0) @[Alu.scala 59:45]
    node _T_22 = eq(io_aluctrl, UInt<2>("h3")) @[Alu.scala 60:27]
    node _T_23 = eq(io_aluctrl, UInt<2>("h3")) @[Alu.scala 60:54]
    node _T_24 = or(_T_22, _T_23) @[Alu.scala 60:40]
    node _T_25 = lt(io_op1, io_op2) @[Alu.scala 61:21]
    node _GEN_1 = mux(_T_25, UInt<1>("h1"), UInt<1>("h0")) @[Alu.scala 61:30 Alu.scala 62:23 Alu.scala 64:23]
    node _T_26 = eq(io_aluctrl, UInt<3>("h5")) @[Alu.scala 66:27]
    node _T_27 = eq(io_aluctrl, UInt<3>("h5")) @[Alu.scala 66:53]
    node _T_28 = or(_T_26, _T_27) @[Alu.scala 66:39]
    node _io_aluout_T_10 = bits(io_op2, 4, 0) @[Alu.scala 67:38]
    node _io_aluout_T_11 = dshr(io_op1, _io_aluout_T_10) @[Alu.scala 67:29]
    node _T_29 = eq(io_aluctrl, UInt<4>("hd")) @[Alu.scala 68:27]
    node _T_30 = eq(io_aluctrl, UInt<4>("hd")) @[Alu.scala 68:53]
    node _T_31 = or(_T_29, _T_30) @[Alu.scala 68:39]
    node _io_aluout_T_12 = asSInt(io_op1) @[Alu.scala 69:30]
    node _io_aluout_T_13 = bits(io_op2, 4, 0) @[Alu.scala 69:46]
    node _io_aluout_T_14 = dshr(_io_aluout_T_12, _io_aluout_T_13) @[Alu.scala 69:37]
    node _io_aluout_T_15 = asUInt(_io_aluout_T_14) @[Alu.scala 69:53]
    node _T_32 = eq(io_aluctrl, UInt<5>("h1f")) @[Alu.scala 70:27]
    node _GEN_2 = mux(_T_32, io_op1, UInt<1>("h0")) @[Alu.scala 70:42 Alu.scala 71:19 Alu.scala 40:15]
    node _GEN_3 = mux(_T_31, _io_aluout_T_15, _GEN_2) @[Alu.scala 68:66 Alu.scala 69:19]
    node _GEN_4 = mux(_T_28, _io_aluout_T_11, _GEN_3) @[Alu.scala 66:67 Alu.scala 67:19]
    node _GEN_5 = mux(_T_24, _GEN_1, _GEN_4) @[Alu.scala 60:68]
    node _GEN_6 = mux(_T_21, _io_aluout_T_9, _GEN_5) @[Alu.scala 58:67 Alu.scala 59:19]
    node _GEN_7 = mux(_T_15, _GEN_0, _GEN_6) @[Alu.scala 52:67]
    node _GEN_8 = mux(_T_12, _io_aluout_T_6, _GEN_7) @[Alu.scala 50:67 Alu.scala 51:19]
    node _GEN_9 = mux(_T_9, _io_aluout_T_5, _GEN_8) @[Alu.scala 48:65 Alu.scala 49:19]
    node _GEN_10 = mux(_T_6, _io_aluout_T_4, _GEN_9) @[Alu.scala 46:67 Alu.scala 47:19]
    node _GEN_11 = mux(_T_3, _io_aluout_T_3, _GEN_10) @[Alu.scala 44:39 Alu.scala 45:19]
    node _GEN_12 = mux(_T_2, _io_aluout_T_1, _GEN_11) @[Alu.scala 42:61 Alu.scala 43:19]
    io_aluout <= _GEN_12

  module Branch :
    input clock : Clock
    input reset : UInt<1>
    input io_arg_x : SInt<32>
    input io_arg_y : SInt<32>
    input io_func3 : UInt<3>
    input io_branch : UInt<1>
    output io_br_taken : UInt<1>

    node _T = eq(UInt<1>("h0"), io_func3) @[Conditional.scala 37:30]
    node _io_br_taken_T = eq(io_arg_x, io_arg_y) @[Branch.scala 18:46]
    node _T_1 = eq(UInt<1>("h1"), io_func3) @[Conditional.scala 37:30]
    node _io_br_taken_T_1 = neq(io_arg_x, io_arg_y) @[Branch.scala 19:46]
    node _T_2 = eq(UInt<3>("h4"), io_func3) @[Conditional.scala 37:30]
    node _io_br_taken_T_2 = lt(io_arg_x, io_arg_y) @[Branch.scala 20:46]
    node _T_3 = eq(UInt<3>("h5"), io_func3) @[Conditional.scala 37:30]
    node _io_br_taken_T_3 = geq(io_arg_x, io_arg_y) @[Branch.scala 21:46]
    node _T_4 = eq(UInt<3>("h6"), io_func3) @[Conditional.scala 37:30]
    node _io_br_taken_T_4 = asUInt(io_arg_x) @[Branch.scala 22:46]
    node _io_br_taken_T_5 = asUInt(io_arg_y) @[Branch.scala 22:64]
    node _io_br_taken_T_6 = lt(_io_br_taken_T_4, _io_br_taken_T_5) @[Branch.scala 22:53]
    node _T_5 = eq(UInt<3>("h7"), io_func3) @[Conditional.scala 37:30]
    node _io_br_taken_T_7 = asUInt(io_arg_x) @[Branch.scala 23:46]
    node _io_br_taken_T_8 = asUInt(io_arg_y) @[Branch.scala 23:65]
    node _io_br_taken_T_9 = geq(_io_br_taken_T_7, _io_br_taken_T_8) @[Branch.scala 23:53]
    node _GEN_0 = mux(_T_5, _io_br_taken_T_9, UInt<1>("h0")) @[Conditional.scala 39:67 Branch.scala 23:34 Branch.scala 14:15]
    node _GEN_1 = mux(_T_4, _io_br_taken_T_6, _GEN_0) @[Conditional.scala 39:67 Branch.scala 22:34]
    node _GEN_2 = mux(_T_3, _io_br_taken_T_3, _GEN_1) @[Conditional.scala 39:67 Branch.scala 21:34]
    node _GEN_3 = mux(_T_2, _io_br_taken_T_2, _GEN_2) @[Conditional.scala 39:67 Branch.scala 20:34]
    node _GEN_4 = mux(_T_1, _io_br_taken_T_1, _GEN_3) @[Conditional.scala 39:67 Branch.scala 19:34]
    node _GEN_5 = mux(_T, _io_br_taken_T, _GEN_4) @[Conditional.scala 40:58 Branch.scala 18:34]
    node _GEN_6 = mux(io_branch, _GEN_5, UInt<1>("h0")) @[Branch.scala 16:19 Branch.scala 14:15]
    io_br_taken <= _GEN_6

  module Datamemory :
    input clock : Clock
    input reset : UInt<1>
    input io_Alures : UInt<32>
    input io_WriteData : UInt<32>
    input io_WriteEnable : UInt<1>
    input io_ReadEnable : UInt<1>
    input io_func3 : UInt<3>
    input io_memaddress : UInt<24>
    output io_ReadData : UInt<32>
    output io_memout : UInt<32>
    output io_wmask : UInt<4>

    mem mem_0 : @[Datamemory.scala 18:16]
      data-type => UInt<8>
      depth => 8192
      read-latency => 0
      write-latency => 1
      reader => MPORT
      writer => MPORT_1
      read-under-write => undefined
    mem mem_1 : @[Datamemory.scala 18:16]
      data-type => UInt<8>
      depth => 8192
      read-latency => 0
      write-latency => 1
      reader => MPORT
      writer => MPORT_1
      read-under-write => undefined
    mem mem_2 : @[Datamemory.scala 18:16]
      data-type => UInt<8>
      depth => 8192
      read-latency => 0
      write-latency => 1
      reader => MPORT
      writer => MPORT_1
      read-under-write => undefined
    mem mem_3 : @[Datamemory.scala 18:16]
      data-type => UInt<8>
      depth => 8192
      read-latency => 0
      write-latency => 1
      reader => MPORT
      writer => MPORT_1
      read-under-write => undefined
    node word_addr = bits(io_memaddress, 23, 2) @[Datamemory.scala 19:32]
    node offset = bits(io_memaddress, 1, 0) @[Datamemory.scala 20:29]
    node _T = bits(word_addr, 12, 0) @[Datamemory.scala 24:20]
    node _T_1 = eq(UInt<1>("h0"), io_func3) @[Conditional.scala 37:30]
    node _io_wmask_T = dshl(UInt<1>("h1"), offset) @[Datamemory.scala 30:26]
    node _T_2 = bits(io_WriteData, 7, 0) @[Datamemory.scala 31:50]
    node _T_3 = bits(io_WriteData, 7, 0) @[Datamemory.scala 31:50]
    node _T_4 = bits(io_WriteData, 7, 0) @[Datamemory.scala 31:50]
    node _T_5 = bits(io_WriteData, 7, 0) @[Datamemory.scala 31:50]
    node _T_6 = eq(UInt<1>("h1"), io_func3) @[Conditional.scala 37:30]
    node _io_wmask_T_1 = dshl(UInt<2>("h3"), offset) @[Datamemory.scala 34:32]
    node _T_7 = bits(io_WriteData, 7, 0) @[Datamemory.scala 36:23]
    node _T_8 = bits(io_WriteData, 15, 8) @[Datamemory.scala 36:43]
    node _T_9 = bits(io_WriteData, 7, 0) @[Datamemory.scala 37:23]
    node _T_10 = bits(io_WriteData, 15, 8) @[Datamemory.scala 37:43]
    node _T_11 = eq(UInt<2>("h2"), io_func3) @[Conditional.scala 37:30]
    node _T_12 = bits(io_WriteData, 7, 0) @[Datamemory.scala 43:23]
    node _T_13 = bits(io_WriteData, 15, 8) @[Datamemory.scala 44:23]
    node _T_14 = bits(io_WriteData, 23, 16) @[Datamemory.scala 45:23]
    node _T_15 = bits(io_WriteData, 31, 24) @[Datamemory.scala 46:23]
    node _GEN_0 = mux(_T_11, UInt<4>("hf"), UInt<1>("h0")) @[Conditional.scala 39:67 Datamemory.scala 41:18 Datamemory.scala 26:12]
    node _WIRE_2_0 = _T_12 @[Datamemory.scala 42:25 Datamemory.scala 42:25]
    node _wdata_WIRE_0 = UInt<8>("h0") @[Datamemory.scala 21:34 Datamemory.scala 21:34]
    node _GEN_1 = mux(_T_11, _WIRE_2_0, _wdata_WIRE_0) @[Conditional.scala 39:67 Datamemory.scala 42:15]
    node _WIRE_2_1 = _T_13 @[Datamemory.scala 42:25 Datamemory.scala 42:25]
    node _wdata_WIRE_1 = UInt<8>("h0") @[Datamemory.scala 21:34 Datamemory.scala 21:34]
    node _GEN_2 = mux(_T_11, _WIRE_2_1, _wdata_WIRE_1) @[Conditional.scala 39:67 Datamemory.scala 42:15]
    node _WIRE_2_2 = _T_14 @[Datamemory.scala 42:25 Datamemory.scala 42:25]
    node _wdata_WIRE_2 = UInt<8>("h0") @[Datamemory.scala 21:34 Datamemory.scala 21:34]
    node _GEN_3 = mux(_T_11, _WIRE_2_2, _wdata_WIRE_2) @[Conditional.scala 39:67 Datamemory.scala 42:15]
    node _WIRE_2_3 = _T_15 @[Datamemory.scala 42:25 Datamemory.scala 42:25]
    node _wdata_WIRE_3 = UInt<8>("h0") @[Datamemory.scala 21:34 Datamemory.scala 21:34]
    node _GEN_4 = mux(_T_11, _WIRE_2_3, _wdata_WIRE_3) @[Conditional.scala 39:67 Datamemory.scala 42:15]
    node _GEN_5 = mux(_T_6, _io_wmask_T_1, _GEN_0) @[Conditional.scala 39:67 Datamemory.scala 34:18]
    node _WIRE_1_0 = _T_7 @[Datamemory.scala 35:25 Datamemory.scala 35:25]
    node _GEN_6 = mux(_T_6, _WIRE_1_0, _GEN_1) @[Conditional.scala 39:67 Datamemory.scala 35:15]
    node _WIRE_1_1 = _T_8 @[Datamemory.scala 35:25 Datamemory.scala 35:25]
    node _GEN_7 = mux(_T_6, _WIRE_1_1, _GEN_2) @[Conditional.scala 39:67 Datamemory.scala 35:15]
    node _WIRE_1_2 = _T_9 @[Datamemory.scala 35:25 Datamemory.scala 35:25]
    node _GEN_8 = mux(_T_6, _WIRE_1_2, _GEN_3) @[Conditional.scala 39:67 Datamemory.scala 35:15]
    node _WIRE_1_3 = _T_10 @[Datamemory.scala 35:25 Datamemory.scala 35:25]
    node _GEN_9 = mux(_T_6, _WIRE_1_3, _GEN_4) @[Conditional.scala 39:67 Datamemory.scala 35:15]
    node _GEN_10 = mux(_T_1, _io_wmask_T, _GEN_5) @[Conditional.scala 40:58 Datamemory.scala 30:18]
    node _WIRE__0 = _T_2 @[Datamemory.scala 31:25 Datamemory.scala 31:25]
    node _GEN_11 = mux(_T_1, _WIRE__0, _GEN_6) @[Conditional.scala 40:58 Datamemory.scala 31:15]
    node _WIRE__1 = _T_3 @[Datamemory.scala 31:25 Datamemory.scala 31:25]
    node _GEN_12 = mux(_T_1, _WIRE__1, _GEN_7) @[Conditional.scala 40:58 Datamemory.scala 31:15]
    node _WIRE__2 = _T_4 @[Datamemory.scala 31:25 Datamemory.scala 31:25]
    node _GEN_13 = mux(_T_1, _WIRE__2, _GEN_8) @[Conditional.scala 40:58 Datamemory.scala 31:15]
    node _WIRE__3 = _T_5 @[Datamemory.scala 31:25 Datamemory.scala 31:25]
    node _GEN_14 = mux(_T_1, _WIRE__3, _GEN_9) @[Conditional.scala 40:58 Datamemory.scala 31:15]
    node _T_16 = bits(io_wmask, 0, 0) @[Datamemory.scala 50:42]
    node _T_17 = bits(io_wmask, 1, 1) @[Datamemory.scala 50:42]
    node _T_18 = bits(io_wmask, 2, 2) @[Datamemory.scala 50:42]
    node _T_19 = bits(io_wmask, 3, 3) @[Datamemory.scala 50:42]
    node _T_20 = bits(word_addr, 12, 0)
    node _GEN_24 = mux(io_WriteEnable, _GEN_11, _wdata_WIRE_0) @[Datamemory.scala 27:24]
    node wdata_0 = _GEN_24
    node _GEN_15 = validif(_T_16, wdata_0)
    node _GEN_16 = mux(_T_16, UInt<1>("h1"), UInt<1>("h0"))
    node _GEN_25 = mux(io_WriteEnable, _GEN_12, _wdata_WIRE_1) @[Datamemory.scala 27:24]
    node wdata_1 = _GEN_25
    node _GEN_17 = validif(_T_17, wdata_1)
    node _GEN_18 = mux(_T_17, UInt<1>("h1"), UInt<1>("h0"))
    node _GEN_26 = mux(io_WriteEnable, _GEN_13, _wdata_WIRE_2) @[Datamemory.scala 27:24]
    node wdata_2 = _GEN_26
    node _GEN_19 = validif(_T_18, wdata_2)
    node _GEN_20 = mux(_T_18, UInt<1>("h1"), UInt<1>("h0"))
    node _GEN_27 = mux(io_WriteEnable, _GEN_14, _wdata_WIRE_3) @[Datamemory.scala 27:24]
    node wdata_3 = _GEN_27
    node _GEN_21 = validif(_T_19, wdata_3)
    node _GEN_22 = mux(_T_19, UInt<1>("h1"), UInt<1>("h0"))
    node _GEN_23 = mux(io_WriteEnable, _GEN_10, UInt<1>("h0")) @[Datamemory.scala 27:24 Datamemory.scala 26:12]
    node _GEN_28 = validif(io_WriteEnable, _T_20) @[Datamemory.scala 27:24]
    node _GEN_29 = validif(io_WriteEnable, clock) @[Datamemory.scala 27:24]
    node _GEN_30 = mux(io_WriteEnable, UInt<1>("h1"), UInt<1>("h0")) @[Datamemory.scala 27:24 Datamemory.scala 18:16]
    node _GEN_31 = validif(io_WriteEnable, _GEN_16) @[Datamemory.scala 27:24]
    node _GEN_32 = validif(io_WriteEnable, _GEN_18) @[Datamemory.scala 27:24]
    node _GEN_33 = validif(io_WriteEnable, _GEN_20) @[Datamemory.scala 27:24]
    node _GEN_34 = validif(io_WriteEnable, _GEN_22) @[Datamemory.scala 27:24]
    node _GEN_35 = validif(io_WriteEnable, _GEN_15) @[Datamemory.scala 27:24]
    node _GEN_36 = validif(io_WriteEnable, _GEN_17) @[Datamemory.scala 27:24]
    node _GEN_37 = validif(io_WriteEnable, _GEN_19) @[Datamemory.scala 27:24]
    node _GEN_38 = validif(io_WriteEnable, _GEN_21) @[Datamemory.scala 27:24]
    node rdata_1 = mem_1.MPORT.data @[Datamemory.scala 22:19 Datamemory.scala 24:9]
    node rdata_0 = mem_0.MPORT.data @[Datamemory.scala 22:19 Datamemory.scala 24:9]
    node word_lo = cat(rdata_1, rdata_0) @[Cat.scala 30:58]
    node rdata_3 = mem_3.MPORT.data @[Datamemory.scala 22:19 Datamemory.scala 24:9]
    node rdata_2 = mem_2.MPORT.data @[Datamemory.scala 22:19 Datamemory.scala 24:9]
    node word_hi = cat(rdata_3, rdata_2) @[Cat.scala 30:58]
    node word = cat(word_hi, word_lo) @[Cat.scala 30:58]
    node _half_T = bits(offset, 1, 1) @[Datamemory.scala 54:24]
    node _half_T_1 = cat(rdata_3, rdata_2) @[Cat.scala 30:58]
    node _half_T_2 = cat(rdata_1, rdata_0) @[Cat.scala 30:58]
    node half = mux(_half_T, _half_T_1, _half_T_2) @[Datamemory.scala 54:17]
    node _T_21 = eq(UInt<1>("h0"), io_func3) @[Conditional.scala 37:30]
    node _GEN_39 = validif(eq(UInt<1>("h0"), offset), rdata_0) @[Datamemory.scala 62:36 Datamemory.scala 62:36]
    node _GEN_40 = mux(eq(UInt<1>("h1"), offset), rdata_1, _GEN_39) @[Datamemory.scala 62:36 Datamemory.scala 62:36]
    node _GEN_41 = mux(eq(UInt<2>("h2"), offset), rdata_2, _GEN_40) @[Datamemory.scala 62:36 Datamemory.scala 62:36]
    node _GEN_42 = mux(eq(UInt<2>("h3"), offset), rdata_3, _GEN_41) @[Datamemory.scala 62:36 Datamemory.scala 62:36]
    node _rdata_offset = _GEN_42 @[Datamemory.scala 62:36]
    node _res_T = bits(_rdata_offset, 7, 7) @[Datamemory.scala 62:36]
    node _res_T_1 = bits(_res_T, 0, 0) @[Bitwise.scala 72:15]
    node res_hi = mux(_res_T_1, UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 72:12]
    node _rdata_offset_0 = _GEN_42 @[Cat.scala 30:58]
    node res = cat(res_hi, _rdata_offset_0) @[Cat.scala 30:58]
    node _T_22 = eq(UInt<3>("h4"), io_func3) @[Conditional.scala 37:30]
    node res_hi_1 = mux(UInt<1>("h0"), UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 72:12]
    node _rdata_offset_1 = _GEN_42 @[Cat.scala 30:58]
    node res_1 = cat(res_hi_1, _rdata_offset_1) @[Cat.scala 30:58]
    node _T_23 = eq(UInt<1>("h1"), io_func3) @[Conditional.scala 37:30]
    node _res_T_2 = bits(half, 15, 15) @[Datamemory.scala 72:36]
    node _res_T_3 = bits(_res_T_2, 0, 0) @[Bitwise.scala 72:15]
    node res_hi_2 = mux(_res_T_3, UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 72:12]
    node res_2 = cat(res_hi_2, half) @[Cat.scala 30:58]
    node _T_24 = eq(UInt<3>("h5"), io_func3) @[Conditional.scala 37:30]
    node res_hi_3 = mux(UInt<1>("h0"), UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 72:12]
    node res_3 = cat(res_hi_3, half) @[Cat.scala 30:58]
    node _T_25 = eq(UInt<2>("h2"), io_func3) @[Conditional.scala 37:30]
    node _GEN_43 = mux(_T_25, word, UInt<1>("h0")) @[Conditional.scala 39:67 Datamemory.scala 82:21 Datamemory.scala 57:15]
    node _GEN_44 = mux(_T_24, res_3, _GEN_43) @[Conditional.scala 39:67 Datamemory.scala 78:21]
    node _GEN_45 = mux(_T_23, res_2, _GEN_44) @[Conditional.scala 39:67 Datamemory.scala 73:21]
    node _GEN_46 = mux(_T_22, res_1, _GEN_45) @[Conditional.scala 39:67 Datamemory.scala 68:21]
    node _GEN_47 = mux(_T_21, res, _GEN_46) @[Conditional.scala 40:58 Datamemory.scala 63:21]
    node _GEN_48 = mux(io_ReadEnable, _GEN_47, UInt<1>("h0")) @[Datamemory.scala 59:23 Datamemory.scala 57:15]
    io_ReadData <= _GEN_48
    io_memout <= _GEN_48
    io_wmask <= bits(_GEN_23, 3, 0)
    mem_0.MPORT.addr <= _T @[Datamemory.scala 24:20]
    mem_1.MPORT.addr <= _T @[Datamemory.scala 24:20]
    mem_2.MPORT.addr <= _T @[Datamemory.scala 24:20]
    mem_3.MPORT.addr <= _T @[Datamemory.scala 24:20]
    mem_0.MPORT.en <= UInt<1>("h1") @[Datamemory.scala 24:20]
    mem_1.MPORT.en <= UInt<1>("h1") @[Datamemory.scala 24:20]
    mem_2.MPORT.en <= UInt<1>("h1") @[Datamemory.scala 24:20]
    mem_3.MPORT.en <= UInt<1>("h1") @[Datamemory.scala 24:20]
    mem_0.MPORT.clk <= clock @[Datamemory.scala 24:20]
    mem_1.MPORT.clk <= clock @[Datamemory.scala 24:20]
    mem_2.MPORT.clk <= clock @[Datamemory.scala 24:20]
    mem_3.MPORT.clk <= clock @[Datamemory.scala 24:20]
    mem_0.MPORT_1.addr <= _GEN_28
    mem_1.MPORT_1.addr <= _GEN_28
    mem_2.MPORT_1.addr <= _GEN_28
    mem_3.MPORT_1.addr <= _GEN_28
    mem_0.MPORT_1.en <= _GEN_30
    mem_1.MPORT_1.en <= _GEN_30
    mem_2.MPORT_1.en <= _GEN_30
    mem_3.MPORT_1.en <= _GEN_30
    mem_0.MPORT_1.clk <= _GEN_29
    mem_1.MPORT_1.clk <= _GEN_29
    mem_2.MPORT_1.clk <= _GEN_29
    mem_3.MPORT_1.clk <= _GEN_29
    mem_0.MPORT_1.data <= _GEN_35
    mem_1.MPORT_1.data <= _GEN_36
    mem_2.MPORT_1.data <= _GEN_37
    mem_3.MPORT_1.data <= _GEN_38
    mem_0.MPORT_1.mask <= _GEN_31
    mem_1.MPORT_1.mask <= _GEN_32
    mem_2.MPORT_1.mask <= _GEN_33
    mem_3.MPORT_1.mask <= _GEN_34

  module jalr :
    input clock : Clock
    input reset : UInt<1>
    input io_rs1 : SInt<32>
    input io_imme : SInt<32>
    output io_out : SInt<32>

    node _pc_T = add(io_rs1, io_imme) @[jalr.scala 11:19]
    node _pc_T_1 = tail(_pc_T, 1) @[jalr.scala 11:19]
    node pc = asSInt(_pc_T_1) @[jalr.scala 11:19]
    node _io_out_T = asUInt(pc) @[jalr.scala 12:17]
    node _io_out_T_1 = not(UInt<32>("h1")) @[jalr.scala 12:26]
    node _io_out_T_2 = and(_io_out_T, _io_out_T_1) @[jalr.scala 12:24]
    node _io_out_T_3 = asSInt(_io_out_T_2) @[jalr.scala 12:40]
    io_out <= _io_out_T_3 @[jalr.scala 12:10]

  module Core :
    input clock : Clock
    input reset : UInt<1>
    output io_PC : UInt<32>
    output io_Instruction : UInt<32>
    output io_Datamemoryout : SInt<32>
    output io_Address : UInt<24>
    output io_WriteData : UInt<32>

    inst pc_module of Programcounter @[Core.scala 13:27]
    inst insmemory_module of InstructionMemory @[Core.scala 14:34]
    inst isntdecoder_module of InstructionDecoder @[Core.scala 15:36]
    inst typeDecoder_module of TypeDecoder @[Core.scala 16:36]
    inst immgen_module of ImmediateGen @[Core.scala 17:31]
    inst regfile_module of RegisterFile @[Core.scala 18:32]
    inst controldecoder_module of ControlDecoder @[Core.scala 19:39]
    inst alucontrol_module of Alucontrol @[Core.scala 20:35]
    inst alu_module of Alu @[Core.scala 21:28]
    inst Branch_module of Branch @[Core.scala 22:31]
    inst datamemory_module of Datamemory @[Core.scala 23:35]
    inst jalr_module of jalr @[Core.scala 24:29]
    node pc_uint = asUInt(pc_module.io_out) @[Core.scala 26:36]
    node _insmemory_module_io_readadress_T = bits(pc_uint, 25, 2) @[Core.scala 29:46]
    node _Branch_module_io_arg_x_T = asSInt(regfile_module.io_readData1) @[Core.scala 45:59]
    node _Branch_module_io_arg_y_T = asSInt(regfile_module.io_readData2) @[Core.scala 46:59]
    node _jalr_module_io_rs1_T = asSInt(regfile_module.io_readData1) @[Core.scala 50:55]
    node is_jal = bits(typeDecoder_module.io_jal_out, 0, 0) @[Core.scala 53:48]
    node is_jalr = bits(typeDecoder_module.io_jalr_out, 0, 0) @[Core.scala 54:50]
    node is_branch = and(controldecoder_module.io_Branch, Branch_module.io_br_taken) @[Core.scala 55:53]
    node _next_pc_T = or(is_jal, is_branch) @[Core.scala 59:20]
    node _next_pc_T_1 = mux(_next_pc_T, immgen_module.io_imm_out, pc_module.io_pc4) @[Core.scala 59:12]
    node next_pc = mux(is_jalr, jalr_module.io_out, _next_pc_T_1) @[Core.scala 57:22]
    node _use_imm_T = bits(typeDecoder_module.io_i_out, 0, 0) @[Core.scala 71:47]
    node _use_imm_T_1 = bits(typeDecoder_module.io_load_out, 0, 0) @[Core.scala 72:50]
    node _use_imm_T_2 = or(_use_imm_T, _use_imm_T_1) @[Core.scala 71:54]
    node _use_imm_T_3 = bits(typeDecoder_module.io_store_out, 0, 0) @[Core.scala 73:51]
    node _use_imm_T_4 = or(_use_imm_T_2, _use_imm_T_3) @[Core.scala 72:57]
    node _use_imm_T_5 = bits(typeDecoder_module.io_jalr_out, 0, 0) @[Core.scala 74:50]
    node use_imm = or(_use_imm_T_4, _use_imm_T_5) @[Core.scala 73:58]
    node _alu_module_io_op2_T = asUInt(immgen_module.io_imm_out) @[Core.scala 77:64]
    node _alu_module_io_op2_T_1 = mux(use_imm, _alu_module_io_op2_T, regfile_module.io_readData2) @[Core.scala 77:29]
    node _datamemory_module_io_memaddress_T = bits(alu_module.io_aluout, 23, 0) @[Core.scala 86:60]
    node is_jump = or(is_jal, is_jalr) @[Core.scala 89:26]
    node _is_lui_or_auipc_T = eq(isntdecoder_module.io_opcode, UInt<6>("h37")) @[Core.scala 90:57]
    node _is_lui_or_auipc_T_1 = eq(isntdecoder_module.io_opcode, UInt<5>("h17")) @[Core.scala 90:108]
    node is_lui_or_auipc = or(_is_lui_or_auipc_T, _is_lui_or_auipc_T_1) @[Core.scala 90:75]
    node _regfile_module_io_writeData_T = bits(typeDecoder_module.io_load_out, 0, 0) @[Core.scala 93:40]
    node _regfile_module_io_writeData_T_1 = asUInt(pc_module.io_pc4) @[Core.scala 96:30]
    node _regfile_module_io_writeData_T_2 = asUInt(immgen_module.io_imm_out) @[Core.scala 98:42]
    node _regfile_module_io_writeData_T_3 = mux(is_lui_or_auipc, _regfile_module_io_writeData_T_2, alu_module.io_aluout) @[Core.scala 97:16]
    node _regfile_module_io_writeData_T_4 = mux(is_jump, _regfile_module_io_writeData_T_1, _regfile_module_io_writeData_T_3) @[Core.scala 95:12]
    node _regfile_module_io_writeData_T_5 = mux(_regfile_module_io_writeData_T, datamemory_module.io_memout, _regfile_module_io_writeData_T_4) @[Core.scala 92:39]
    node _io_Datamemoryout_T = asSInt(datamemory_module.io_memout) @[Core.scala 107:53]
    node _io_Address_T = bits(alu_module.io_aluout, 23, 0) @[Core.scala 108:39]
    io_PC <= pc_uint @[Core.scala 105:11]
    io_Instruction <= insmemory_module.io_readdata @[Core.scala 106:20]
    io_Datamemoryout <= _io_Datamemoryout_T @[Core.scala 107:22]
    io_Address <= _io_Address_T @[Core.scala 108:16]
    io_WriteData <= regfile_module.io_readData2 @[Core.scala 109:18]
    pc_module.clock <= clock
    pc_module.reset <= reset
    pc_module.io_in <= next_pc @[Core.scala 64:21]
    insmemory_module.clock <= clock
    insmemory_module.reset <= reset
    insmemory_module.io_readadress <= _insmemory_module_io_readadress_T @[Core.scala 29:36]
    isntdecoder_module.clock <= clock
    isntdecoder_module.reset <= reset
    isntdecoder_module.io_instruction <= insmemory_module.io_readdata @[Core.scala 32:39]
    typeDecoder_module.clock <= clock
    typeDecoder_module.reset <= reset
    typeDecoder_module.io_opcode <= isntdecoder_module.io_opcode @[Core.scala 35:34]
    immgen_module.clock <= clock
    immgen_module.reset <= reset
    immgen_module.io_instruction <= insmemory_module.io_readdata @[Core.scala 33:34]
    immgen_module.io_pc <= pc_uint @[Core.scala 34:25]
    regfile_module.clock <= clock
    regfile_module.reset <= reset
    regfile_module.io_regWrite <= controldecoder_module.io_RegWrite @[Core.scala 39:32]
    regfile_module.io_rs1 <= isntdecoder_module.io_rs1 @[Core.scala 40:27]
    regfile_module.io_rs2 <= isntdecoder_module.io_rs2 @[Core.scala 41:27]
    regfile_module.io_rd <= isntdecoder_module.io_rd @[Core.scala 42:26]
    regfile_module.io_writeData <= _regfile_module_io_writeData_T_5 @[Core.scala 92:33]
    controldecoder_module.clock <= clock
    controldecoder_module.reset <= reset
    controldecoder_module.io_opcode <= isntdecoder_module.io_opcode @[Core.scala 36:37]
    alucontrol_module.clock <= clock
    alucontrol_module.reset <= reset
    alucontrol_module.io_Aluop <= controldecoder_module.io_Aluop @[Core.scala 67:32]
    alucontrol_module.io_func7 <= isntdecoder_module.io_func7 @[Core.scala 68:32]
    alucontrol_module.io_func3 <= isntdecoder_module.io_func3 @[Core.scala 69:32]
    alu_module.clock <= clock
    alu_module.reset <= reset
    alu_module.io_op1 <= regfile_module.io_readData1 @[Core.scala 76:23]
    alu_module.io_op2 <= _alu_module_io_op2_T_1 @[Core.scala 77:23]
    alu_module.io_aluctrl <= alucontrol_module.io_aluctrl @[Core.scala 78:27]
    Branch_module.clock <= clock
    Branch_module.reset <= reset
    Branch_module.io_arg_x <= _Branch_module_io_arg_x_T @[Core.scala 45:28]
    Branch_module.io_arg_y <= _Branch_module_io_arg_y_T @[Core.scala 46:28]
    Branch_module.io_func3 <= isntdecoder_module.io_func3 @[Core.scala 47:28]
    Branch_module.io_branch <= controldecoder_module.io_Branch @[Core.scala 48:29]
    datamemory_module.clock <= clock
    datamemory_module.reset <= reset
    datamemory_module.io_Alures <= alu_module.io_aluout @[Core.scala 81:33]
    datamemory_module.io_WriteData <= regfile_module.io_readData2 @[Core.scala 82:36]
    datamemory_module.io_WriteEnable <= controldecoder_module.io_MemWrite @[Core.scala 83:38]
    datamemory_module.io_ReadEnable <= controldecoder_module.io_MemRead @[Core.scala 84:37]
    datamemory_module.io_func3 <= isntdecoder_module.io_func3 @[Core.scala 85:32]
    datamemory_module.io_memaddress <= _datamemory_module_io_memaddress_T @[Core.scala 86:37]
    jalr_module.clock <= clock
    jalr_module.reset <= reset
    jalr_module.io_rs1 <= _jalr_module_io_rs1_T @[Core.scala 50:24]
    jalr_module.io_imme <= immgen_module.io_imm_out @[Core.scala 51:25]
