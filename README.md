# Advent of Code 2025 – Day 4: Printing Department  
## Hardware / RTL-Based Solution (Verilog)

---

## 1. Introduction

This repository contains a **hardware-oriented solution** to **Advent of Code 2025 – Day 4: Printing Department**.

The original problem is presented as a grid-processing puzzle, but this submission intentionally approaches it from a **digital hardware and FPGA design perspective**, focusing on:

- Correctness
- Hardware realism
- Parallelism
- Scalability
- Clear architectural reasoning

Rather than only computing the final answer in software, this submission demonstrates **how the problem maps naturally to RTL hardware**, using Verilog, simulation, and waveform inspection.

---

## 2. Problem Description (Restated Clearly)

We are given a 2D grid consisting of:

- `@` → paper roll  
- `.` → empty space  

A paper roll is considered **accessible** if:

1. The cell itself contains `@`
2. Among its **eight neighboring cells** (horizontal, vertical, and diagonal),
   **fewer than four** also contain `@`

The task is to **count how many paper rolls are accessible**.

For the example grid given in the problem statement, the correct answer is:


---

## 3. Hardware Design Philosophy

In real hardware development, it is standard practice to separate a design into two phases:

1. **Correctness validation**  
2. **Performance / architecture optimization**

This submission follows that exact methodology.

### Why this matters

Jumping directly into a complex streaming or pipelined design without first proving correctness often leads to subtle bugs that are difficult to debug. Hardware engineers therefore rely on a **golden reference model** to validate logic before optimization.

This project contains **two complementary implementations**:

| Implementation | Purpose |
|---------------|--------|
| Golden reference RTL | Proves correctness |
| Streaming RTL | Demonstrates hardware architecture |

Both solve the **same problem**, but serve **different goals**.

---

## 4. Part 1 – Golden Reference Model (Correctness Proof)

### 4.1 What the golden reference is

The golden reference is a **simple, unoptimized RTL model** that:

- Stores the entire grid in registers
- Iterates over every cell
- Explicitly checks all eight neighbors
- Counts accessible paper rolls

This model resembles a software solution, but is still written in Verilog so it can be simulated with standard RTL tools.

### 4.2 Why the golden reference exists

The golden reference provides:

- Absolute confidence in correctness
- A known-good expected result (`13`)
- A baseline against which optimized designs can be compared

In professional hardware development, this is standard practice and is often referred to as a **golden model**.

---

### 4.3 How to run the golden reference

Navigate to the submission root directory and run:

```bash
iverilog reference/forklift_golden.v -o ref.out
vvp ref.out
Part 2 – Streaming RTL Architecture (Hardware-Oriented Design)
5.1 Motivation for a streaming design

While the golden reference is correct, it is not how real hardware would implement this problem.

In hardware systems such as FPGAs or ASICs:

Random access to large memories is expensive

Parallel computation is cheap

Streaming data is preferred

This problem is a textbook example of a 2D stencil computation, which maps very well to a sliding window architecture.

5.2 High-level streaming architecture

The streaming design processes the grid one cell per clock cycle using:

Three line buffers (previous rows)

A 3×3 sliding window

Parallel neighbor evaluation

A simple threshold comparison

Once the pipeline is filled, the design achieves constant throughput.

5.3 Key hardware concepts demonstrated
5.3.1 Line buffers

Only three rows of the grid are stored at any time:

Current row

Previous row

Row before that

This means memory usage scales with grid width, not total grid size.

5.3.2 Sliding 3×3 window

As each new cell enters the pipeline, the surrounding 3×3 neighborhood becomes available automatically from the line buffers.

No nested loops or random memory accesses are required.

5.3.3 Parallel neighbor counting

All eight neighbors are summed in parallel using combinational logic.

This is a key advantage of hardware over software:
what takes multiple instructions on a CPU happens in a single cycle in hardware.

5.3.4 One-cell-per-cycle throughput

After initial pipeline fill:

One grid cell is evaluated every clock cycle

Latency is constant

Throughput does not depend on grid size

6. Streaming RTL Files

The streaming implementation consists of:

streaming/forklift_streaming.v
The RTL module implementing the streaming architecture

streaming/tb_streaming.v
A testbench that feeds the example grid and generates waveforms

7. Running the Streaming Simulation

From the submission root directory, run:

iverilog -g2012 streaming/forklift_streaming.v streaming/tb_streaming.v -o stream.out
vvp stream.out


This generates a waveform file:

waves/streaming.vcd

8. Waveform Visualization (GTKWave)

To inspect the hardware behavior visually, open GTKWave:

gtkwave waves/streaming.vcd

8.1 Important signals to inspect

Add the following signals in GTKWave:

cell_in – input data stream

center – center cell of the 3×3 window

nsum – number of neighboring paper rolls

accessible – accessibility decision signal

row, col – grid position counters

8.2 What the waveform proves

The waveform clearly demonstrates:

The 3×3 sliding window moving across the grid

Neighbor counts computed in parallel

Accessibility decisions occurring only when:

The center cell is @

Fewer than four neighbors are present

A screenshot of this waveform is included as:

waves/streaming_wave.png


This serves as visual proof of correct hardware operation.

9. Scalability Discussion
Design	Memory Complexity
Golden reference	O(W × H)
Streaming RTL	O(W)

Because the streaming design only stores line buffers, it scales naturally to:

10× larger grids

100× larger grids

1000× larger grids (with BRAM on FPGA)

Throughput remains one cell per cycle regardless of grid size.

10. Tools Used

Icarus Verilog – RTL simulation

GTKWave – waveform visualization

Ubuntu Linux – development environment

All tools are open-source and commonly used in industry and academia.

11. Summary

This submission demonstrates:

Correct problem understanding

A disciplined hardware design workflow

Separation of correctness and optimization

A realistic FPGA-style streaming architecture

Effective use of parallelism and pipelining

The combination of a golden reference model and a streaming RTL implementation reflects real-world hardware engineering practice and aligns well with the goals of the Advent of FPGA challenge.
