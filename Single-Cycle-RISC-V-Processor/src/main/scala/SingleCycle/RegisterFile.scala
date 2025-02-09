import chisel3._
import chisel3.util._

class RegisterFile extends Modules{
    val io = IO(new Bundel{
        val regWrite = Input(UInt(1.W))
        val rs1 = Input(UInt(5.W))
        val rs2 = Input(UInt(5.W))
        val rd = Input(UInt(5.W))
        val writeregester1 = Input(UInt(32.W))
        val writeregester2 = Input(UInt(32.W))
    })
    
    val reg = Reg(Vec(32, UInt(32.W)))

    io.rdata1 := Mux (( io . raddr1 . orR ) , regs ( io . raddr1 ) , 0. U )
    io.rdata2 := Mux (( io . raddr2 . orR ) , regs ( io . raddr2 ) , 0. U )
    when ( io . wen & io . waddr . orR ) {
    regs ( io . waddr ) := io . wdata
}
}
