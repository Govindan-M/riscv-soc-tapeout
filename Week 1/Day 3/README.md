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

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/gvim%20opt_checks%20files.png" width="600"/>


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
```bash
read_verilog opt_check.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check-01.png" width="600"/>

# Step 4: Synthesize Top Module
```bash
synth -top opt_check
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check-02.png" width="600"/>

# Step 5: Constant Propagation & Cleanup
```bash
opt_clean -purge
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check-03.png" width="600"/>

# Step 6: Optimise with ABC
```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check-04.png" width="600"/>

# Step 7: Visualise the Design
```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check-05.png" width="600"/>

✅ *Demonstrates basic constant propagation and logic simplification.*

## 📝 Exercise 2 - `opt_check2`

Run the following Yosys flow for optimisation:

```bash 
# Step 1: Invoke Yosys
yosys

# Step 2: Read Standard Cell Library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 3: Read Verilog Design
read_verilog opt_check2.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check2-01.png" width="600"/>

# Step 4: Synthesize Top Module
```bash
synth -top opt_check2
```

# Step 5: Constant Propagation & Cleanup
```bash
opt_clean -purge
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check2-02.png" width="600"/>

# Step 6: Optimise with ABC
```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check2-03.png" width="600"/>

# Step 7: Visualise the Design
```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check2-04.png" width="600"/>

### 📝 Exercise 3 - `opt_check3`

```bash
# Step 1: Invoke Yosys
yosys

# Step 2: Read Standard Cell Library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 3: Read Verilog Design
read_verilog opt_check3.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check3-01.png" width="600"/>

# Step 4: Synthesize Top Module
```bash
synth -top opt_check3
```
# Step 5: Constant Propagation & Cleanup
```bash
opt_clean -purge
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check3-02.png" width="600"/>

# Step 6: Optimise with ABC
```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check3-03.png" width="600"/>

# Step 7: Visualise the Design
```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check3-04.png" width="600"/>

### 📝 Exercise 4 - `opt_check4`

```bash
# Step 1: Invoke Yosys
yosys

# Step 2: Read Standard Cell Library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 3: Read Verilog Design
read_verilog opt_check4.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check4-01.png" width="600"/>

# Step 4: Synthesize Top Module
```bash
synth -top opt_check4
```

# Step 5: Constant Propagation & Cleanup
```bash
opt_clean -purge
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check4-02.png" width="600"/>

# Step 6: Optimise with ABC
```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check4-03.png" width="600"/>

# Step 7: Visualise the Design
```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/opt_check4-04.png" width="600"/>

## 📝 Exercises 5 - `multiple_module_opt`

```bash
# Step 1: Invoke Yosys
yosys

# Step 2: Read Standard Cell Library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 3: Read Verilog Design
read_verilog ../verilog_files/multiple_module_opt.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/multiple_module_opt-01.png" width="600"/>

```bash
# Step 4: Synthesize Top Module
synth -top multiple_module_opt

# Step 5: Constant Propagation & Cleanup
opt_clean -purge
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/multiple_module_opt-03.png" width="600"/>

# Step 6: Optimise with ABC
```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/multiple_module_opt-04.png" width="600"/>

# Step 7: Visualise the Design
```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/multiple_module_opt-05.png" width="600"/>

### 📝 Exercises 6 - `multiple_module_opt2`

```bash
# Step 1: Invoke Yosys
yosys

# Step 2: Read Standard Cell Library
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 3: Read Verilog Design
read_verilog ../verilog_files/multiple_module_opt2.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/multiple_module_opt2-01.png" width="600"/>

```bash
# Step 4: Synthesize Top Module
synth -top multiple_module_opt2

# Step 5: Constant Propagation & Cleanup
opt_clean -purge
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/multiple_module_opt2-02.png" width="600"/>

# Step 6: Optimise with ABC
```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/multiple_module_opt2-04.png" width="600"/>

# Step 7: Visualise the Design
```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/multiple_module_opt2-05.png" width="600"/>

# Lab2: Sequential Logic Optimisation

## 📂 Files

Inside the working directory of `../verilog_files/`:

```bash
ls
ls *dff_const*
gvim dff_const1.v -o dff_const2.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/gvim%20dff_const%20files.png" width="600"/>

---

## 📝 Exercises 1 - `dff_const1.v`

### A) Waveform Simulation

```bash
# Step 1: Compile Verilog Design with Testbench
iverilog dff_const1.v tb_dff_const1.v

# Step 2: Run Simulation
./a.out
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const1-01.png" width="600"/>

# Step 3: View Waveform
```bash
gtkwave tb_dff_const1.vcd
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const1-02.png" width="600"/>

✅ *Observe DFF behaviour, reset/set functionality, and propagation delays.*

### B) Synthesis using Yosys

```bash
# Step 4: Invoke Yosys
yosys

# Step 5: Read Verilog Design
read_verilog dff_const1.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const1_synth-01.png" width="600"/>

# Step 6: Synthesize Top Module
```bash
synth -top dff_const1
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const1_synth-03.png" width="600"/>

