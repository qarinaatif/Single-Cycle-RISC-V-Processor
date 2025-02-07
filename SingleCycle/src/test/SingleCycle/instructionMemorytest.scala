package SingleCycle
import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest._

class InstMemtest extends FreeSpec with ChiselScalatestTester{
    "InstMem Test" in {
        test(new InstMem(" ~/ SingleCycle / src / SingleCycle.txt ")) { c =>
            c.io.in.poke(1.S)
            c.clock.step(1)
            c.io.pc4.expect(1.S)
            c.io.out.expect(1.S)
    }}
}