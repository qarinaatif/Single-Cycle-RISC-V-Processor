package SingleCycle
import chisel3._
import chisel3.util._

class RegisterFile(XLEN: Int) extends Module{
    val io = IO(new Bundle{
        val regWrite = Input(UInt(1.W))
        val rs1 = Input(UInt(5.W))
        val rs2 = Input(UInt(5.W))
        val rd = Input(UInt(5.W))
        val writeData = Input(UInt(XLEN.W))
        val readData1 = Output(UInt(XLEN.W))
        val readData2 = Output(UInt(XLEN.W))
    })
    
    val reg = RegInit(VecInit(Seq.fill(32)(0.U(XLEN.W))))

    io.readData1 := Mux((io.rs1.orR), reg(io.rs1), 0.U)
    io.readData2 := Mux((io.rs2.orR), reg(io.rs2), 0.U)
    
    when(io.regWrite === 1.U && io.rd =/= 0.U) {
        reg(io.rd) := io.writeData
    }
}
