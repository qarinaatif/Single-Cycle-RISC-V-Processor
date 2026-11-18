circuit Programcounter :
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
