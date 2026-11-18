package SingleCycle
import chisel3._
import chisel3.util._

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
        is("b0110011".U){   // R-type
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 1.B
            io.Mem2Reg := 0.B
            io.Aluop := "b000".U
        }
        is("b0010011".U){   // I-type
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 1.B
            io.Mem2Reg := 0.B
            io.Aluop := "b001".U
        }
        is("b0100011".U){   // S-type (Store)
            io.MemWrite := 1.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 0.B
            io.Mem2Reg := 0.B
            io.Aluop := "b101".U
        }
        is("b0000011".U){   // L-type (Load)
            io.MemWrite := 0.B
            io.MemRead := 1.B 
            io.Branch := 0.B
            io.RegWrite := 1.B
            io.Mem2Reg := 1.B
            io.Aluop := "b100".U
        }
        is("b1100011".U){   // B-type (Branch)
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 1.B
            io.RegWrite := 0.B
            io.Mem2Reg := 0.B
            io.Aluop := "b010".U
        }
        is("b1101111".U){   // JAL   
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 1.B
            io.Mem2Reg := 0.B
            io.Aluop := "b011".U
        }
        is("b1100111".U){   // JALR  
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 1.B
            io.Mem2Reg := 0.B
            io.Aluop := "b011".U
        }
        is("b0110111".U){   // LUI  
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 1.B
            io.Mem2Reg := 0.B
            io.Aluop := "b110".U
        }
        is("b0010111".U){   // AUIPC
            io.MemWrite := 0.B
            io.MemRead := 0.B 
            io.Branch := 0.B
            io.RegWrite := 1.B
            io.Mem2Reg := 0.B
            io.Aluop := "b110".U
        }
    }
}
