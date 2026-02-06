;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit RegisterFile : 
  module RegisterFile : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip regWrite : UInt<1>, flip rs1 : UInt<5>, flip rs2 : UInt<5>, flip rd : UInt<5>, flip writeData : UInt<32>, writeregester1 : UInt<32>, writeregester2 : UInt<32>}
    
    reg reg : UInt<32>[32], clock @[RegisterFile.scala 16:18]
    node _io_writeregester1_T = orr(io.rs1) @[RegisterFile.scala 18:38]
    node _io_writeregester1_T_1 = mux(_io_writeregester1_T, reg[io.rs1], UInt<1>("h00")) @[RegisterFile.scala 18:29]
    io.writeregester1 <= _io_writeregester1_T_1 @[RegisterFile.scala 18:23]
    node _io_writeregester2_T = orr(io.rs2) @[RegisterFile.scala 19:38]
    node _io_writeregester2_T_1 = mux(_io_writeregester2_T, reg[io.rs2], UInt<1>("h00")) @[RegisterFile.scala 19:29]
    io.writeregester2 <= _io_writeregester2_T_1 @[RegisterFile.scala 19:23]
    node _T = eq(io.regWrite, UInt<1>("h01")) @[RegisterFile.scala 21:22]
    node _T_1 = neq(io.rd, UInt<1>("h00")) @[RegisterFile.scala 21:39]
    node _T_2 = and(_T, _T_1) @[RegisterFile.scala 21:30]
    when _T_2 : @[RegisterFile.scala 21:48]
      reg[io.rd] <= io.writeData @[RegisterFile.scala 22:20]
      skip @[RegisterFile.scala 21:48]
    
