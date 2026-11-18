# Single-Cycle RISC-V (RV32I) Processor

A 32-bit single-cycle RISC-V processor core implementing the complete unprivileged **RV32I** Base Integer Instruction Set, written in [Chisel3](https://www.chisel-lang.org/) (Constructing Hardware in a Scala Embedded Language) and verified using [chiseltest](https://github.com/ucb-bar/chisel-testers2).

---

### Key Stages

1. **Instruction Fetch (IF)**:
   * The [`Programcounter`](src/main/scala/SingleCycle/Programcounter.scala) maintains the current program counter (PC) and computes `PC + 4`.
   * Combinational [`InstructionMemory`](src/main/scala/SingleCycle/InstructionMemory.scala) loads the 32-bit instruction at `PC[25:2]`.
   * The next PC is resolved every cycle based on whether a branch is taken, a jump (`JAL`/`JALR`) occurs, or sequential execution proceeds (`PC + 4`).

2. **Instruction Decode (ID) & Register Read**:
   * [`InstructionDecoder`](src/main/scala/SingleCycle/InstructionDecoder.scala) unpacks fields (`opcode`, `rd`, `rs1`, `rs2`, `func3`, `func7`).
   * [`TypeDecoder`](src/main/scala/SingleCycle/TypeDecoder.scala) and [`ControlDecoder`](src/main/scala/SingleCycle/ControlDecoder.scala) generate datapath controls.
   * [`ImmediateGen`](src/main/scala/SingleCycle/ImmediateGen.scala) decodes and sign-extends I-, S-, B-, U-, and J-type immediate offsets.
   * [`RegisterFile`](src/main/scala/SingleCycle/RegisterFile.scala) contains 32 registers (`x0`–`x31`), with `x0` hardwired to zero.

3. **Execute (EX)**:
   * [`Alucontrol`](src/main/scala/SingleCycle/Alucontrol.scala) translates control signals, `func3`, and `func7` into ALU control codes.
   * [`Alu`](src/main/scala/SingleCycle/Alu.scala) executes arithmetic, bitwise logic, signed/unsigned set-less-than comparisons (`SLT`/`SLTU`), and logical/arithmetic shifts (`SLL`/`SRL`/`SRA`).
   * [`Branch`](src/main/scala/SingleCycle/Branch.scala) compares operands for equality and signed/unsigned magnitude.
   * [`jalr`](src/main/scala/SingleCycle/jalr.scala) computes indirect jump targets with the lowest bit cleared: `(rs1 + imm) & ~1`.

4. **Memory (MEM)**:
   * [`Datamemory`](src/main/scala/SingleCycle/Datamemory.scala) provides 8192 words (32 KB) of byte-addressable memory.
   * Supports byte-masked stores (`SB`, `SH`, `SW`) and signed/unsigned loads (`LB`, `LH`, `LW`, `LBU`, `LHU`).

5. **Writeback (WB)**:
   * Multiplexes the destination register (`rd`) data among:
     * **Memory read data** (for loads)
     * **`PC + 4`** (for `JAL` and `JALR`)
     * **Upper immediates** (for `LUI` and `AUIPC`)
     * **ALU result** (for standard R-type and I-type arithmetic/logic)

---

## Supported Instruction Set (RV32I)

The processor supports all 37 base integer instructions:

| Type | Instruction | Opcode | Description |
|:-----|:------------|:-------|:------------|
| **R-Type** | `ADD`, `SUB` | `0110011` | Integer addition and subtraction |
| | `SLL`, `SRL`, `SRA` | `0110011` | Logical left, logical right, and arithmetic right shifts |
| | `SLT`, `SLTU` | `0110011` | Signed and unsigned set less than |
| | `XOR`, `OR`, `AND` | `0110011` | Bitwise logical XOR, OR, AND |
| **I-Type (ALU)** | `ADDI` | `0010011` | Add immediate |
| | `SLTI`, `SLTIU` | `0010011` | Set less than immediate (signed / unsigned) |
| | `XORI`, `ORI`, `ANDI` | `0010011` | Bitwise XOR, OR, AND immediate |
| | `SLLI`, `SRLI`, `SRAI` | `0010011` | Shift immediate (left logical, right logical, right arithmetic) |
| **I-Type (Load)** | `LB`, `LBU` | `0000011` | Load byte (sign-extended / zero-extended) |
| | `LH`, `LHU` | `0000011` | Load halfword (sign-extended / zero-extended) |
| | `LW` | `0000011` | Load word (32-bit) |
| **S-Type (Store)** | `SB`, `SH`, `SW` | `0100011` | Store byte, halfword, and word |
| **B-Type (Branch)** | `BEQ`, `BNE` | `1100011` | Branch on equal / not equal |
| | `BLT`, `BGE` | `1100011` | Branch on less than / greater or equal (signed) |
| | `BLTU`, `BGEU` | `1100011` | Branch on less than / greater or equal (unsigned) |
| **U-Type** | `LUI` | `0110111` | Load upper immediate (`imm << 12`) |
| | `AUIPC` | `0010111` | Add upper immediate to PC (`PC + (imm << 12)`) |
| **J-Type / Jump** | `JAL` | `1101111` | Jump and link (`PC + imm`, saves `PC + 4` to `rd`) |
| | `JALR` | `1100111` | Jump and link register (`(rs1 + imm) & ~1`, saves `PC + 4`) |

---

## Project Structure

```
├── build.sbt                                 # SBT project configuration and dependencies
├── project/                                  # SBT build plugins and properties
├── src/
│   ├── main/scala/SingleCycle/
│   │   ├── Core.scala                        # Top-level single-cycle datapath integration
│   │   ├── Programcounter.scala              # PC register and PC+4 generator
│   │   ├── InstructionMemory.scala           # Combinational instruction memory
│   │   ├── InstructionDecoder.scala          # Bit-field extractor
│   │   ├── TypeDecoder.scala                 # Instruction type identifier
│   │   ├── ImmediateGen.scala                # Immediate generator for all formats
│   │   ├── RegisterFile.scala                # 32x32-bit register file (x0 = 0)
│   │   ├── ControlDecoder.scala              # Main control unit
│   │   ├── Alucontrol.scala                  # ALU operation controller
│   │   ├── Alu.scala                         # 32-bit Arithmetic Logic Unit
│   │   ├── Branch.scala                      # Branch condition evaluation unit
│   │   ├── Datamemory.scala                  # Byte-addressable data memory with mask
│   │   └── jalr.scala                        # JALR target address calculation
│   └── test/scala/SingleCycle/
│       ├── SingleCycletest.scala             # Top-level Core execution test
│       ├── Alutest.scala                     # ALU verification
│       ├── Alucontroltest.scala              # ALU control verification
│       ├── Datamemorytest.scala              # Data memory read/write verification
│       ├── InstructionDecodertest.scala      # Instruction field decoding tests
│       ├── InstructionMemorytest.scala       # Instruction memory loading tests
│       ├── Programcountertest.scala          # PC increment and latch tests
│       ├── RegisterFiletest.scala            # Register read/write/x0 tests
│       ├── TypeDecodertest.scala             # Opcode classification tests
│       └── instructionmemory.txt             # Program binary loaded into memory (hex)
```

---

## Getting Started

### Prerequisites

Ensure you have the following installed on your machine:
* **Java Development Kit (JDK)**: Version 11 or newer (OpenJDK recommended)
* **SBT**: Version 1.4 or newer

Install on Ubuntu / Debian:
```bash
sudo apt-get update
sudo apt-get install openjdk-11-jdk sbt verilator
```

### Running Tests

To run the complete test suite across all modules:
```bash
sbt test
```

To run a specific test suite:
```bash
# Test the full Core
sbt "testOnly SingleCycle.SingleCycletest"

# Test individual modules
sbt "testOnly SingleCycle.Alutest"
sbt "testOnly SingleCycle.Datamemorytest"
sbt "testOnly SingleCycle.RegisterFiletest"
```

---

## Running Custom Assembly / Machine Code

1. Write your RISC-V assembly program and assemble it into 32-bit hex words (big-endian text format, one instruction per line).
2. Place the hex file in `src/test/scala/SingleCycle/instructionmemory.txt`, or pass your file path to `Core`:
   ```scala
   val core = Module(new Core("path/to/your_program.txt"))
   ```
3. Run the simulator using `SingleCycletest.scala` to step through clock cycles and inspect internal signals.

---
