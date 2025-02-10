package SingleCycle
import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest._
/*
class Alutest extends FreeSpec with ChiselScalatestTester{
    "ALU TEST" in {

    test(new Alu) { c =>
    c.io.alu_oper.poke ( "b0000".U )
    c.io.arg_x.poke ( 1.U )
    c.io.arg_y.poke ( 0.U )
    c.clock.step (1)
    c.io.alu_out.expect( 1.U )
    }}
}*/