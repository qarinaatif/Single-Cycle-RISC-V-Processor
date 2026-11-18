;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit Programcounter : 
  module Programcounter : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip in : SInt<32>, out : SInt<32>, pc4 : SInt<32>}
    
    reg reg : SInt<32>, clock with : (reset => (reset, asSInt(UInt<32>("h00")))) @[Programcounter.scala 11:22]
    reg <= io.in @[Programcounter.scala 12:9]
    node _io_pc4_T = add(reg, asSInt(UInt<4>("h04"))) @[Programcounter.scala 13:19]
    node _io_pc4_T_1 = tail(_io_pc4_T, 1) @[Programcounter.scala 13:19]
    node _io_pc4_T_2 = asSInt(_io_pc4_T_1) @[Programcounter.scala 13:19]
    io.pc4 <= _io_pc4_T_2 @[Programcounter.scala 13:12]
    io.out <= reg @[Programcounter.scala 14:12]
    
