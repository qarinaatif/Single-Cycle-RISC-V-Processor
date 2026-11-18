;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit InstructionMemory : 
  module InstructionMemory : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip readadress : UInt<32>, readdata : UInt<32>}
    
    cmem mem : UInt<32>[4096] @[InstructionMemory.scala 12:18]
    node _io_readdata_T = bits(io.readadress, 11, 0) @[InstructionMemory.scala 15:28]
    read mport io_readdata_MPORT = mem[_io_readdata_T], clock @[InstructionMemory.scala 15:28]
    io.readdata <= io_readdata_MPORT @[InstructionMemory.scala 15:17]
    
