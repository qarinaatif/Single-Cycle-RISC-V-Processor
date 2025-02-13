package SingleCycle
import chisel3._
import chiseltest._
import org.scalatest._

class SingleCycletest extends FreeSpec with ChiselScalatestTester {
  "SingleCycletest" in {
    test(new SingleCycle) { c =>
      c.clock.step(85)

    }
  }
}
