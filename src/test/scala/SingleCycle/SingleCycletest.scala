package SingleCycle
import chiseltest._
import chisel3._
import org.scalatest._

class SingleCycletest extends FreeSpec with ChiselScalatestTester {
    "SingleCycletest" in {
        test(new Core()) { c =>
            // Cycle 0: PC = 0, executing `addi x3, x0, 7`
            c.io.PC.expect(0.U)
            c.clock.step(1)

            // Cycle 1: PC = 4, executing `sw x3, 0(x8)`
            c.io.PC.expect(4.U)
            c.clock.step(1)

            // Cycle 2: PC = 8, executing `add x1, x0, x1`
            c.io.PC.expect(8.U)
            c.clock.step(1)

            // Cycle 3: PC = 12, executing `slli x2, x1, 3`
            c.io.PC.expect(12.U)
            c.clock.step(1)

            // Step a few more cycles
            c.clock.step(5)
        }
    }
}
