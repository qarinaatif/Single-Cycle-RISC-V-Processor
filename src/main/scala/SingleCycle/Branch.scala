package SingleCycle
import chisel3._
import chisel3.util._

class Branch(XLEN: Int) extends Module {
  val io = IO(new Bundle {
    val arg_x = Input(SInt(XLEN.W))
    val arg_y = Input(SInt(XLEN.W))
    val func3 = Input(UInt(3.W))
    val branch = Input(Bool())
    val br_taken= Output(Bool())
  })

  io.br_taken := false.B

  when(io.branch) {
    switch(io.func3) {
      is("b000".U) { io.br_taken := io.arg_x === io.arg_y }             // BEQ
      is("b001".U) { io.br_taken := io.arg_x =/= io.arg_y }             // BNE
      is("b100".U) { io.br_taken := io.arg_x < io.arg_y }               // BLT
      is("b101".U) { io.br_taken := io.arg_x >= io.arg_y }              // BGE
      is("b110".U) { io.br_taken := io.arg_x.asUInt < io.arg_y.asUInt } // BLTU
      is("b111".U) { io.br_taken := io.arg_x.asUInt >= io.arg_y.asUInt }// BGEU
    }
  }
}
