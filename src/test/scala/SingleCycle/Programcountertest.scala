package SingleCycle
import chiseltest._
import chisel3._
import org.scalatest._

class Programcountertest extends FreeSpec with ChiselScalatestTester {
    "Programcountertest" in {
        test(new Programcounter(32)) { c =>
            c.io.in.poke(0.S)
            c.clock.step(1)
            c.io.out.expect(0.S)
            c.io.pc4.expect(4.S)
            c.io.in.poke(4.S)
            c.clock.step(1)
            c.io.out.expect(4.S)
            c.io.pc4.expect(8.S)
        }
    }
}
