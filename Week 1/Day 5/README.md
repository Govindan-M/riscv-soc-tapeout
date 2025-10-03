# Day 5 - Optimisation in Synthesis

This repository demonstrates **optimisation in synthesis** with a focus on **inferred latches**, caused by bad coding styles using `if` and `case` statements. It includes examples of both **combinational logic** and **sequential logic**, illustrating the right and wrong ways to code in Verilog.
## Key Learning Points

- **Inferred Latches**:
    - Caused when combinational logic does not assign outputs in *all paths*.
    - Tools will warn: *latch inferred for signal...*.
    - In sequential circuits, missing enable causes latch-like behaviour (previous value held).
- **Bad coding style**:
    - `if (cond) begin ... end` without an `else` → latch.
    - `case` without full branch coverage or missing `default` → latch.
    - Partial assignments in some `case` branches.
- **Good coding style**:
    - Always provide `else` or default assignments.
    - In sequential logic, explicitly code enable/reset behaviour.
    - Cover *all* outputs in every branch.

## If vs Case Statements (Comparison)

| Feature | If Statement | Case Statement |
| --- | --- | --- |
| Priority | High (top branch wins) | No priority care, parallel checks |
| Execution | Only one branch executes | Mutually exclusive branches |
| Coverage | Needs else for all cases | Needs default or full coverage |
| Risk | Incomplete if → unpredictable latch | Incomplete case → inferred latch |
| Overlap | Not allowed (priority resolves) | Should avoid overlapping cases |

## Caveats

- **Incomplete case** → latch.
- **Partial assignment** in case → latch.
- Always assign *all outputs* in *all segments*.
- If using case, always include `default`.

---

## Checklist (Combinational Logic)

1. Use `always @(*)` or `always_comb`.
2. For `if`, add `else` (or default assignment).
3. For `case`, add `default` or cover all cases.
4. Assign *all outputs* in *all paths*.
5. For sequential logic, include enable/reset explicitly.

## Lab 1: Incomplete Caveats with `if` & `case`

This lab shows the **synthesis and simulation flow** for incomplete `if` and `case` statements that cause inferred latches.

Example 1: `incomp_if.v`

### Steps

1. Open the files using gvim split view:
    
    ```bash
    cd verilog_files
    gvim *incomp* -o
    ```
    
2. Run simulation with **iverilog** and testbench:
    
    ```bash
    iverilog incomp_if.v tb_incomp_if.v
    ./a.out
    ```
    
3. View waveform with **GTKWave**:
    
    ```bash
    gtkwave tb_incomp_if.vcd
    ```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/incomp_if-01.png" width="600"/>
    
4. Open **yosys** for synthesis:
    
    ```bash
    yosys
    ```
    
5. Inside yosys, read design file:
    
    ```bash
    read_verilog incomp_if.v
    ```
    
6. Load standard cell library:
    
    ```bash
    read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    ```
    
7. Run synthesis:
    
    ```bash
    synth -top incomp_if
    ```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/incomp_if-02.png" width="600"/>

8. Run ABC technology mapping:
    
    ```bash
    abc -liberty ./my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    ```
    
9. Visualize synthesized circuit:
    
    ```bash
    show
    ```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/incomp_if-03.png" width="600"/>

Example 2: `incomp_if2.v` 

### Steps

1. Open the files using gvim split view:
    
    ```bash
    cd verilog_files
    gvim *incomp_if2* -o
    ```
    
2. Run simulation with **iverilog** and testbench:
    
    ```bash
    iverilog incomp_if2.v tb_incomp_if2.v
    ./a.out
    ```
    
3. View waveform with **GTKWave**:
    
    ```bash
    gtkwave tb_incomp_if2.vcd
    ```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/incomp_if2-01.png" width="600"/>
    
4. Open **yosys** for synthesis:
    
    ```bash
    yosys
    ```
    
5. Inside yosys, read design file:
    
    ```
    read_verilog incomp_if2.v
    ```
    
6. Load standard cell library:
    
    ```
    read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    ```
    
7. Run synthesis:
    
    ```
    synth -top incomp_if2
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/incomp_if2-02.png" width="600"/>
    
8. Run ABC technology mapping:
    
    ```
    abc -liberty ./my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/incomp_if2-03.png" width="600"/>
    
