circuit Alucontrol :
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
