circuit Alu :
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
