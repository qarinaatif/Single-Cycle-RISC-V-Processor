package SingleCycle
import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import scala.io.Source

class SingleCycle extends Module{
    val io = IO(new Bundle{
        val Output1 = Output(UInt(32.W))
        val datamemOut = Output(SInt(32.W))
        val Address = Output(UInt(24.W))
        val write = Output(UInt(1.W))
    })
    val pc_module = Module(new Programcounter)
    val insmemory_module = Module(new InstructionMemory("src/test/scala/SingleCycle/instructionmemory.txt"))
    val immgen_module = Module(new ImmediateGeneration)
    val isntdecoder_module = Module(new InstructionDecoder)
    val typeDecoder_module =Module(new TypeDecoder)
    val regfile_module = Module(new RegisterFile)
    val aluopgen_module = Module(new AluopGeneration)
    val alucontrol_module = Module(new Alucontrol)
    val alu_module = Module(new Alu)
    val datamemory_module = Module(new Datamemory)


    //Fetch 
    val a = typeDecoder_module.io.sb_out & alu_module.io.zero
    val b = pc_module.io.out + immgen_module.io.immd_se.asSInt

    pc_module.io.in := MuxLookup (a, 0.S, Array(
        (0.U) -> pc_module.io.pc4,
        (1.U) -> b))

    insmemory_module.io.readadress := pc_module.io.out(25,2)
    //Decode
    isntdecoder_module.io.instruction := insmemory_module.io.readdata
    immgen_module.io.instruction := insmemory_module.io.readdata

    typeDecoder_module.io.opcode := isntdecoder_module.io.opcode 

    aluopgen_module.io.opcode := isntdecoder_module.io.opcode


    val regWrite = typeDecoder_module.io.r_out | typeDecoder_module.io.i_out | typeDecoder_module.io.jal_out | typeDecoder_module.io.jalr_out | typeDecoder_module.io.lui_out | typeDecoder_module.io.load_out 

    regfile_module.io.regWrite := regWrite
    regfile_module.io.rs1 := isntdecoder_module.io.rs1
    regfile_module.io.rs2 := isntdecoder_module.io.rs2
    regfile_module.io.rd := isntdecoder_module.io.rd
    regfile_module.io.writeData := MuxLookup(typeDecoder_module.io.load_out,0.U,Array(
        (0.U) -> alu_module.io.aluout,
        (1.U) -> datamemory_module.io.memout.asUInt  
    ) )
    //Execute
    alucontrol_module.io.aluop := aluopgen_module.io.aluop
    alucontrol_module.io.opcode := isntdecoder_module.io.opcode
    alucontrol_module.io.func7 := isntdecoder_module.io.func7
    alucontrol_module.io.func3 := isntdecoder_module.io.func3

    alu_module.io.op1 := regfile_module.io.writeregester1
    alu_module.io.op2 := MuxLookup (typeDecoder_module.io.i_out, 0.S, Array(
        (0.U) -> regfile_module.io.writeregester2,
        (1.U) -> immgen_module.io.immd_se))
    alu_module.io.aluctrl := alucontrol_module.io.aluctrl
    //Writeback
    val c = immgen_module.io.immd_se + regfile_module.io.writeregester1
    val d = c(23,0)
    val e = typeDecoder_module.io.load_out | typeDecoder_module.io.store_out
    val address = MuxLookup(e, 0.U, Seq(
    (0.U) -> 0.U,
    (1.U) -> d
    ))

    datamemory_module.io.memdata := regfile_module.io.writeregester2.asSInt
    datamemory_module.io.memaddress := address
    datamemory_module.io.memread := regWrite
    datamemory_module.io.memwrite := typeDecoder_module.io.store_out

    io.Output1 := alu_module.io.aluout
    io.datamemOut := datamemory_module.io.memout
    io.Address := address
    io.write := regWrite
}