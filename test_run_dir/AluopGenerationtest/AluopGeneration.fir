;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit AluopGeneration : 
  module AluopGeneration : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip opcode : UInt<7>, aluop : UInt<2>}
    
    io.aluop <= UInt<1>("h00") @[AluopGenenation.scala 11:14]
    node _T = eq(UInt<6>("h033"), io.opcode) @[Conditional.scala 37:30]
    when _T : @[Conditional.scala 40:58]
      io.aluop <= UInt<2>("h02") @[AluopGenenation.scala 14:36]
      skip @[Conditional.scala 40:58]
    else : @[Conditional.scala 39:67]
      node _T_1 = eq(UInt<5>("h013"), io.opcode) @[Conditional.scala 37:30]
      when _T_1 : @[Conditional.scala 39:67]
        io.aluop <= UInt<2>("h02") @[AluopGenenation.scala 15:36]
        skip @[Conditional.scala 39:67]
      else : @[Conditional.scala 39:67]
        node _T_2 = eq(UInt<7>("h063"), io.opcode) @[Conditional.scala 37:30]
        when _T_2 : @[Conditional.scala 39:67]
          io.aluop <= UInt<1>("h01") @[AluopGenenation.scala 16:36]
          skip @[Conditional.scala 39:67]
        else : @[Conditional.scala 39:67]
          node _T_3 = eq(UInt<2>("h03"), io.opcode) @[Conditional.scala 37:30]
          when _T_3 : @[Conditional.scala 39:67]
            io.aluop <= UInt<1>("h00") @[AluopGenenation.scala 17:36]
            skip @[Conditional.scala 39:67]
          else : @[Conditional.scala 39:67]
            node _T_4 = eq(UInt<6>("h023"), io.opcode) @[Conditional.scala 37:30]
            when _T_4 : @[Conditional.scala 39:67]
              io.aluop <= UInt<1>("h00") @[AluopGenenation.scala 18:36]
              skip @[Conditional.scala 39:67]
            else : @[Conditional.scala 39:67]
              node _T_5 = eq(UInt<5>("h017"), io.opcode) @[Conditional.scala 37:30]
              when _T_5 : @[Conditional.scala 39:67]
                io.aluop <= UInt<2>("h03") @[AluopGenenation.scala 19:36]
                skip @[Conditional.scala 39:67]
              else : @[Conditional.scala 39:67]
                node _T_6 = eq(UInt<6>("h037"), io.opcode) @[Conditional.scala 37:30]
                when _T_6 : @[Conditional.scala 39:67]
                  io.aluop <= UInt<2>("h03") @[AluopGenenation.scala 20:36]
                  skip @[Conditional.scala 39:67]
    
