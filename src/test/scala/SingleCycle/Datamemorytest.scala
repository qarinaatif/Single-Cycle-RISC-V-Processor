package SingleCycle
import chiseltest._
import chisel3._
import org.scalatest._

class Datamemorytest extends FreeSpec with ChiselScalatestTester {
    "Datamemorytest" in {
        test(new Datamemory()) { c =>
            // Read from address 0 initially
            c.io.WriteEnable.poke(0.B)
            c.io.ReadEnable.poke(1.B)
            c.io.memaddress.poke(0.U)
            c.io.func3.poke("b010".U) // LW
            c.clock.step()
            c.io.memout.expect(0.U)

            // Write 100101795 to address 0
            c.io.WriteEnable.poke(1.B)
            c.io.ReadEnable.poke(0.B)
            c.io.WriteData.poke(100101795.U)
            c.io.memaddress.poke(0.U)
            c.io.func3.poke("b010".U) // SW
            c.clock.step()

            // Read back from address 0
            c.io.WriteEnable.poke(0.B)
            c.io.ReadEnable.poke(1.B)
            c.io.memaddress.poke(0.U)
            c.io.func3.poke("b010".U) // LW
            c.clock.step()
            c.io.memout.expect(100101795.U)
        }
    }
}