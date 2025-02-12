package SingleCycle
import chisel3._
import chisel3.util._

class ALU extends Module {
    val io = IO(new Bundle {
        val op1 = Input(UInt(32.W))  
        val op2 = Input(UInt(32.W))  
        val aluctrl = Input(UInt(6.W)) 
        val aluout = Output(UInt(32.W)) 
        val zero = Output(UInt(1.W)) 
    })
    val result = Wire(UInt(32.W))
    io.aluout := 0.U  
   
    switch(io.aluctrl) {
        is("b000000".U) { result := io.op1 + io.op2 } // ADD
        is("b000001".U) { result := io.op1 - io.op2 } // SUB
        is("b000010".U) { result := io.op1 << io.op2(4,0) } // SLL 
        is("b000011".U) { result := io.op1 & io.op2 } // AND
        is("b000100".U) { result := io.op1 | io.op2 } // OR
        is("b000101".U) { result := io.op1 ^ io.op2 } // XOR
        is("b000110".U) { result := io.op1 >> io.op2(4,0) } // SRL (
        is("b000111".U) { result := (io.op1.asSInt >> io.op2(4,0)).asUInt } // SRA 
        is("b001000".U) { result := Mux(io.op1.asSInt < io.op2.asSInt, 1.U, 0.U) } // SLT 
        is("b001001".U) { result := Mux(io.op1 < io.op2, 1.U, 0.U) } // SLTU 
       /* is("b111111".U) {
            when(io.branch){
                switch ( io.fnct3) {
                    is ("b0000".U){io.br_taken := (io.op1 === io.op2)} 
                    is ("b0001".U){io.br_taken := (io.op1 =/= io.op2)} 
                    is ("b0010".U){io.br_taken := (io.op1 < io.op2)} 
                    is ("b0100".U){io.br_taken := (io.op1 >= io.op2)} 
                }
            }
        } */       
    }
    io.aluout := result
    io.zero := Mux(result === 0.U, 1.U, 0.U)
}
