<p align="center">
  <img src="https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge&logo=v&logoColor=white" alt="Verilog"/>
  <img src="https://img.shields.io/badge/Tool-ModelSim-orange?style=for-the-badge" alt="ModelSim"/>
  <img src="https://img.shields.io/badge/Category-VLSI%20Design-green?style=for-the-badge" alt="VLSI"/>
  <img src="https://img.shields.io/badge/Simulation-Icarus%20Verilog-purple?style=for-the-badge" alt="Icarus"/>
</p>

# ⚡ 4-Bit Arithmetic Logic Unit (ALU) — Verilog HDL

> A fully functional, synthesizable 4-bit ALU designed in Verilog HDL with comprehensive testbench and self-checking verification.

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Supported Operations](#-supported-operations)
- [Status Flags](#-status-flags)
- [File Structure](#-file-structure)
- [Simulation Guide](#-simulation-guide)
- [Waveform Analysis](#-waveform-analysis)
- [Applications](#-applications)
- [Author](#-author)

---

## 🔍 Overview

The **4-bit ALU** is the fundamental computational building block in any digital processor. This project implements a combinational ALU that supports **8 distinct operations** including arithmetic, logical, and shift operations, along with status flags for carry, zero, and overflow detection.

### Key Highlights
- 🎯 **8 Operations** — ADD, SUB, AND, OR, XOR, NOT, SHL, SHR
- 🚩 **3 Status Flags** — Carry Out, Zero, and Overflow detection
- ✅ **Self-Checking Testbench** — Automated PASS/FAIL verification
- 📊 **VCD Waveform** — Full waveform dump for visual verification
- 🔧 **Fully Synthesizable** — Ready for FPGA implementation

---

## 🏗️ Architecture

```
                    ┌──────────────────────────────┐
                    │         4-BIT ALU             │
     A [3:0] ──────┤►                              │
                    │     ┌──────────────┐          ├────── Result [3:0]
     B [3:0] ──────┤►    │  Operation   │          │
                    │     │  Decoder     │          ├────── Carry Out
  Opcode [2:0] ────┤►    │  (3-to-8)    │          │
                    │     └──────────────┘          ├────── Zero Flag
                    │                              │
                    │  ┌─────┐ ┌─────┐ ┌─────┐    ├────── Overflow
                    │  │ ADD │ │ AND │ │ SHL │    │
                    │  │ SUB │ │ OR  │ │ SHR │    │
                    │  │     │ │ XOR │ │     │    │
                    │  │     │ │ NOT │ │     │    │
                    │  └─────┘ └─────┘ └─────┘    │
                    └──────────────────────────────┘
```

---

## ⚙️ Supported Operations

| Opcode | Operation | Description | Formula |
|:------:|:---------:|:------------|:--------|
| `000` | **ADD** | Unsigned Addition | `Result = A + B` |
| `001` | **SUB** | Unsigned Subtraction | `Result = A - B` |
| `010` | **AND** | Bitwise AND | `Result = A & B` |
| `011` | **OR** | Bitwise OR | `Result = A \| B` |
| `100` | **XOR** | Bitwise XOR | `Result = A ^ B` |
| `101` | **NOT** | Bitwise Complement | `Result = ~A` |
| `110` | **SHL** | Logical Shift Left | `Result = A << 1` |
| `111` | **SHR** | Logical Shift Right | `Result = A >> 1` |

---

## 🚩 Status Flags

| Flag | Description |
|:----:|:------------|
| **Carry Out** | Set when arithmetic operation produces a carry/borrow beyond 4 bits |
| **Zero Flag** | Asserted (`1`) when the result is `0000` |
| **Overflow** | Set on signed arithmetic overflow (ADD/SUB) |

---

## 📁 File Structure

```
VLSI-4Bit-ALU-Verilog/
├── src/
│   └── alu_4bit.v          # ALU RTL design module
├── testbench/
│   └── alu_tb.v            # Self-checking testbench
├── docs/
│   └── (waveform screenshots)
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🚀 Simulation Guide

### Using Icarus Verilog (Free & Open Source)

```bash
# Compile
iverilog -o alu_sim src/alu_4bit.v testbench/alu_tb.v

# Run simulation
vvp alu_sim

# View waveforms (optional)
gtkwave alu_tb.vcd
```

### Using ModelSim / QuestaSim

```bash
# Create work library
vlib work

# Compile source files
vlog src/alu_4bit.v testbench/alu_tb.v

# Run simulation
vsim -run -all alu_tb
```

### Expected Output

```
============================================================
       4-BIT ALU TESTBENCH - Daggolu Hari Krishna
============================================================

--- Testing ADD Operation ---
[PASS] Test 1: ADD        | A=0011, B=0001 => Result=0100, Carry=0
[PASS] Test 2: ADD        | A=1111, B=0001 => Result=0000, Carry=1
...
============================================================
  TEST SUMMARY: 21 PASSED, 0 FAILED out of 21 tests
============================================================
  >>> ALL TESTS PASSED! <<<
```

---

## 📊 Waveform Analysis

After simulation, open `alu_tb.vcd` in GTKWave to visualize:
- Input operands (A, B) transitioning through test vectors
- Opcode switching between all 8 operations
- Result output and flag assertions
- Timing relationships between inputs and outputs

---

## 💡 Applications

- 🖥️ **CPU Design** — Core computational unit in processor datapaths
- 🔬 **FPGA Prototyping** — Deployable on Xilinx/Intel FPGA boards
- 📚 **Academic Learning** — Fundamental digital design concept
- 🏭 **ASIC Design** — Building block for complex SoC designs

---

## 👨‍💻 Author

**Daggolu Hari Krishna**
B.Tech ECE | JNTUA College of Engineering, Kalikiri

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat-square&logo=linkedin)](https://linkedin.com/in/harikrishnadaggolu)
[![Email](https://img.shields.io/badge/Email-Contact-red?style=flat-square&logo=gmail)](mailto:haridaggolu@gmail.com)

---

<p align="center">
  ⭐ If you found this project helpful, please give it a star! ⭐
</p>
