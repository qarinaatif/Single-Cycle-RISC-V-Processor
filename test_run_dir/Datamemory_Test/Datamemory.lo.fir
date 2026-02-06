circuit Datamemory :
  module Datamemory :
    input clock : Clock
    input reset : UInt<1>
    input io_memwrite : UInt<1>
    input io_memread : UInt<1>
    input io_memaddress : UInt<24>
    input io_memdata : SInt<32>
    output io_memout : SInt<32>

    mem mem : @[Datamemory.scala 13:18]
      data-type => SInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => io_memout_MPORT
      writer => MPORT
      read-under-write => undefined
    node _T = eq(io_memwrite, UInt<1>("h1")) @[Datamemory.scala 15:22]
    node _T_1 = eq(io_memread, UInt<1>("h0")) @[Datamemory.scala 15:44]
    node _T_2 = and(_T, _T_1) @[Datamemory.scala 15:30]
    node _T_3 = bits(io_memaddress, 9, 0)
    node _GEN_0 = validif(_T_2, _T_3) @[Datamemory.scala 15:52]
    node _GEN_1 = validif(_T_2, clock) @[Datamemory.scala 15:52]
    node _GEN_2 = mux(_T_2, UInt<1>("h1"), UInt<1>("h0")) @[Datamemory.scala 15:52 Datamemory.scala 13:18]
    node _GEN_3 = validif(_T_2, UInt<1>("h1")) @[Datamemory.scala 15:52]
    node _GEN_4 = validif(_T_2, io_memdata) @[Datamemory.scala 15:52]
    node _GEN_5 = mux(_T_2, asSInt(UInt<1>("h0")), asSInt(UInt<1>("h0"))) @[Datamemory.scala 15:52 Datamemory.scala 17:19 Datamemory.scala 14:15]
    node _T_4 = eq(io_memwrite, UInt<1>("h0")) @[Datamemory.scala 19:22]
    node _T_5 = eq(io_memread, UInt<1>("h1")) @[Datamemory.scala 19:44]
    node _T_6 = and(_T_4, _T_5) @[Datamemory.scala 19:30]
    node _io_memout_T = bits(io_memaddress, 9, 0) @[Datamemory.scala 20:30]
    node _GEN_6 = validif(_T_6, _io_memout_T) @[Datamemory.scala 19:52 Datamemory.scala 20:30]
    node _GEN_7 = validif(_T_6, clock) @[Datamemory.scala 19:52 Datamemory.scala 20:30]
    node _GEN_8 = mux(_T_6, UInt<1>("h1"), UInt<1>("h0")) @[Datamemory.scala 19:52 Datamemory.scala 20:30 Datamemory.scala 13:18]
    node _GEN_9 = mux(_T_6, mem.io_memout_MPORT.data, _GEN_5) @[Datamemory.scala 19:52 Datamemory.scala 20:19]
    io_memout <= _GEN_9
    mem.io_memout_MPORT.addr <= _GEN_6
    mem.io_memout_MPORT.en <= _GEN_8
    mem.io_memout_MPORT.clk <= _GEN_7
    mem.MPORT.addr <= _GEN_0
    mem.MPORT.en <= _GEN_2
    mem.MPORT.clk <= _GEN_1
    mem.MPORT.data <= _GEN_4
    mem.MPORT.mask <= _GEN_3
