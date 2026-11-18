package SingleCycle
import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile

class InstructionMemory(initFile: String) extends Module {
    val io = IO(new Bundle {
        val readadress = Input(UInt(32.W))
        val readdata = Output(UInt(32.W))
    })

    val mem = Mem(4096, UInt(32.W))
    loadMemoryFromFile(mem, initFile)

    io.readdata := mem.read(io.readadress)
}
