circuit InstructionMemory :
  module InstructionMemory :
    input clock : Clock
    input reset : UInt<1>
    input io_readadress : UInt<32>
    output io_readdata : UInt<32>

    mem mem : @[InstructionMemory.scala 12:18]
      data-type => UInt<32>
      depth => 4096
      read-latency => 0
      write-latency => 1
      reader => io_readdata_MPORT
      read-under-write => undefined
    node _io_readdata_T = bits(io_readadress, 11, 0) @[InstructionMemory.scala 15:28]
    io_readdata <= mem.io_readdata_MPORT.data @[InstructionMemory.scala 15:17]
    mem.io_readdata_MPORT.addr <= _io_readdata_T @[InstructionMemory.scala 15:28]
    mem.io_readdata_MPORT.en <= UInt<1>("h1") @[InstructionMemory.scala 15:28]
    mem.io_readdata_MPORT.clk <= clock @[InstructionMemory.scala 15:28]