9. Visualize synthesized circuit:
    
    ```
    show
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/incomp_if2-04.png" width="600"/>
    

## Example 3: `incomp_case.v`

### Steps

1. Open the files using gvim split view:
    
    ```bash
    cd verilog_files
    gvim *incomp_case* -o
    ```
    
2. Run simulation with **iverilog** and testbench:
    
    ```bash
    iverilog incomp_case.v tb_incomp_case.v
    ./a.out
    ```
    
3. View waveform with **GTKWave**:
    
    ```bash
    gtkwave tb_incomp_case.vcd
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/incomp_case-01.png" width="600"/>
    
4. Open **yosys** for synthesis:
    
    ```bash
    yosys
    ```
    
5. Inside yosys, read design file:
    
    ```
    read_verilog incomp_case.v
    ```
    
6. Load standard cell library:
    
    ```
    read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    ```
    
7. Run synthesis:
    
    ```
    synth -top incomp_case
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/incomp_case-02.png" width="600"/>
    
8. Run ABC technology mapping:
    
    ```
    abc -liberty ./my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/incomp_case-03.png" width="600"/>
    
9. Visualize synthesized circuit:
    
    ```
    show
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/incomp_case-04.png" width="600"/>
    

## Example 4: `comp_case.v`

### Steps

1. Open the files using gvim split view:
    
    ```bash
    cd verilog_files
    gvim *comp* -o
    ```
    
2. Run simulation with **iverilog** and testbench:
    
    ```bash
    iverilog comp_case.v tb_comp_case.v
    ./a.out
    ```
    
3. View waveform with **GTKWave**:
    
    ```bash
    gtkwave tb_comp_case.vcd
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/comp_case-01.png" width="600"/>
    
4. Open **yosys** for synthesis:
    
    ```bash
    yosys
    ```
    
5. Inside yosys, read design file:
    
    ```
    read_verilog comp_case.v
    ```
    
6. Load standard cell library:
    
    ```
    read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    ```
    
7. Run synthesis:
    
    ```
    synth -top comp_case
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/comp_case-02.png" width="600"/>
    
8. Run ABC technology mapping:
    
    ```
    abc -liberty ./my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/comp_case-03.png" width="600"/>
    
9. Visualize synthesized circuit:
    
    ```
    show
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/comp_case-04.png" width="600"/>
    

## Example 5: `bad_case.v`

### Steps

1. Open the files using gvim split view:
    
    ```bash
    cd verilog_files
    gvim *bad_case* -o
    ```
    
2. Run simulation with **iverilog** and testbench:
    
    ```bash
    iverilog bad_case.v tb_bad_case.v
    ./a.out
    ```
    
3. View waveform with **GTKWave**:
    
    ```bash
    gtkwave tb_bad_case.vcd
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/bad_case-01.png" width="600"/>
    
4. Open **yosys** for synthesis:
    
    ```bash
    yosys
    ```
    
5. Inside yosys, read design file:
    
    ```
    read_verilog bad_case.v
    ```
    
6. Load standard cell library:
    
    ```
    read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    ```
    
7. Run synthesis:
    
    ```
    synth -top bad_case
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/bad_case-02.png" width="600"/>
    
8. Run ABC technology mapping:
    
    ```
    abc -liberty ./my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/bad_case-03.png" width="600"/>
    
9. Visualize synthesized circuit:
    
    ```
    show
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/bad_case-04.png" width="600"/>
    
10. Write synthesized netlist to Verilog:
    
    ```
    write_verilog -noattr bad_case_net.v
    ```
    
11. Compile synthesized netlist with primitives and standard cell models:
    
    ```bash
    iverilog ../my_lib/verilog_model/primitives.v ../my_lib/verilog_model/sky130_fd_sc_hd.v bad_case_net.v tb_bad_case.v
    ./a.out
    ```
    
12. View waveform of synthesized netlist:
    
    ```bash
    gtkwave tb_bad_case.vcd
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/bad_case-05.png" width="600"/>
    

# Synthesis & Verilog Coding Styles: Loop Constructs

This section covers **for loops** and **generate for loops**, their usage in Verilog, and differences in synthesis.

---

## 1. For Loop

- **Location:** Inside `always` blocks.
- **Purpose:** Used to evaluate expressions during simulation or sequential/ combinational logic execution.
- **Characteristics:**
    - Evaluates block expressions.
    - Does not create multiple hardware instances by itself.
    - Example usage: Mux, Demux logic, or iterative calculations inside a block.

**Key Points:**

