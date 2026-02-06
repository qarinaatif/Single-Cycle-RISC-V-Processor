circuit BranchControl :
  module BranchControl :
    input clock : Clock
    input reset : UInt<1>
    input io_fnct3 : UInt<3>
    input io_branch : UInt<1>
    input io_arg_x : UInt<32>
    input io_arg_y : UInt<32>
    output io_br_taken : UInt<1>

    node _T = eq(UInt<1>("h0"), io_fnct3) @[Conditional.scala 37:30]
    node _io_br_taken_T = eq(io_arg_x, io_arg_y) @[BranchControl.scala 18:46]
    node _T_1 = eq(UInt<1>("h1"), io_fnct3) @[Conditional.scala 37:30]
    node _io_br_taken_T_1 = neq(io_arg_x, io_arg_y) @[BranchControl.scala 21:46]
    node _T_2 = eq(UInt<2>("h2"), io_fnct3) @[Conditional.scala 37:30]
    node _io_br_taken_T_2 = lt(io_arg_x, io_arg_y) @[BranchControl.scala 24:46]
    node _T_3 = eq(UInt<3>("h4"), io_fnct3) @[Conditional.scala 37:30]
    node _io_br_taken_T_3 = geq(io_arg_x, io_arg_y) @[BranchControl.scala 27:46]
    node _GEN_0 = mux(_T_3, _io_br_taken_T_3, UInt<1>("h0")) @[Conditional.scala 39:67 BranchControl.scala 27:33 BranchControl.scala 14:21]
    node _GEN_1 = mux(_T_2, _io_br_taken_T_2, _GEN_0) @[Conditional.scala 39:67 BranchControl.scala 24:33]
    node _GEN_2 = mux(_T_1, _io_br_taken_T_1, _GEN_1) @[Conditional.scala 39:67 BranchControl.scala 21:33]
    node _GEN_3 = mux(_T, _io_br_taken_T, _GEN_2) @[Conditional.scala 40:58 BranchControl.scala 18:33]
    node _GEN_4 = mux(io_branch, _GEN_3, UInt<1>("h0")) @[BranchControl.scala 15:24 BranchControl.scala 14:21]
    io_br_taken <= _GEN_4
