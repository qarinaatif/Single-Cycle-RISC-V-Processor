package pipeline
import chisel3._
import chisel3.util._

class jalr(XLEN: Int) extends Module {
  val io = IO (new Bundle {
	val rs1 = Input(SInt(XLEN.W))
	val imme = Input(SInt(XLEN.W))
	val out = Output(SInt(XLEN.W))
  })
	val pc = io.rs1 + io.imme
	io.out := pc & 4294967294L.S
}