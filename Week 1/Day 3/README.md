# Introduction to Logic Optimisation

## 🔹 Combinational Logic Optimisation

- **Goal:** Squeeze the logic for the most optimised design → *Area & Power savings*
- **Techniques:**
    - **Constant Propagation** → e.g., `Y = ((A·B) + C)'`, if `A=0` ⇒ `Y = C'`
    - **Direct Optimisation**
    - **Boolean Logic Optimisation**
        - K-Map
        - Quine–McCluskey
- **Example:**
    
    `Y = a ? (b ? C : (c ? a : 0)) : (!c)`
    
## 🔹 Sequential Logic Optimisation

- **Basic:** Sequential constant propagation (e.g., DFF with reset & set pins)
- **Advanced:**
    - **State Optimisation** → Remove/merge unused states
    - **Retiming** → Improve frequency setup/hold efficiency
    - **Sequential Logic Cloning** → Physically aware optimisation (floorplan distance of flip-flops, routing). Copies created from main source to improve performance

# Lab1: Combinational Logic Optimisation

## 📂 Files

Inside `verilog_files/`:

```bash
ls *opt*
ls *opt_check*
gvim opt_check.v
```

---

## 📝 Exercises

1. `opt_check`
2. `opt_check2`
3. `opt_check3`
4. `opt_check4`

## 📝 Exercises 1 - `opt_check`

Run the following Yosys flow for optimisation:

```
# Step 1: Invoke Yosys
yosys

# Step 2: Read Standard Cell Library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 3: Read Verilog Design
read_verilog opt_check.v

# Step 4: Synthesize Top Module
synth -top opt_check

# Step 5: Constant Propagation & Cleanup
opt_clean -purge

# Step 6: Optimise with ABC
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 7: Visualise the Design
show
```

✅ *Demonstrates basic constant propagation and logic simplification.*

## 📝 Exercise 2 - `opt_check2`

Run the following Yosys flow for optimisation:

```
# Step 1: Invoke Yosys
yosys

# Step 2: Read Standard Cell Library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 3: Read Verilog Design
read_verilog opt_check2.v

# Step 4: Synthesize Top Module
synth -top opt_check2

# Step 5: Constant Propagation & Cleanup
opt_clean -purge

# Step 6: Optimise with ABC
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 7: Visualise the Design
show
```

### 📝 Exercise 3 - `opt_check3`

```
# Step 1: Invoke Yosys
yosys

# Step 2: Read Standard Cell Library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 3: Read Verilog Design
read_verilog opt_check3.v

# Step 4: Synthesize Top Module
synth -top opt_check3

# Step 5: Constant Propagation & Cleanup
opt_clean -purge

# Step 6: Optimise with ABC
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 7: Visualise the Design
show
```

### 📝 Exercise 4 - `opt_check4`

```
# Step 1: Invoke Yosys
yosys

# Step 2: Read Standard Cell Library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 3: Read Verilog Design
read_verilog opt_check4.v

# Step 4: Synthesize Top Module
synth -top opt_check4

# Step 5: Constant Propagation & Cleanup
opt_clean -purge

# Step 6: Optimise with ABC
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 7: Visualise the Design
show
```

## 📝 Exercises 5 - `multiple_module_opt`

```
# Step 1: Invoke Yosys
yosys

# Step 2: Read Standard Cell Library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 3: Read Verilog Design
read_verilog ../verilog_files/multiple_module_opt.v

# Step 4: Synthesize Top Module
synth -top multiple_module_opt

# Step 5: Constant Propagation & Cleanup
opt_clean -purge

# Step 6: Optimise with ABC
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 7: Visualise the Design
show
```

### 📝 Exercises 6 - `multiple_module_opt2`

```
# Step 1: Invoke Yosys
yosys

# Step 2: Read Standard Cell Library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 3: Read Verilog Design
read_verilog ../verilog_files/multiple_module_opt2.v

# Step 4: Synthesize Top Module
synth -top multiple_module_opt2

# Step 5: Constant Propagation & Cleanup
opt_clean -purge

# Step 6: Optimise with ABC
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 7: Visualise the Design
show
```

# Lab2: Sequential Logic Optimisation

## 📂 Files

Inside the working directory of `../verilog_files/`:

```bash
ls
ls *dff_const*
gvim dff_const1.v -o dff_const2.v
```

---

## 📝 Exercises 1 - `dff_const1.v`

### A) Waveform Simulation

```bash
# Step 1: Compile Verilog Design with Testbench
iverilog dff_const1.v tb_dff_const1.v

# Step 2: Run Simulation
./a.out

# Step 3: View Waveform
gtkwave tb_dff_const1.vcd
```

