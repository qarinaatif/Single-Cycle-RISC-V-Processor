package SingleCycle
import chisel3._
import chisel3.util._

class Core(initFile: String = "src/test/scala/SingleCycle/instructionmemory.txt") extends Module{
    val io = IO(new Bundle{
        val PC = Output(UInt(32.W))
        val Instruction = Output(UInt(32.W))
        val Datamemoryout = Output(SInt(32.W))
        val Address = Output(UInt(24.W))
        val WriteData = Output(UInt(32.W))
    })
    val pc_module = Module(new Programcounter(32))
    val insmemory_module = Module(new InstructionMemory(initFile))
    val isntdecoder_module = Module(new InstructionDecoder)
    val typeDecoder_module = Module(new TypeDecoder)
    val immgen_module = Module(new ImmediateGen)
    val regfile_module = Module(new RegisterFile(32))
    val controldecoder_module = Module(new ControlDecoder)
    val alucontrol_module = Module(new Alucontrol)
    val alu_module = Module(new Alu)
    val Branch_module = Module(new Branch(32))
    val datamemory_module = Module(new Datamemory)
    val jalr_module = Module(new jalr(32))

    val pc_uint = pc_module.io.out.asUInt

    // Instruction Memory Fetch
    insmemory_module.io.readadress := pc_uint(25, 2)

    // Decode
    isntdecoder_module.io.instruction := insmemory_module.io.readdata
    immgen_module.io.instruction := insmemory_module.io.readdata
    immgen_module.io.pc := pc_uint
    typeDecoder_module.io.opcode := isntdecoder_module.io.opcode 
    controldecoder_module.io.opcode := isntdecoder_module.io.opcode 

    // Register File Inputs
    regfile_module.io.regWrite := controldecoder_module.io.RegWrite
    regfile_module.io.rs1 := isntdecoder_module.io.rs1
    regfile_module.io.rs2 := isntdecoder_module.io.rs2
    regfile_module.io.rd := isntdecoder_module.io.rd

    // Branch & Jump
    Branch_module.io.arg_x := regfile_module.io.readData1.asSInt
    Branch_module.io.arg_y := regfile_module.io.readData2.asSInt
    Branch_module.io.func3 := isntdecoder_module.io.func3
    Branch_module.io.branch := controldecoder_module.io.Branch

    jalr_module.io.rs1 := regfile_module.io.readData1.asSInt
    jalr_module.io.imme := immgen_module.io.imm_out

    val is_jal = typeDecoder_module.io.jal_out.asBool
    val is_jalr = typeDecoder_module.io.jalr_out.asBool
    val is_branch = controldecoder_module.io.Branch && Branch_module.io.br_taken

    val next_pc = Mux(is_jalr,
        jalr_module.io.out,
        Mux(is_jal || is_branch,
            immgen_module.io.imm_out,
            pc_module.io.pc4
        )
    )
    pc_module.io.in := next_pc

    // ALU Execution
    alucontrol_module.io.Aluop := controldecoder_module.io.Aluop
    alucontrol_module.io.func7 := isntdecoder_module.io.func7
    alucontrol_module.io.func3 := isntdecoder_module.io.func3

    val use_imm = typeDecoder_module.io.i_out.asBool ||
                  typeDecoder_module.io.load_out.asBool ||
                  typeDecoder_module.io.store_out.asBool ||
                  typeDecoder_module.io.jalr_out.asBool

    alu_module.io.op1 := regfile_module.io.readData1
    alu_module.io.op2 := Mux(use_imm, immgen_module.io.imm_out.asUInt, regfile_module.io.readData2)
    alu_module.io.aluctrl := alucontrol_module.io.aluctrl

    // Data Memory
    datamemory_module.io.Alures := alu_module.io.aluout
    datamemory_module.io.WriteData := regfile_module.io.readData2
    datamemory_module.io.WriteEnable := controldecoder_module.io.MemWrite
    datamemory_module.io.ReadEnable := controldecoder_module.io.MemRead
    datamemory_module.io.func3 := isntdecoder_module.io.func3
    datamemory_module.io.memaddress := alu_module.io.aluout(23,0)

    // Register File Write Data (Writeback)
    val is_jump = is_jal || is_jalr
    val is_lui_or_auipc = (isntdecoder_module.io.opcode === "b0110111".U) || (isntdecoder_module.io.opcode === "b0010111".U)

    regfile_module.io.writeData := Mux(
        typeDecoder_module.io.load_out.asBool,
        datamemory_module.io.memout,
        Mux(is_jump,
            pc_module.io.pc4.asUInt,
            Mux(is_lui_or_auipc,
                immgen_module.io.imm_out.asUInt,
                alu_module.io.aluout
            )
        )
    )

    // Outputs
    io.PC := pc_uint
    io.Instruction := insmemory_module.io.readdata
    io.Datamemoryout := datamemory_module.io.memout.asSInt
    io.Address := alu_module.io.aluout(23,0)
    io.WriteData := regfile_module.io.readData2
}
