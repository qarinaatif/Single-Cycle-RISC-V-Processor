circuit InstructionDecoder :
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
