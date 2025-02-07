package SingleCycle
import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest._

class instructionMemorytest extends FreeSpec with ChiselScalatestTester{
    "instructionMemory Test" in {
        test(new instructionMemory) { c =>
            c.io.in.poke(1.S)
            c.clock.step(1)
            c.io.pc4.expect(1.S)
            c.io.out.expect(1.S)
    }}
}