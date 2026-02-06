;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit Datamemory : 
  module Datamemory : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip memwrite : UInt<1>, flip memread : UInt<1>, flip memaddress : UInt<24>, flip memdata : SInt<32>, memout : SInt<32>}
    
    cmem mem : SInt<32>[1024] @[Datamemory.scala 13:18]
    io.memout <= asSInt(UInt<1>("h00")) @[Datamemory.scala 14:15]
    node _T = eq(io.memwrite, UInt<1>("h01")) @[Datamemory.scala 15:22]
    node _T_1 = eq(io.memread, UInt<1>("h00")) @[Datamemory.scala 15:44]
    node _T_2 = and(_T, _T_1) @[Datamemory.scala 15:30]
    when _T_2 : @[Datamemory.scala 15:52]
      node _T_3 = bits(io.memaddress, 9, 0)
      write mport MPORT = mem[_T_3], clock
      MPORT <= io.memdata
      io.memout <= asSInt(UInt<1>("h00")) @[Datamemory.scala 17:19]
      skip @[Datamemory.scala 15:52]
    node _T_4 = eq(io.memwrite, UInt<1>("h00")) @[Datamemory.scala 19:22]
    node _T_5 = eq(io.memread, UInt<1>("h01")) @[Datamemory.scala 19:44]
    node _T_6 = and(_T_4, _T_5) @[Datamemory.scala 19:30]
    when _T_6 : @[Datamemory.scala 19:52]
      node _io_memout_T = bits(io.memaddress, 9, 0) @[Datamemory.scala 20:30]
      read mport io_memout_MPORT = mem[_io_memout_T], clock @[Datamemory.scala 20:30]
      io.memout <= io_memout_MPORT @[Datamemory.scala 20:19]
      skip @[Datamemory.scala 19:52]
    
