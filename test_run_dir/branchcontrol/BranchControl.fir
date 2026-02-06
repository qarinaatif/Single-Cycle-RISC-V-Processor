;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit BranchControl : 
  module BranchControl : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip fnct3 : UInt<3>, flip branch : UInt<1>, flip arg_x : UInt<32>, flip arg_y : UInt<32>, br_taken : UInt<1>}
    
    io.br_taken <= UInt<1>("h00") @[BranchControl.scala 14:21]
    when io.branch : @[BranchControl.scala 15:24]
      node _T = eq(UInt<1>("h00"), io.fnct3) @[Conditional.scala 37:30]
      when _T : @[Conditional.scala 40:58]
        node _io_br_taken_T = eq(io.arg_x, io.arg_y) @[BranchControl.scala 18:46]
        io.br_taken <= _io_br_taken_T @[BranchControl.scala 18:33]
        skip @[Conditional.scala 40:58]
      else : @[Conditional.scala 39:67]
        node _T_1 = eq(UInt<1>("h01"), io.fnct3) @[Conditional.scala 37:30]
        when _T_1 : @[Conditional.scala 39:67]
          node _io_br_taken_T_1 = neq(io.arg_x, io.arg_y) @[BranchControl.scala 21:46]
          io.br_taken <= _io_br_taken_T_1 @[BranchControl.scala 21:33]
          skip @[Conditional.scala 39:67]
        else : @[Conditional.scala 39:67]
          node _T_2 = eq(UInt<2>("h02"), io.fnct3) @[Conditional.scala 37:30]
          when _T_2 : @[Conditional.scala 39:67]
            node _io_br_taken_T_2 = lt(io.arg_x, io.arg_y) @[BranchControl.scala 24:46]
            io.br_taken <= _io_br_taken_T_2 @[BranchControl.scala 24:33]
            skip @[Conditional.scala 39:67]
          else : @[Conditional.scala 39:67]
            node _T_3 = eq(UInt<3>("h04"), io.fnct3) @[Conditional.scala 37:30]
            when _T_3 : @[Conditional.scala 39:67]
              node _io_br_taken_T_3 = geq(io.arg_x, io.arg_y) @[BranchControl.scala 27:46]
              io.br_taken <= _io_br_taken_T_3 @[BranchControl.scala 27:33]
              skip @[Conditional.scala 39:67]
      skip @[BranchControl.scala 15:24]
    
