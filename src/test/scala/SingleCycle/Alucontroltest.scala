package SingleCycle
import chiseltest._
import chisel3._
import org.scalatest._

class Alucontroltest extends FreeSpec with ChiselScalatestTester {
    "Alucontroltest" in {
        test(new Alucontrol()) { c =>
            // Test for ADD
            c.io.Aluop.poke("b10".U)
            c.io.func7.poke("b0000000".U)
            c.io.func3.poke("b000".U)
            c.clock.step()
            c.io.aluctrl.expect("b00000".U)
            
            // Test for SUB
            c.io.Aluop.poke("b10".U)
            c.io.func7.poke("b0100000".U)
            c.io.func3.poke("b000".U)
            c.clock.step()
            c.io.aluctrl.expect("b01000".U)
        }
    }
}