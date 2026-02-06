;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit InstructionDecoder : 
  module InstructionDecoder : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip instruction : UInt<32>, opcode : UInt<7>, rd : UInt<5>, func7 : UInt<7>, func3 : UInt<3>, rs1 : UInt<5>, rs2 : UInt<5>}
    
    node opcode = bits(io.instruction, 6, 0) @[InstructionDecoder.scala 16:36]
    node rd = bits(io.instruction, 11, 7) @[InstructionDecoder.scala 17:32]
    node func7 = bits(io.instruction, 31, 25) @[InstructionDecoder.scala 18:35]
    node func3 = bits(io.instruction, 14, 12) @[InstructionDecoder.scala 19:35]
    node rs1 = bits(io.instruction, 19, 15) @[InstructionDecoder.scala 20:33]
    node rs2 = bits(io.instruction, 24, 20) @[InstructionDecoder.scala 21:33]
    io.opcode <= opcode @[InstructionDecoder.scala 23:19]
    io.rd <= rd @[InstructionDecoder.scala 24:15]
    io.func7 <= func7 @[InstructionDecoder.scala 25:18]
    io.func3 <= func3 @[InstructionDecoder.scala 26:18]
    io.rs1 <= rs1 @[InstructionDecoder.scala 27:16]
    io.rs2 <= rs2 @[InstructionDecoder.scala 28:16]
    
