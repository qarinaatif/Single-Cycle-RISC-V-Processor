circuit InstructionMemory :
  module InstructionMemory :
    input clock : Clock
    input reset : UInt<1>
    input io_readadress : UInt<24>
    output io_readdata : UInt<32>

    mem mem : @[InstructionMemory.scala 12:18]
      data-type => UInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => io_readdata_MPORT
      read-under-write => undefined
    node _io_readdata_T = div(io_readadress, UInt<3>("h4")) @[InstructionMemory.scala 14:39]
    node _io_readdata_T_1 = bits(_io_readdata_T, 9, 0) @[InstructionMemory.scala 14:23]
    io_readdata <= mem.io_readdata_MPORT.data @[InstructionMemory.scala 14:17]
    mem.io_readdata_MPORT.addr <= _io_readdata_T_1 @[InstructionMemory.scala 14:23]
    mem.io_readdata_MPORT.en <= UInt<1>("h1") @[InstructionMemory.scala 14:23]
    mem.io_readdata_MPORT.clk <= clock @[InstructionMemory.scala 14:23]
