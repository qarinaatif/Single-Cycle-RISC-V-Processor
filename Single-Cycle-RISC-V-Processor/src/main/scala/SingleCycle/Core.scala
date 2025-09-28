package SingleCycle
import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import scala.io.Source

class Core extends Module{
    val io = IO(new Bundle{
        val PC = Output(UInt(32.W))
        val Instruction = Output(UInt(32.W))
        val Datamemoryout = Output(SInt(32.W))
        val Address = Output(UInt(24.W))
        val WriteData = Output(UInt(32.W.W))
    })
    val pc_module = Module(new Programcounter)
    val insmemory_module = Module(new InstructionMemory("src/test/scala/SingleCycle/instructionmemory.txt"))
    val isntdecoder_module = Module(new InstructionDecoder)
    val typeDecoder_module =Module(new TypeDecoder)
    val immgen_module = Module(new ImmediateGeneration)
    val regfile_module = Module(new RegisterFile)
    val controldecoder_module = Module(new ControlDecoder)
    val alucontrol_module = Module(new Alucontrol)
    val alu_module = Module(new Alu)
    val Branch_module = Module(new Branch)
    val datamemory_module = Module(new Datamemory)
    val jalr_module = Module(new jalr)


    //Fetch 
     pc_module.io.in := MuxLookup (a, 0.S, Array(
        (0.U) -> pc_module.io.pc4,
        (1.U) -> b))

    insmemory_module.io.readadress := pc_module.io.out(25,2)

    //Decode
    isntdecoder_module.io.instruction := insmemory_module.io.readdata
    immgen_module.io.instruction := insmemory_module.io.readdata
    typeDecoder_module.io.opcode := isntdecoder_module.io.opcode 
    controldecoder_module.io.opcode := isntdecoder_module.io.opcode 

    regfile_module.io.regWrite := controldecoder_module.io.RegWrite
    regfile_module.io.rs1 := isntdecoder_module.io.rs1
    regfile_module.io.rs2 := isntdecoder_module.io.rs2
    regfile_module.io.rd := isntdecoder_module.io.rd
    regfile_module.io.writeData := MuxLookup(typeDecoder_module.io.load_out,0.U,Array(
        (0.U) -> alu_module.io.aluout,
        (1.U) -> datamemory_module.io.memout.asUInt  
    ) )

    //Execute
    alucontrol_module.io.Aluop := controldecoder_module.io.Aluop
    alucontrol_module.io.func7 := isntdecoder_module.io.func7
    alucontrol_module.io.func3 := isntdecoder_module.io.func3

    alu_module.io.op1 := regfile_module.io.readData1
    alu_module.io.op2 := MuxLookup (typeDecoder_module.io.i_out, 0.S, Array(
        (0.U) -> regfile_module.io.readData2,
        (1.U) -> immgen_module.io.imm_out))
    alu_module.io.aluctrl := alucontrol_module.io.aluctrl

    Branch_module.io.arg_x := regfile_module.io.readData1
    Branch_module.io.arg_y := regfile_module.io.readData2
    Branch_module.io.func3 := isntdecoder_module.io.func3
    Branch_module.io.branch := controldecoder_module.io.Branch

    jalr_module.io.rs1 := isntdecoder_module.io.rs1
	jalr_module.io.imme := immgen_module.io.imm_out

    //Memory
    datamemory_module.io.Alures :=  controldecoder_module.io.
    datamemory_module.io.WriteData := regfile_module.io.readData2
    datamemory_module.io.WriteEnable := controldecoder_module.io.MemWrite
    datamemory_module.io.ReadEnable := controldecoder_module.io.MemRead
    datamemory_module.io.func3 := isntdecoder_module.io.func3
    datamemory_module.io.memaddress := alucontrol_module.io.aluout(23,0 )

    
    //Outputs
    io.PC := 
    io.Instruction := 
    io.Datamemoryout := 
    io.Address := 
    io.WriteData := 
}