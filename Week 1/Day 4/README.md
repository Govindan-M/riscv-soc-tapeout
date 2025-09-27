# 📘 Day 4 – GLS, Blocking/Non-Blocking, Synthesis–Simulation Mismatch
## 🔹 Gate Level Simulation (GLS)

### What is GLS?

- **Gate Level Simulation (GLS)** is running a testbench on the **synthesized netlist** instead of the RTL code.
- The **netlist** contains **gate-level Verilog models** such as:
    
    ```verilog
    and u_and (.a(a), .b(b), .y(io));
    or  u_or  (.a(io), .b(c), .y(y));
    
    ```
    
- The testbench remains the same → design under test changes from RTL → Netlist.

---

### Types of GLS

1. **Functional GLS**
    - Runs without delays.
    - Checks if **logic is preserved** after synthesis.
2. **Timing-Aware GLS (with SDF annotation)**
    - Runs with **propagation delays, setup/hold checks** included.
    - Used for **timing closure validation**.
    - Example: post-layout simulation.

---

## 🔹 Why GLS?

- Verify **logical correctness** after synthesis.
- Ensure **timing correctness** (if delay annotated).
- Detect **Synthesis–Simulation mismatches** early.

---
<img src="" width="600"/>

## 🔹 Synthesis–Simulation Mismatch

Common causes:

1. **Missing Sensitivity List**
    - ❌ Bad:
        
        ```verilog
        always @(sel) y = (sel) ? a : b;
        ```
        
        → Only sensitive to `sel`, misses `a`, `b`.
        
    - ✅ Good:
        
        ```verilog
        always @(*) y = (sel) ? a : b;
        ```
        
        → `@(*)` ensures all inputs included automatically.
        

---

1. **Blocking vs Non-Blocking Assignments**
    
    ### Blocking (`=`):
    
    - Executes sequentially (like C code).
    - Caveat in sequential logic: may create **extra unintended flip-flops** or wrong behavior.
    - Example (Bad):
        
        ```verilog
        always @(posedge clk) begin
           q  = q0;
           q0 = d;
        end
        ```
        
        - Simulation: looks like 2 flip-flops.
        - Synthesis: only **1 flip-flop** is inferred.
    - Correct (using Non-Blocking):
        
        ```verilog
        always @(posedge clk) begin
           q0 <= d;
           q  <= q0;
        end
        ```
        
        - Clear 2-stage register behavior.

---

### Non-Blocking (`<=`):

- Evaluates RHS in parallel, updates LHS at end of block.
- **Best practice:** use `<=` for sequential logic.

---

1. **Order of Assignments**
    - Example of mismatch:
        
        ```verilog
        always @(*) begin
           y  = q0 & c;
           q0 = a | b;
        end
        ```
        
        - Simulation: `y` uses **old q0** (like a flop).
    - Correct (re-ordering):
        
        ```verilog
        always @(*) begin
           q0 = a | b;
           y  = q0 & c;
        end
        ```
        
        - Simulation now matches synthesis, using **latest q0**.

# 🧪 Lab 1 – Invoke GLS & Basics of Gate Level Simulation

This lab demonstrates the flow of **GLS (Gate-Level Simulation)** for three Verilog programs:

1. `ternary_operator_mux.v`
2. `bad_mux.v`
3. `good_mux.v`

We will run **RTL simulation**, **synthesis with Yosys**, and finally **GLS** using the synthesized netlist.

---

## 📂 Directory Setup

Make sure you are inside:

```
../verilog_files/
```

---

## Part A: `ternary_operator.v`

### 1️⃣ RTL Simulation

```bash
# Step 1: Compile RTL design + testbench
iverilog ternary_operator.v tb_ternary_operator.v

# Step 2: Run simulation
./a.out

# Step 3: Open waveform
gtkwave ternary_operator.vcd
```

---
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/ternary_operator_mux-01.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/ternary_operator_mux-02.png" width="600"/>

### 2️⃣ Synthesis using Yosys

```bash
# Step 4: Launch yosys
yosys

# Step 5: Read technology library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.lib

# Step 6: Read RTL design
read_verilog ternary_operator.v

# Step 7: Synthesize top module
synth -top ternary_operator_mux

# Step 8: Technology mapping
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.lib

# Step 9: Write synthesized netlist
write_verilog -noattr ternary_operator_mux_net.v

# Step 10: Show schematic
show
```

---
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/ternary_operator_mux-03.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/ternary_operator_mux-04.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/ternary_operator_mux-05.png" width="600"/>

### 3️⃣ Invoke GLS

```bash
# Step 11: Compile with standard cell library + primitives + netlist + testbench
iverilog ../my_lib/verilog_model/primitives.v 
        ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.v 
        ternary_operator_mux_net.v 
        tb_ternary_operator_mux.v
# Step 12: Run simulation
./a.out
# Step 13: Open waveform
gtkwave tb_ternary_operator_mux.vcd
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/ternary_operator_mux-06.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/ternary_operator_mux-07.png" width="600"/>

# Part B: `bad_mux.v`

---

## 1️⃣ RTL Simulation

```bash
# Step 1: Compile RTL design + testbench
iverilog bad_mux.v tb_bad_mux.v

