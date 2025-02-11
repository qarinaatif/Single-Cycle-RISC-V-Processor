package SingleCycle
import chisel3._
import chisel3.util._

class AluopGeneration extends Module {
    val io = IO(new Bundle{
        val opcode = Input(UInt(7.W))    
        val func3 = Input(UInt(3.W))     
        val func7 = Input(UInt(7.W))     
        val aluop = Output(UInt(3.W))    
    })

    io.aluop := "b000".U   

    switch(io.opcode) {
        is("b0110011".U) {  
            switch(io.func3) {
                is("b000".U) {
                    when(io.func7 === "b0000000".U) { io.aluop := "b000".U }  
                    .elsewhen(io.func7 === "b0100000".U) { io.aluop := "b001".U } 
                }
                is("b001".U) { io.aluop := "b010".U }
                is("b010".U) { io.aluop := "b110".U }
                is("b011".U) { io.aluop := "b111".U }
                is("b100".U) { io.aluop := "b010".U }
                is("b101".U) { io.aluop := "b011".U }
                is("b110".U) { io.aluop := "b100".U }
                is("b111".U) { io.aluop := "b101".U }
            }
        }
        
        is("b0010011".U) { 
            switch(io.func3) {
                is("b000".U) { io.aluop := "b000".U }
                is("b111".U) { io.aluop := "b010".U }
                is("b110".U) { io.aluop := "b011".U }
                is("b100".U) { io.aluop := "b100".U }
                is("b010".U) { io.aluop := "b110".U }
                is("b011".U) { io.aluop := "b111".U }
            }
        }

        is("b0100011".U) {  
            io.aluop := "b001".U 
        }

        is("b1100011".U) {  
            switch(io.func3) {
                is("b000".U) { io.aluop := "b001".U }
                is("b001".U) { io.aluop := "b001".U }
                is("b100".U) { io.aluop := "b110".U }
                is("b101".U) { io.aluop := "b111".U }
                is("b110".U) { io.aluop := "b110".U }
                is("b111".U) { io.aluop := "b111".U }
            }
        }

        is("b0110111".U) { io.aluop := "b100".U }  
        is("b0010111".U) { io.aluop := "b100".U }  

        is("b1101111".U) { io.aluop := "b000".U }  
    }
}
