package SingleCycle
import chisel3._
import chisel3.util._

class Datamemory extends Module {
  val io = IO(new Bundle {
    val Alures = Input(UInt(32.W))    
    val WriteData = Input(UInt(32.W))    
    val WriteEnable = Input(Bool())
    val ReadEnable = Input(Bool())
    val func3 = Input(UInt(3.W))
    val memaddress = Input(UInt(24.W))    
    val ReadData = Output(UInt(32.W))
    val memout = Output(UInt(32.W))
    val wmask = Output(UInt(4.W))
  })

  val mem = Mem(8192, Vec(4, UInt(8.W)))
  val word_addr = io.memaddress(23, 2)
  val offset = io.memaddress(1, 0)
  val wdata = WireDefault(VecInit(Seq.fill(4)(0.U(8.W))))
  val rdata = Wire(Vec(4, UInt(8.W)))

  rdata := mem.read(word_addr)

  io.wmask := 0.U
  when(io.WriteEnable) {
    switch(io.func3) {
      is("b000".U) { // SB
        io.wmask := (1.U << offset).asUInt
        wdata := VecInit(Seq.fill(4)(io.WriteData(7, 0)))
      }
      is("b001".U) { // SH
        io.wmask := ("b0011".U << offset).asUInt
        wdata := VecInit(Seq(
          io.WriteData(7, 0), io.WriteData(15, 8),
          io.WriteData(7, 0), io.WriteData(15, 8)
        ))
      }
      is("b010".U) { // SW
        io.wmask := "b1111".U
        wdata := VecInit(Seq(
          io.WriteData(7, 0),
          io.WriteData(15, 8),
          io.WriteData(23, 16),
          io.WriteData(31, 24)
        ))
      }
    }
    mem.write(word_addr, wdata, io.wmask.asBools)
  }

  val word = Cat(rdata(3), rdata(2), rdata(1), rdata(0))
  val half = Mux(offset(1), Cat(rdata(3), rdata(2)), Cat(rdata(1), rdata(0)))
  val byte = rdata(offset)

  io.ReadData := 0.U
  io.memout := 0.U
  when(io.ReadEnable) {
    switch(io.func3) {
      is("b000".U) { // LB
        val res = Cat(Fill(24, byte(7)), byte)
        io.ReadData := res
        io.memout := res
      }
      is("b100".U) { // LBU
        val res = Cat(Fill(24, 0.U), byte)
        io.ReadData := res
        io.memout := res
      }
      is("b001".U) { // LH
        val res = Cat(Fill(16, half(15)), half)
        io.ReadData := res
        io.memout := res
      }
      is("b101".U) { // LHU
        val res = Cat(Fill(16, 0.U), half)
        io.ReadData := res
        io.memout := res
      }
      is("b010".U) { // LW
        io.ReadData := word
        io.memout := word
      }
    }
  }
}