✅ *Observe DFF behaviour, reset/set functionality, and propagation delays.*

### B) Synthesis using Yosys

```
# Step 4: Invoke Yosys
yosys

# Step 5: Read Verilog Design
read_verilog dff_const1.v

# Step 6: Synthesize Top Module
synth -top dff_const1

# Step 7: Map DFFs to library cells
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 8: Optimise with ABC
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 9: Visualise the Synthesised Design
show
```

✅ *Demonstrates sequential logic optimisation, constant propagation, and DFF mapping.*

### 📝 Lab Exercises 2 - `dff_const2.v`

### A) Waveform Simulation

```bash
iverilog dff_const2.v tb_dff_const2.v
./a.out
gtkwave tb_dff_const2.vcd
```

✅ *Observe DFF behaviour, reset/set functionality, and propagation delays.*

### B) Synthesis using Yosys

```
yosys
read_verilog dff_const2.v
synth -top dff_const2
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

✅ *Demonstrates sequential logic optimisation, constant propagation, and DFF mapping.*

### 📝 Lab Exercises 3 - `dff_const3.v`

### A) Waveform Simulation

```bash
iverilog dff_const3.v tb_dff_const3.v
./a.out
gtkwave tb_dff_const3.vcd
```

✅ *Observe DFF behaviour, reset/set functionality, and propagation delays.*

### B) Synthesis using Yosys

```
yosys
read_verilog dff_const3.v
synth -top dff_const3
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

✅ *Demonstrates sequential logic optimisation, constant propagation, and DFF mapping.*

---

### 📝 Lab Exercises 4 - `dff_const4.v`

### A) Waveform Simulation

```bash
iverilog dff_const4.v tb_dff_const4.v
./a.out
gtkwave tb_dff_const4.vcd
```

✅ *Observe DFF behaviour, reset/set functionality, and propagation delays.*

### B) Synthesis using Yosys

```
yosys
read_verilog dff_const4.v
synth -top dff_const4
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

✅ *Demonstrates sequential logic optimisation, constant propagation, and DFF mapping.*

---

### 5. `dff_const5.v`

### A) Waveform Simulation

```bash
iverilog dff_const5.v tb_dff_const5.v
./a.out
gtkwave tb_dff_const5.vcd
```

✅ *Observe DFF behaviour, reset/set functionality, and propagation delays.*

### B) Synthesis using Yosys

```
yosys
read_verilog dff_const5.v
synth -top dff_const5
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

✅ *Demonstrates sequential logic optimisation, constant propagation, and DFF mapping.*

# Lab3: Sequential Optimisation – Unused Outputs

## 📂 Example File

- `counter_opt.v` → 3-bit counter
- Only `c[0]` output is used (toggles on clock pulse)
- `c[1]` and `c[2]` are **unused pins**

---

## 🛠️ Synthesis Flow to Verify Optimisation

```
# Step 1: Invoke Yosys
yosys

# Step 2: Read Standard Cell Library
read_liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 3: Read Verilog Design
read_verilog counter_opt.v

# Step 4: Synthesize Top Module
synth -top counter_opt

# Step 5: Map DFFs to library cells
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 6: Optimise with ABC
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 7: Visualise the Synthesised Design
show

```

✅ *This demonstrates sequential optimisation where only the used output (`c[0]`) is synthesised while unused outputs (`c[1]`, `c[2]`) are ignored or removed, reducing logic and improving area/power efficiency.*

# Lab4: RTL Modification & Synthesis

## 📂 Files

- Original file: `counter_opt.v`
- Modified file: `counter_opt2.v`

---

## 🛠️ RTL Modification

```bash
# Step 1: Open original RTL for editing
gvim counter_opt.v

# Step 2: Copy original RTL to new file
cp counter_opt.v counter_opt2.v

# Step 3: Modify RTL in new file
gvim counter_opt2.v
# Change the assign statement to:
# assign q = (count[2:0] == 3'b100)
# Save changes (:wa!)
```

✅ *This modification creates a new output condition based on the counter value.*

---

## 🛠️ Synthesis Flow using Yosys

```
# Step 4: Launch Yosys
yosys

# Step 5: Read Standard Cell Library
read_liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 6: Read Modified Verilog Design
read_verilog counter_opt2.v

# Step 7: Synthesize Top Module
synth -top counter_opt   # Note: DFF_PPO -> 3

# Step 8: Visualise Synthesised Design
show
```

✅ *This lab demonstrates RTL modification, synthesising a new logic condition, and visualising the effect on the netlist and DFF outputs.*
