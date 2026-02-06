circuit AluopGeneration :
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
