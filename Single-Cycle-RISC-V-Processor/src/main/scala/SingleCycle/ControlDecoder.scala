package pipeline
import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

class ControlDecoder extends Module {
    val io = IO (new Bundle {
        val opcode = Input(UInt(7.W))
        val MemWrite = Output(Bool())
        val MemRead = Output(Bool())
        val Branch = Output(Bool())
        val RegWrite = Output(Bool())
        val Mem2Reg = Output(Bool())
        val Aluop = Output(UInt(3.W))
    })

    io.MemWrite := 0.B
    io.MemRead := 0.B
    io.Branch := 0.B
    io.RegWrite := 0.B
    io.Mem2Reg := 0.B
    io.Aluop := 7.U
   
    switch(io.opcode){
        is("b0110011".U){   //r
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 1.B
            io.Mem2Reg := 0.B
            io.Aluop := "b000".U
        }
        is("b0010011".U){ //i
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 1.B
            io.Mem2Reg := 0.B
            io.Aluop := "b001".U
        }
        is ("b0100011".U){ //s
            io.MemWrite := 1.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 0.B
            io.Mem2Reg := 0.B
            io.Aluop := "b101".U
        }
         is ("b0000011".U){ //l
            io.MemWrite := 0.B
            io.MemRead := 1.B 
            io.Branch := 0.B
            io.RegWrite := 1.B
            io.Mem2Reg := 1.B
            io.Aluop := "b100".U
        }
         is("b1100011".U){ //b
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 1.B
            io.RegWrite := 0.B
            io.Mem2Reg := 0.B
            io.Aluop := "b010".U
        }
         is("b1101111".U){//jalr   
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 1.B
            io.Mem2Reg := 0.B
            io.Aluop := "b011".U
        }
         is("b1100111".U){//jal  
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 1.B
            io.Mem2Reg := 0.B
            io.Aluop := "b011".U
        }
        is("b0110111".U){ //lui  
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 1.B
            io.Mem2Reg := 0.B
            io.Aluop := "b110".U
        }
        is("b0010111".U){ // AUIPC
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 1.B         // AUIPC writes to rd
            io.Mem2Reg := 0.B         // data comes from ALU, not memory
            io.Aluop := "b110".U    // ALU does PC + imm
        }
    }
}