- Evaluates expressions sequentially during simulation.
- Hardware replication depends on synthesis tool optimization.
- Typically used inside `always` blocks.

---

## 2. Generate For Loop

- **Location:** Outside `always` blocks.
- **Purpose:** Used for **hardware instantiation** and replicating modules or hardware structures.
- **Characteristics:**
    - Generates multiple instances of hardware during compilation/synthesis.
    - Cannot be used inside an `always` block.
    - Example usage: Ripple Carry Adder (RCA), repeated logic blocks.

**Key Points:**

- Generates multiple hardware blocks (parallel replication).
- Must be outside `always` block.
- Used to instantiate repetitive structures efficiently.

---

## 3. Differences Between For Loop and Generate For Loop

| Feature | For Loop | Generate For Loop |
| --- | --- | --- |
| Location | Inside `always` blocks | Outside `always` blocks |
| Purpose | Evaluate expressions | Instantiate/replicate HW |
| Execution | Sequential at runtime | Static at compile time |
| Hardware Instantiation | Not guaranteed | Always generates hardware |
| Typical Use Case | Mux, Demux, counters | RCA, repeated modules |

**Summary:**

- Use `for` loops for expression evaluation inside blocks.
- Use `generate for` loops for instantiating hardware structures.
- Do not mix generate loops inside `always` blocks.

---

## Lab 2: Using Generate For Loop Construct

This lab demonstrates **hardware replication** using `generate for` loops with examples of MUX, DEMUX, and RCA (Ripple Carry Adder) using full adder module `fa.v`.

Lab 2a: MUX Using Generate For Loop

**Design File:** `mux_generate.v`

### Steps

1. Open the file:
    
    ```bash
    cd verilog_files
    gvim mux_generate.v tb_mux_generate.v -o
    ```
    
2. Compile and simulate:
    
    ```bash
    iverilog mux_generate.v tb_mux_generate.v
    ./a.out
    ```
    
3. View waveform:
    
    ```bash
    gtkwave tb_mux_generate.vcd
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/mux_generate-01.png" width="600"/>
    
4. Synthesize in Yosys:
    
    ```
    read_verilog mux_generate.v
    read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    synth -top mux_generate
    abc -liberty ./my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    show
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/mux_generate-02.png" width="600"/>
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/mux_generate-03.png" width="600"/>
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/mux_generate-04.png" width="600"/>
    

---

## Lab 2b: DEMUX Using Generate For Loop

**Design File:** `demux_generate.v`

### Steps

1. Open the file:
    
    ```bash
    cd verilog_files
    gvim demux_generate.v tb_demux_generate.v -o
    ```
    
2. Compile and simulate:
    
    ```bash
    iverilog demux_generate.v tb_demux_generate.v
    ./a.out
    ```
    
3. View waveform:
    
    ```bash
    gtkwave tb_demux_generate.vcd
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/demux_generate-01.png" width="600"/>
    
4. Synthesize in Yosys:
    
    ```
    read_verilog demux_generate.v
    read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    synth -top demux_generate
    abc -liberty ./my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    show
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/demux_generate-02.png" width="600"/>
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/demux_generate-03.png" width="600"/>
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/demux_generate-04.png" width="600"/>
    

---

## Lab 2c: RCA Using Generate For Loop

**Design Files:** `rca.v`, `fa.v`

### Steps

1. Open the files:
    
    ```bash
    cd verilog_files
    gvim rca.v fa.v tb_rca.v -o
    ```
    
2. Compile and simulate:
    
    ```bash
    iverilog fa.v rca.v tb_rca.v
    ./a.out
    ```
    
3. View waveform:
    
    ```bash
    gtkwave tb_rca.vcd
    ```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/rca-01.png" width="600"/>
    
4. Synthesize in Yosys:
    
    ```
    read_verilog fa.v rca.v 
    read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    synth -top rca
    abc -liberty ./my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    show
    ```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/rca-02.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/rca-03.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%205/Images/rca-04.png" width="600"/>
 
## Summary Notes

- Always write synthesizable and complete combinational logic to avoid inferred latches.
- Use `generate for` loops for hardware replication; never inside `always` blocks.
- Carefully check `if` and `case` coverage to ensure deterministic outputs.
- Follow a consistent synthesis flow for simulation, synthesis, and visualization.

This concludes **Day 5 - Optimisation in Synthesis**, covering **inferred latches**, **coding styles**, **loop constructs**, and **hardware replication techniques**.
