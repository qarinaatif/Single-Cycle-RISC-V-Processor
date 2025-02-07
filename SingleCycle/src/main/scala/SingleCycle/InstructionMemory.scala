import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import scala.io.Source

class instructionMemory extends module {
    val readadress = Input(10.W)
    val readdata = Output(UInt(32.W))
}
class InstMem ( initFile : String ) extends Module {
    val io = IO ( new instructionMemory )
    val mem = Mem(1024,UInt(8.W))
    loadMemoryFromFile ( imem , initFile )
    io.readdata := mem ( io.readadress / 4. U )
}