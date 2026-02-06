circuit TypeDecoder :
  module TypeDecoder :
    input clock : Clock
    input reset : UInt<1>
    input io_opcode : UInt<6>
    output io_r_out : UInt<1>
    output io_load_out : UInt<1>
    output io_store_out : UInt<1>
    output io_sb_out : UInt<1>
    output io_i_out : UInt<1>
    output io_jal_out : UInt<1>
    output io_jalr_out : UInt<1>
    output io_lui_out : UInt<1>

    node _T = eq(io_opcode, UInt<2>("h3")) @[TypeDecoder.scala 27:20]
    node _T_1 = eq(io_opcode, UInt<4>("hf")) @[TypeDecoder.scala 29:26]
    node _T_2 = eq(io_opcode, UInt<5>("h13")) @[TypeDecoder.scala 29:55]
    node _T_3 = or(_T_1, _T_2) @[TypeDecoder.scala 29:43]
    node _T_4 = eq(io_opcode, UInt<7>("h73")) @[TypeDecoder.scala 29:84]
    node _T_5 = or(_T_3, _T_4) @[TypeDecoder.scala 29:72]
    node _T_6 = eq(io_opcode, UInt<7>("h67")) @[TypeDecoder.scala 31:26]
    node _T_7 = eq(io_opcode, UInt<6>("h23")) @[TypeDecoder.scala 33:26]
    node _T_8 = eq(io_opcode, UInt<6>("h33")) @[TypeDecoder.scala 35:26]
    node _T_9 = eq(io_opcode, UInt<7>("h63")) @[TypeDecoder.scala 37:26]
    node _T_10 = eq(io_opcode, UInt<7>("h6f")) @[TypeDecoder.scala 39:26]
    node _T_11 = eq(io_opcode, UInt<6>("h37")) @[TypeDecoder.scala 41:26]
    node _GEN_0 = mux(_T_11, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 41:44 TypeDecoder.scala 42:20 TypeDecoder.scala 24:16]
    node _GEN_1 = mux(_T_10, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 39:44 TypeDecoder.scala 40:20 TypeDecoder.scala 23:16]
    node _GEN_2 = mux(_T_10, UInt<1>("h0"), _GEN_0) @[TypeDecoder.scala 39:44 TypeDecoder.scala 24:16]
    node _GEN_3 = mux(_T_9, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 37:44 TypeDecoder.scala 38:19 TypeDecoder.scala 20:15]
    node _GEN_4 = mux(_T_9, UInt<1>("h0"), _GEN_1) @[TypeDecoder.scala 37:44 TypeDecoder.scala 23:16]
    node _GEN_5 = mux(_T_9, UInt<1>("h0"), _GEN_2) @[TypeDecoder.scala 37:44 TypeDecoder.scala 24:16]
    node _GEN_6 = mux(_T_8, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 35:44 TypeDecoder.scala 36:18 TypeDecoder.scala 19:14]
    node _GEN_7 = mux(_T_8, UInt<1>("h0"), _GEN_3) @[TypeDecoder.scala 35:44 TypeDecoder.scala 20:15]
    node _GEN_8 = mux(_T_8, UInt<1>("h0"), _GEN_4) @[TypeDecoder.scala 35:44 TypeDecoder.scala 23:16]
    node _GEN_9 = mux(_T_8, UInt<1>("h0"), _GEN_5) @[TypeDecoder.scala 35:44 TypeDecoder.scala 24:16]
    node _GEN_10 = mux(_T_7, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 33:44 TypeDecoder.scala 34:22 TypeDecoder.scala 21:18]
    node _GEN_11 = mux(_T_7, UInt<1>("h0"), _GEN_6) @[TypeDecoder.scala 33:44 TypeDecoder.scala 19:14]
    node _GEN_12 = mux(_T_7, UInt<1>("h0"), _GEN_7) @[TypeDecoder.scala 33:44 TypeDecoder.scala 20:15]
    node _GEN_13 = mux(_T_7, UInt<1>("h0"), _GEN_8) @[TypeDecoder.scala 33:44 TypeDecoder.scala 23:16]
    node _GEN_14 = mux(_T_7, UInt<1>("h0"), _GEN_9) @[TypeDecoder.scala 33:44 TypeDecoder.scala 24:16]
    node _GEN_15 = mux(_T_6, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 31:44 TypeDecoder.scala 32:21 TypeDecoder.scala 25:17]
    node _GEN_16 = mux(_T_6, UInt<1>("h0"), _GEN_10) @[TypeDecoder.scala 31:44 TypeDecoder.scala 21:18]
    node _GEN_17 = mux(_T_6, UInt<1>("h0"), _GEN_11) @[TypeDecoder.scala 31:44 TypeDecoder.scala 19:14]
    node _GEN_18 = mux(_T_6, UInt<1>("h0"), _GEN_12) @[TypeDecoder.scala 31:44 TypeDecoder.scala 20:15]
    node _GEN_19 = mux(_T_6, UInt<1>("h0"), _GEN_13) @[TypeDecoder.scala 31:44 TypeDecoder.scala 23:16]
    node _GEN_20 = mux(_T_6, UInt<1>("h0"), _GEN_14) @[TypeDecoder.scala 31:44 TypeDecoder.scala 24:16]
    node _GEN_21 = mux(_T_5, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 29:102 TypeDecoder.scala 30:18 TypeDecoder.scala 22:14]
    node _GEN_22 = mux(_T_5, UInt<1>("h0"), _GEN_15) @[TypeDecoder.scala 29:102 TypeDecoder.scala 25:17]
    node _GEN_23 = mux(_T_5, UInt<1>("h0"), _GEN_16) @[TypeDecoder.scala 29:102 TypeDecoder.scala 21:18]
    node _GEN_24 = mux(_T_5, UInt<1>("h0"), _GEN_17) @[TypeDecoder.scala 29:102 TypeDecoder.scala 19:14]
    node _GEN_25 = mux(_T_5, UInt<1>("h0"), _GEN_18) @[TypeDecoder.scala 29:102 TypeDecoder.scala 20:15]
    node _GEN_26 = mux(_T_5, UInt<1>("h0"), _GEN_19) @[TypeDecoder.scala 29:102 TypeDecoder.scala 23:16]
    node _GEN_27 = mux(_T_5, UInt<1>("h0"), _GEN_20) @[TypeDecoder.scala 29:102 TypeDecoder.scala 24:16]
    node _GEN_28 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[TypeDecoder.scala 27:37 TypeDecoder.scala 28:21 TypeDecoder.scala 18:17]
    node _GEN_29 = mux(_T, UInt<1>("h0"), _GEN_21) @[TypeDecoder.scala 27:37 TypeDecoder.scala 22:14]
    node _GEN_30 = mux(_T, UInt<1>("h0"), _GEN_22) @[TypeDecoder.scala 27:37 TypeDecoder.scala 25:17]
    node _GEN_31 = mux(_T, UInt<1>("h0"), _GEN_23) @[TypeDecoder.scala 27:37 TypeDecoder.scala 21:18]
    node _GEN_32 = mux(_T, UInt<1>("h0"), _GEN_24) @[TypeDecoder.scala 27:37 TypeDecoder.scala 19:14]
    node _GEN_33 = mux(_T, UInt<1>("h0"), _GEN_25) @[TypeDecoder.scala 27:37 TypeDecoder.scala 20:15]
    node _GEN_34 = mux(_T, UInt<1>("h0"), _GEN_26) @[TypeDecoder.scala 27:37 TypeDecoder.scala 23:16]
    node _GEN_35 = mux(_T, UInt<1>("h0"), _GEN_27) @[TypeDecoder.scala 27:37 TypeDecoder.scala 24:16]
    io_r_out <= _GEN_32
    io_load_out <= _GEN_28
    io_store_out <= _GEN_31
    io_sb_out <= _GEN_33
    io_i_out <= _GEN_29
    io_jal_out <= _GEN_34
    io_jalr_out <= _GEN_30
    io_lui_out <= _GEN_35
