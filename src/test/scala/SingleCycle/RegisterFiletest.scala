package SingleCycle
import chiseltest._
import chisel3._
import org.scalatest._

class RegisterFiletest extends FreeSpec with ChiselScalatestTester {
    "RegisterFiletest" in {
        test(new RegisterFile(32)) { c =>
            c.io.rs1.poke(0.U)
            c.io.rs2.poke(1.U)
            c.io.rd.poke(2.U)
            c.io.writeData.poke(42.U)
            c.io.regWrite.poke(1.B)
            c.clock.step()
            c.io.readData1.expect(0.U) // rs1 is x0, which is always 0
        }
    }
}