# Step 7: Map DFFs to library cells
```bash
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const1_synth-04.png" width="600"/>

# Step 8: Optimise with ABC
```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const1_synth-05.png" width="600"/>

# Step 9: Visualise the Synthesised Design
```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const1_synth-06.png" width="600"/>

✅ *Demonstrates sequential logic optimisation, constant propagation, and DFF mapping.*

### 📝 Lab Exercises 2 - `dff_const2.v`

### A) Waveform Simulation

```bash
iverilog dff_const2.v tb_dff_const2.v
./a.out
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const2-01.png" width="600"/>

```bash
gtkwave tb_dff_const2.vcd
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const2-02.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const2-03.png" width="600"/>

✅ *Observe DFF behaviour, reset/set functionality, and propagation delays.*

### B) Synthesis using Yosys

```bash
yosys
read_verilog dff_const2.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const2_synth-01.png" width="600"/>

```bash
synth -top dff_const2
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const2_synth-02.png" width="600"/>

```bash
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const2_synth-03.png" width="600"/>

```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const2_synth-04.png" width="600"/>

```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const2_synth-05.png" width="600"/>

✅ *Demonstrates sequential logic optimisation, constant propagation, and DFF mapping.*

### 📝 Lab Exercises 3 - `dff_const3.v`

### A) Waveform Simulation

```bash
iverilog dff_const3.v tb_dff_const3.v
./a.out
gtkwave tb_dff_const3.vcd
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const3-01.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const3-02.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const3-03.png" width="600"/>```

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
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const3_synth-01.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const3_synth-02.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const3_synth-03.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const3_synth-04.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const3_synth-05.png" width="600"/>

✅ *Demonstrates sequential logic optimisation, constant propagation, and DFF mapping.*

---

### 📝 Lab Exercises 4 - `dff_const4.v`

### A) Waveform Simulation

```bash
iverilog dff_const4.v tb_dff_const4.v
./a.out
gtkwave tb_dff_const4.vcd
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const4-01.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const4-02.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const4-03.png" width="600"/>

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
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const4_synth-01.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const4_synth-02.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const4_synth-03.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const4_synth-04.png" width="600"/>

✅ *Demonstrates sequential logic optimisation, constant propagation, and DFF mapping.*

---

### 5. `dff_const5.v`

### A) Waveform Simulation

```bash
iverilog dff_const5.v tb_dff_const5.v
./a.out
gtkwave tb_dff_const5.vcd
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const5-01.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const5-02.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const5-03.png" width="600"/>

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
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const5_synth-01.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const5_synth-02.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const5_synth-03.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const5_synth-04.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/dff_const5_synth-05.png" width="600"/>

✅ *Demonstrates sequential logic optimisation, constant propagation, and DFF mapping.*

# Lab3: Sequential Optimisation – Unused Outputs

## 📂 Example File

- `counter_opt.v` → 3-bit counter
- Only `c[0]` output is used (toggles on clock pulse)
- `c[1]` and `c[2]` are **unused pins**

---

## 🛠️ Synthesis Flow to Verify Optimisation

```bash
# Step 1: Invoke Yosys
yosys

# Step 2: Read Standard Cell Library
read_liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 3: Read Verilog Design
read_verilog counter_opt.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/counter_opt-01.png" width="600"/>

# Step 4: Synthesize Top Module
```bash
synth -top counter_opt
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/counter_opt-02.png" width="600"/>

# Step 5: Map DFFs to library cells
```bash
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/counter_opt-03.png" width="600"/>

# Step 6: Optimise with ABC
```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/counter_opt-04.png" width="600"/>

# Step 7: Visualise the Synthesised Design
```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/counter_opt-05.png" width="600"/>

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
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/counter_opt2-01.png" width="600"/>

```bash
# Step 2: Copy original RTL to new file
cp counter_opt.v counter_opt2.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/counter_opt2-02.png" width="600"/>
```bash
# Step 3: Modify RTL in new file
gvim counter_opt2.v
# Change the assign statement to:
# assign q = (count[2:0] == 3'b100)
# Save changes (:wa!)
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/counter_opt2-03.png" width="600"/>

✅ *This modification creates a new output condition based on the counter value.*

---

## 🛠️ Synthesis Flow using Yosys

```bash
# Step 4: Launch Yosys
yosys

# Step 5: Read Standard Cell Library
read_liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Step 6: Read Modified Verilog Design
read_verilog counter_opt2.v
```

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/counter_opt2-04.png" width="600"/>

# Step 7: Synthesize Top Module
```bash
synth -top counter_opt   # Note: DFF_PPO -> 3
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/counter_opt2-05.png" width="600"/>

# Step 8: Map DFFs to library cells
```bash
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/counter_opt2-06.png" width="600"/>

# Step 9: Optimise with ABC
```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/counter_opt2-07.png" width="600"/>

# Step 10: Visualise the Synthesised Design
```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%203/Images/counter_opt2-08.png" width="600"/>

✅ *This lab demonstrates RTL modification, synthesising a new logic condition, and visualising the effect on the netlist and DFF outputs.*
