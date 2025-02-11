package SingleCycle
import chisel3._
import chiseltest._
import org.scalatest._

class AluopGenerationtest extends FreeSpec with ChiselScalatestTester {
  "AluopGenerationtest" in {
    test(new AluopGeneration()) { c =>
      c.io.opcode.poke("b0110011".U)  
      c.io.func3.poke("b000".U)       
      c.io.func7.poke("b0000000".U)  
      c.io.aluop.expect("b000".U)

      c.io.func7.poke("b0100000".U)   
      c.io.aluop.expect("b001".U)
   
      c.io.opcode.poke("b0010011".U)  
      c.io.func3.poke("b000".U)       
      c.io.aluop.expect("b000".U)     

      c.io.func3.poke("b111".U)       
      c.io.aluop.expect("b010".U)
    
      c.io.opcode.poke("b0100011".U)  
      c.io.aluop.expect("b001".U)

      c.io.opcode.poke("b1100011".U)  
      c.io.func3.poke("b000".U)       
      c.io.aluop.expect("b001".U)

      c.io.func3.poke("b100".U)       
      c.io.aluop.expect("b110".U)
   
      c.io.opcode.poke("b0110111".U)  
      c.io.aluop.expect("b100".U)

      c.io.opcode.poke("b0010111".U)  
      c.io.aluop.expect("b100".U)
   
      c.io.opcode.poke("b1101111".U)  
      c.io.aluop.expect("b000".U)
    }
  }
}
