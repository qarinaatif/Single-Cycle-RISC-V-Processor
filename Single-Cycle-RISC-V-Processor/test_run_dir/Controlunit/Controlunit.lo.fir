circuit Controlunit :
  module Controlunit :
    input clock : Clock
    input reset : UInt<1>
    input io_r_out : UInt<1>
    input io_load_out : UInt<1>
    input io_store_out : UInt<1>
    input io_sb_out : UInt<1>
    input io_i_out : UInt<1>
    input io_jal_out : UInt<1>
    input io_jalr_out : UInt<1>
    input io_lui_out : UInt<1>
    output io_branchctrl : UInt<1>
    output io_memread : UInt<1>
    output io_memtoreg : UInt<1>
    output io_memwrite : UInt<1>
    output io_regwrite : UInt<1>
    output io_alusrc : UInt<1>

    node _T = eq(UInt<1>("h1"), io_r_out) @[Conditional.scala 37:30]
    node _GEN_0 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[Conditional.scala 40:58 Controlunit.scala 30:30 Controlunit.scala 26:17]
    node _T_1 = eq(UInt<1>("h1"), io_i_out) @[Conditional.scala 37:30]
    node _GEN_1 = mux(_T_1, UInt<1>("h1"), UInt<1>("h0")) @[Conditional.scala 40:58 Controlunit.scala 33:28 Controlunit.scala 27:15]
    node _GEN_2 = mux(_T_1, UInt<1>("h1"), _GEN_0) @[Conditional.scala 40:58 Controlunit.scala 34:25]
    node _T_2 = eq(UInt<1>("h1"), io_sb_out) @[Conditional.scala 37:30]
    node _GEN_3 = mux(_T_2, UInt<1>("h1"), UInt<1>("h0")) @[Conditional.scala 40:58 Controlunit.scala 37:32 Controlunit.scala 22:19]
    node _T_3 = eq(UInt<1>("h1"), io_load_out) @[Conditional.scala 37:30]
    node _GEN_4 = mux(_T_3, UInt<1>("h1"), UInt<1>("h0")) @[Conditional.scala 40:58 Controlunit.scala 40:29 Controlunit.scala 23:16]
    node _GEN_5 = mux(_T_3, UInt<1>("h1"), _GEN_2) @[Conditional.scala 40:58 Controlunit.scala 42:25]
    node _T_4 = eq(UInt<1>("h1"), io_store_out) @[Conditional.scala 37:30]
    node _GEN_6 = mux(_T_4, UInt<1>("h1"), UInt<1>("h0")) @[Conditional.scala 40:58 Controlunit.scala 45:30 Controlunit.scala 25:17]
    node _T_5 = eq(UInt<1>("h1"), io_jal_out) @[Conditional.scala 37:30]
    node _GEN_7 = mux(_T_5, UInt<1>("h1"), _GEN_5) @[Conditional.scala 40:58 Controlunit.scala 48:30]
    node _T_6 = eq(UInt<1>("h1"), io_jalr_out) @[Conditional.scala 37:30]
    node _GEN_8 = mux(_T_6, UInt<1>("h1"), _GEN_7) @[Conditional.scala 40:58 Controlunit.scala 51:31]
    node _T_7 = eq(UInt<1>("h1"), io_lui_out) @[Conditional.scala 37:30]
    node _GEN_9 = mux(_T_7, UInt<1>("h1"), _GEN_8) @[Conditional.scala 40:58 Controlunit.scala 54:30]
    io_branchctrl <= _GEN_3
    io_memread <= _GEN_4
    io_memtoreg <= _GEN_4
    io_memwrite <= _GEN_6
    io_regwrite <= _GEN_9
    io_alusrc <= _GEN_1