# Step 2: Run simulation
./a.out

# Step 3: Open waveform
gtkwave bad_mux.vcd
```
---
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/bad_mux-01.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/bad_mux-02.png" width="600"/>

## 2️⃣ Synthesis using Yosys

```bash
# Step 4: Launch yosys
yosys

# Step 5: Read technology library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.lib

# Step 6: Read RTL design
read_verilog bad_mux.v

# Step 7: Synthesize top module
synth -top bad_mux

# Step 8: Technology mapping
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.lib

# Step 9: Write synthesized netlist
write_verilog -noattr bad_mux_net.v

# Step 10: Show schematic
show
```
---
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/bad_mux-03.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/bad_mux-04.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/bad_mux-05.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/bad_mux-06.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/bad_mux-07.png" width="600"/>

## 3️⃣ Invoke GLS

```bash
# Step 11: Compile with standard cell library + primitives + netlist + testbench
iverilog ../my_lib/verilog_model/primitives.v 
        ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.v 
        bad_mux_net.v 
        tb_bad_mux.v

# Step 12: Run simulation
./a.out

# Step 13: Open waveform
gtkwave tb_bad_mux.vcd
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/bad_mux-08.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/bad_mux-09.png" width="600"/>

# Part C: `good_mux.v`

---

## 1️⃣ RTL Simulation

```bash
# Step 1: Compile RTL design + testbench
iverilog good_mux.v tb_good_mux.v

# Step 2: Run simulation
./a.out

# Step 3: Open waveform
gtkwave good_mux.vcd
```
---
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/good_mux-01.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/good_mux-02.png" width="600"/>

## 2️⃣ Synthesis using Yosys

```bash
# Step 4: Launch yosys
yosys

# Step 5: Read technology library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.lib

# Step 6: Read RTL design
read_verilog good_mux.v

# Step 7: Synthesize top module
synth -top good_mux

# Step 8: Technology mapping
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.lib

# Step 9: Write synthesized netlist
write_verilog -noattr good_mux_net.v

# Step 10: Show schematic
show
```
---
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/good_mux-03.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/good_mux-04.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/good_mux-05.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/good_mux-06.png" width="600"/>

## 3️⃣ Invoke GLS

```bash
# Step 11: Compile with standard cell library + primitives + netlist + testbench
iverilog ../my_lib/verilog_model/primitives.v \
        ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.v \
        good_mux_net.v \
        tb_good_mux.v

# Step 12: Run simulation
./a.out

# Step 13: Open waveform
gtkwave tb_good_mux.vcd
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/good_mux-07.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/good_mux-08.png" width="600"/>

# 🧪 Lab 2 – Synthesis–Simulation Mismatch Analysis

### **Objective**

- Understand **blocking (`=`) vs non-blocking (`<=`) assignments** in sequential logic.
- Observe **simulation vs synthesized netlist mismatches**.
- Learn **best practices** to avoid RTL vs netlist mismatch.

Example:`blocking_caveat.v`

## 1️⃣ RTL Simulation

```bash
# Step 1: Compile RTL design + testbench
iverilog blocking_caveat.v tb_blocking_caveat.v

# Step 2: Run simulation
./a.out

# Step 3: Open waveform
gtkwave blocking_caveat.vcd

```
---
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/blocking_caveat-01.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/blocking_caveat-02.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/blocking_caveat-03.png" width="600"/>

## 2️⃣ Synthesis using Yosys

```bash
# Step 4: Launch yosys
yosys

# Step 5: Read technology library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.lib

# Step 6: Read RTL design
read_verilog blocking_caveat.v

# Step 7: Synthesize top module
synth -top blocking_caveat

# Step 8: Technology mapping
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.lib

# Step 9: Write synthesized netlist
write_verilog -noattr blocking_caveat_net.v

# Step 10: Show schematic
show

```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/blocking_caveat-04.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/blocking_caveat-05.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/blocking_caveat-06.png" width="600"/>

## 3️⃣ Invoke GLS

```bash
# Step 11: Compile with standard cell library + primitives + netlist + testbench
iverilog ../my_lib/verilog_model/primitives.v \
        ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.v \
        blocking_caveat_net.v \
        tb_blocking_caveat.v

# Step 12: Run simulation
./a.out

# Step 13: Open waveform
gtkwave tb_blocking_caveat.vcd

```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/blocking_caveat-07.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%204/blocking_caveat-08.png" width="600"/>

### 🔹 Lab Programs: `ternary_operator.v`, `bad_mux.v`, `good_mux.v`)

1. Simulate RTL → `iverilog` + `gtkwave`.
2. Synthesize → `yosys` + Sky130 library.
3. Run GLS → simulate netlist with testbench.

✅ **Takeaway:**

Good coding practices ensure **RTL = GLS** results.
