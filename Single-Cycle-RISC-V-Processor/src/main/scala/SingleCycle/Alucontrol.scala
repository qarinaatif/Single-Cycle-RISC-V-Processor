package SingleCycle
import chisel3._
import chisel3.util._

class Alucontrol extends Module {
    val io = IO(new Bundle{
        val aluop = Input(UInt(3.W))
        val func7 = Input(UInt(3.W))
        val func3 = Input(UInt(3.W))
        val opcode = Input(UInt(6.W))
        val Output = Output(UInt(32.W))
    })

    io.Output := 0.U

    switch(io.aluop) {
        is("b000".U) {
            io.Output := "b100000".U }
        is("b001".U) {
            io.Output := "b100010".U }
        is("b010".U) {
            io.Output := "b100100".U }
        is("b011".U) {
            io.Output := "b100101".U }
        is("b100".U) {
            io.Output := "b100110".U }
        is("b101".U) {
            io.Output := "b100111".U }
        is("b110".U) {
            when(io.func3 === "b000".U) { io.Output := "b100000".U } 
            .elsewhen(io.func3 === "b001".U) { io.Output := "b100010".U }
            .elsewhen(io.func3 === "b010".U) { io.Output := "b100100".U } 
            .elsewhen(io.func3 === "b011".U) { io.Output := "b100101".U } 
            .elsewhen(io.func3 === "b100".U) { io.Output := "b100110".U } 
            .elsewhen(io.func3 === "b101".U) { io.Output := "b100111".U }
            .elsewhen(io.func3 === "b110".U) { io.Output := "b101010".U }
            .elsewhen(io.func3 === "b111".U) { io.Output := "b101011".U }
        }
        is("b111".U) {
            when(io.func7 === "b000".U) { io.Output := "b100000".U } 
            .elsewhen(io.func7 === "b010".U) { io.Output := "b100100".U } 
            .elsewhen(io.func7 === "b100".U) { io.Output := "b100110".U } 
            .elsewhen(io.func7 === "b110".U) { io.Output := "b101010".U } 
            .otherwise { io.Output := "b100010".U }
        }
    }
}
