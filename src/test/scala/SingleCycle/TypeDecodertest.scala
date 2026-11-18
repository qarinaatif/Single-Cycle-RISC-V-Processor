package SingleCycle
import chiseltest._
import chisel3._
import org.scalatest._

class TypeDecodertest extends FreeSpec with ChiselScalatestTester {
    "TypeDecodertest" in{
        test(new TypeDecoder) { c =>
            c.io.opcode.poke("b000011".U) 
            c.clock.step(1)
            c.io.load_out.expect(1.U) 
            
            c.io.opcode.poke("b010011".U)
            c.clock.step(1)
            c.io.i_out.expect(1.U)
            
            c.io.opcode.poke("b110011".U)
            c.clock.step(1)
            c.io.r_out.expect(1.U)
        }
    }   
}