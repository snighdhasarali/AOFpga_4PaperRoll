# Advent of Code 2025 – Day 4  
## Printing Department (Verilog Hardware Implementation)

<p align="center">
  Hardware implementation of <b>Advent of Code 2025 - Day 4: Printing Department</b><br>
  built using <b>Verilog</b> with both a golden reference model and a streaming FPGA-style architecture.
</p>

---

# 🚀 Interactive Visualization

🌐 Live Demo & Explanation:  
https://snighdhasarali.github.io/AOFpga_4PaperRoll/

---

# 📖 Original Problem

Full Advent of Code problem statement:  
https://adventofcode.com/2025/day/4

---

# 🧩 Problem Summary (Simple Explanation)

The puzzle gives a large grid representing rolls of paper inside a printing department.

- `@` → Paper roll present
- `.` → Empty space

A forklift can only access a paper roll if it is **not surrounded by too many neighboring rolls**.

For every paper roll, we check the **8 surrounding positions**:

- top
- bottom
- left
- right
- 4 diagonal neighbors

If there are **fewer than 4 neighboring paper rolls**, then that roll is considered **accessible**.

The goal is to:

> Count how many paper rolls are accessible by the forklift.

---

# 📝 Example

Input Grid:

```text
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
```

Accessible paper rolls are marked with `x`:

```text
..xx.xx@x.
x@@.@.@.@@
@@@@@.x.@@
@.@@@@..@.
x@.@@@@.@x
.@@@@@@@.@
.@.@.@.@@@
x.@@@.@@@@
.@@@@@@@@.
x.x.@@@.x.
```

Final accessible count:

```text
13
```

---

# ⚙️ Implementations

## 1️⃣ Golden Reference Model

A straightforward brute-force implementation.

For every paper roll:

- Check all 8 neighboring cells
- Count neighboring paper rolls
- If neighbor count `< 4`
  - mark it accessible

This model is mainly used for:

- verification
- debugging
- correctness checking

---

## 2️⃣ Streaming Hardware Architecture

An optimized FPGA-style streaming design.

Instead of processing the full grid at once:

- cells are streamed one-by-one
- only 3 rows are buffered
- neighbor counts are computed in real time

This mimics efficient hardware image-processing pipelines commonly used in FPGA systems.

---

# 💡 Hardware Insight

The design treats the grid like a streaming image:

- one cell processed per clock cycle
- nearby cells stored temporarily
- accessibility calculated instantly

This reduces:

- memory usage
- latency
- hardware complexity

while improving scalability for larger grids.

---

# 🛠️ Technologies Used

- Verilog HDL
- FPGA Streaming Architecture
- Sliding Window Neighbor Computation

---

# 📂 Files

| File | Description |
|------|-------------|
| `forklift_golden.v` | Brute-force golden reference model |
| `forklift_streaming.v` | Streaming FPGA-style implementation |
| `README.md` | Project documentation |

---

# 🎯 Key Concepts

- 2D Neighbor Checking
- Sliding Window Computation
- Streaming Data Processing
- FPGA-Oriented Design
- Real-Time Grid Analysis

---

# 📸 Visualization

The interactive webpage demonstrates:

- neighbor checking
- streaming architecture
- accessibility decisions
- real-time grid processing

🔗 https://snighdhasarali.github.io/AOFpga_4PaperRoll/

---

# 📜 License

This project is part of personal FPGA and hardware architecture exploration using Advent of Code style problems.
