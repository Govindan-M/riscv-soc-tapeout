# 📘 Introduction to  Dot Liberty Files

- A **`.lib` file (Liberty file)** is a **timing and power characterization file** used in the ASIC/VLSI flow.  

- It is provided by the **foundry/vendor** for each standard cell library.  

---

## 🔹 What does a `.lib` file describe?
- ✅ Logical functions of cells (e.g., AND, OR, INV, etc.)  
- ✅ Timing models (delay, transition times, setup/hold)  
- ✅ Power models (leakage, dynamic power)  
- ✅ Operating conditions (PVT corners)  
- ✅ Units for time, voltage, current, etc.  

📌 This file is used during:
- **Logic Synthesis**  
- **Static Timing Analysis (STA)**  
- **Power Analysis**  

---

## Example Command
This opens the Sky130 liberty file for the HD (high density) standard cell library at a particular PVT corner.
```bash
gvim ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.lib
```
## 🔹 Understanding the File Naming Convention


- **sky130_fd_sc_hd** → SkyWater 130nm, standard cell high density  
- **tt** → Process corner (typical-typical)  
- **025c** → Temperature = 25°C  
- **1v80** → Voltage = 1.8 V  

---

## 🔹 PVT Corners

Every `.lib` is tied to **PVT (Process, Voltage, Temperature)** conditions.

### 🟢 Process (P)
Variations due to fabrication (dopant, oxide thickness, lithography, etc.)  

Common corners:
- `ss` = slow-slow  
- `tt` = typical-typical  
- `ff` = fast-fast  
- Mixed: `sf` or `fs`  

### 🟡 Voltage (V)
Supply voltage at which characterization is done.  

Examples: `1.60 V`, `1.80 V`, `1.95 V`  


### 🔴 Temperature (T)
Operating temperature.  

Examples: `-40°C`, `25°C`, `125°C`  

# 🧪 **Lab 1: Behaviour of `.lib` file**

### Step 1 – Open the .lib file

- This opens the Liberty file (.lib) which contains timing, power, and functional models for all standard cells in the Sky130_fd_sc_hd library.

- `tt_025c_1v80` → Typical Process Corner, 25°C, 1.8V
```bash
gvim ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/Dot%20lib%20file01.png" width="600"/>

### Step 2 – Disable Syntax Highlighting (Optional)

- Sometimes, gvim highlights keywords in confusing ways. To disable it:

```bash
:syn off
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dot%20lib%20file02.png" width="600"/>
- This makes the text appear plain, so it’s easier to search and read values.

### Step 3 – Search and Navigate Inside .lib

- After opening the .lib in gvim, set some useful options:
```bash

:se hls      " highlight search matches
:se nu       " show line numbers
```


- Now, search for all cells:
```bash
/cell
```

- This jumps to the next cell() block (each standard cell definition starts with this).

- To specifically check AND gates:
```bash
/and2_0
/and2_2
/and2_4
```

### Step 4 – Compare Variations

Compare **and2_0** vs **and2_2** vs **and2_4** for:

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/cell%20process.png" width="600"/>

- **Leakage power** → should increase with size.

- **Rise/Fall times** → should decrease with size.

- **Footprint** → same logical footprint, but different physical sizes.

# 🧪 **Lab 2: Hierarchical vs Flat Synthesis**  

- This lab explores the difference between **hierarchical synthesis** and **flat synthesis** using Yosys with the Sky130 standard cell library.  

---

## 1️⃣ Hierarchical Synthesis  

## 🔹 Definition  
- Hierarchical synthesis preserves the **module hierarchy** of the RTL design during synthesis.  
- Each submodule remains visible in the synthesized netlist, making debugging and analysis easier.  

---

### 📌 Example: `multiple_modules.v`  

### Step 1 – Invoke Yosys  
```bash
yosys
```
### Step 2 – Read the Verilog Design
```bash
read_verilog multiple_modules.v
```

### Step 3 – Read the Liberty File
```bash
read_liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.lib
```

### Step 4 – Run Synthesis
```bash
synth -top multiple_modules
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/Hierarchical%20Synthesis01.png" width="600"/>

### Step 5 – Technology Mapping
```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025c_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/multiple_modules_ABC%20result.jpeg" width="600"/>

### Step 6 – View the Netlist
```bash
show multiple_modules
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/multiple_modules_synthesis.jpeg" width="600"/>

👉 The output netlist retains the module hierarchy.

## 2️⃣ Flat Synthesis
## 🔹 Definition

- Flat synthesis removes hierarchy and generates a fully optimized, single-level netlist.
- This usually improves optimization but makes debugging harder.
---

### 📌 Example: Flattening multiple_modules.v

### Step 1 – Invoke Yosys
```bash
yosys
```
### Step 2 – Write Out Hierarchical Netlist
```bash
write_verilog multiple_modules_hier.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/multiple_module_hier.png" width="600"/>

### Step 3 – Inspect in gvim (Optional)
```bash
!gvim multiple_modules_hier.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/multiple_module_flat.png" width="600"/>

### Step 4 – Write Netlist Without Attributes
```bash
write_verilog -noattr multiple_modules_hier.v
```

### Step 5 – Flatten the Design
```bash
flatten
```

### Step 6 – Write Out Flattened Netlist
```bash
write_verilog multiple_modules_flat.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/flat%20synthesis01.png" width="600"/>

### Step 7 – View the Flattened Design
```bash
show multiple_modules_flat
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/Hierarchical%20-dot%20viewer.png" width="600"/>

👉 The output netlist is fully flattened with all modules merged into a single level.

## 📊 Comparison 

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/Hierarchical%20%26%20flat%20synthesis.png" width="600"/>

| Feature           | Hierarchical Synthesis         | Flat Synthesis                    |
|-------------------|--------------------------------|-----------------------------------|
| **Netlist Structure** | Preserves hierarchy             | Removes hierarchy                 |
| **Debugging**         | Easier (modules visible)        | Harder (all merged)               |
| **Optimization**      | Limited to module boundaries    | Global optimization possible      |
| **Readability**       | Higher                         | Lower                             |
| **Runtime**           | Faster                         | Slower (for large designs)        |
# 🧪 **Lab 3:Synthesis on Sub-Module Level**  

- When a design has **multiple instances of the same module**, we can apply a **divide & conquer approach** by synthesizing each sub-module independently. 

- Instead of synthesizing the entire top module at once, each sub-module (sub_module1, sub_module2, etc.) is synthesized independently.

- This helps in **modularity, reusability, and debugging**.  

- Example design: `multiple_modules.v`  

## 🔹 Sub-Module 1 Synthesis  


### Step 1: Invoke Yosys

```bash
yosys
```

### Step 2: Read Liberty File
```bash
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```

### Step 3: Read the Verilog Design

```bash
read_verilog multiple_modules.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/sub_module01-1.png" width="600"/>

### Step 4: Synthesize for Sub-Module 1

```bash
synth -top sub_module1
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/sub_module01-2.png" width="600"/>

### Step 5: Technology Mapping with Liberty

```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/sub_module01-3.png" width="600"/>


### Step 6: View the Synthesized Netlist
```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/sub_module01-dotviewer.png" width="600"/>

## 🔹 Sub-Module 2 Synthesis  


### Step 1: Invoke Yosys

```bash
yosys
```

### Step 2: Read Liberty File
```bash
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```

### Step 3: Read the Verilog Design

```bash
read_verilog multiple_modules.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/sub_module02-1.png" width="600"/>

### Step 4: Synthesize for Sub-Module 1

```bash
synth -top sub_module2
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/sub_module02-2.png" width="600"/>

### Step 5: Technology Mapping with Liberty

```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/sub_module02-3.png" width="600"/>

### Step 6: View the Synthesized Netlist
```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/sub_module02-dotviewer.png" width="600"/>

### **Benefits:**
- Easier to debug each block.

 - Improves modularity.

- Useful when the same sub-module is instantiated multiple times in the top design.

# Flip-Flop Coding Styles & Glitch Notes

## 🔹 Glitch
- **Definition**: Short spurious change due to path delays in combinational circuits.  
- **Happens**: Only in **combinational logic** (continuous outputs).  
- **Fix**: Use **flops on clock edge** to register outputs.  

---

## 🔹 Flops & Initial State
- Flops without init → **garbage state**.  
- Use **control pins (reset/set)** to start from known state.  
- **Reset/Set types**:  
  - **Asynchronous** → immediate effect (independent of clk).  
  - **Synchronous** → applied on clk edge.  

## 🔹 4 Major DFF Types
- `dff_asyncres_syncres.v`
- `dff_asyncres.v`
- `dff_async_set.v`
- `dff_syncres.v`

## 🧪 LAB 4 — Simulate waveforms & Synthesize 4 DFF types

## A. Simulation (generate VCD and view in GTKWave)
**Goal:** simulate each DFF + testbench and view waveform.

## TYPE 1: `dff_asyncres_syncres`

**Step 1:**
- All design and TB files present in `verilog_files/`

**Step 2:**
- To Compile the Simulation:
  ```bash
  iverilog dff_asyncres_syncres.v tb_dff_asyncres_syncres.v
  ```
 
**Step 3:**
- Run simulation (creates .vcd file from testbench):
```bash
./a.out
```
**Step 4:**
- View waveform:
```bash
gtkwave tb_dff_asyncres_syncres.vcd
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres_syncres01.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres_syncres02.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres_syncres03.jpeg" width="600"/>

## TYPE 2: `dff_asyncres`

**Step 1:**
- All design and TB files present in `verilog_files/`.

**Step 2:**
- To Compile the Simulation:
  ```bash
  iverilog dff_asyncres.v tb_dff_asyncres.v
  ```
**Step 3:**
- Run simulation (creates .vcd file from testbench):
```bash
./a.out
```
**Step 4:**
- View waveform:
```bash
gtkwave tb_dff_asyncres.vcd
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres01.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres02.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres03.jpeg" width="600"/>

## TYPE 3: `dff_async_set`

**Step 1:**
- All design and TB files present in `verilog_files/`.

**Step 2:**
- To Compile the Simulation:
  ```bash
  iverilog dff_async_set.v tb_dff_async_set.v
  ```
**Step 3:**
- Run simulation (creates .vcd file from testbench):
```bash
./a.out
```
**Step 4:**
- View waveform:
```bash
gtkwave tb_dff_async_set.vcd
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_async_set01.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_async_set02.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_async_set03.jpeg" width="600"/>



## TYPE 4:`dff_syncres`

**Step 1:**
- All design and TB files present in `verilog_files/`.
**Step 2:**
 - To Compile the Simulation:
   ```bash
   iverilog dff_syncres.v tb_dff_syncres.v
   ```
**Step 3:**
- Run simulation (creates .vcd file from testbench):
```bash
./a.out
```
**Step 4:**
- View waveform:
```bash
gtkwave tb_dff_syncres.vcd
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_syncres01.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_syncres02.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_syncres03.jpeg" width="600"/>

# B.Synthesis using Yosys

**Common Notes:**
- Standard cell library path: `../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib`
- Run Yosys in shell: `yosys`
- Use `read_liberty`, `read_verilog`, `synth`, `dfflibmap`, `abc`, `show`

---

## TYPE 1: `dff_asyncres_syncres`

**Step 1:** Start Yosys  
```bash
yosys
```
**Step 2:** Read standard cell library
```bash
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```

**Step 3:** Read Verilog design
```bash
read_verilog dff_asyncres_syncres.v
```

**Step 4:** Synthesize top module
```bash
synth -top dff_asyncres_syncres
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres_syncres_syn01.jpeg" width="600"/>

**Step 5:** Map DFFs to library
```bash
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres_syncres_syn02.jpeg" width="600"/>

**Step 6:** Optimize logic using ABC
```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres_syncres_syn03.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres_syncres_syn04.jpeg" width="600"/>

**Step 7:** Show mapped netlist/graph

```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres_syncres_syn05.jpeg" width="600"/>

## TYPE 2: `dff_asyncres`

- Repeat the same steps, replacing design name:
```bash
read_verilog dff_asyncres.v
synth -top dff_asyncres
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres_syn01.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres_syn02.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres_syn03.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres_syn04.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_asyncres_syn05.jpeg" width="600"/>


## TYPE 3: `dff_async_set`
```bash
read_verilog dff_async_set.v
synth -top dff_async_set
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_async_set_synth01.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_async_set_synth02.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_async_set_synth03.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_async_set_synth04.jpeg" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_async_set_synth05.png" width="600"/>

## TYPE 4: `dff_syncres`
```bash
read_verilog dff_syncres.v
synth -top dff_syncres
dfflibmap -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_syncres_synth01.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_syncres_synth02.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_syncres_synth03.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_syncres_synth04.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/dff_syncres_synth05.png" width="600"/>


### ✅ Notes:

- Replace <design_name> for each type.

- show opens Graphviz or produces netlist visualizations.

- Ensure the library path is correct for your repo.

## 🧪 LAB5 — Optimization Example (Multiplier)

**Design Files:**  
- `mult_2.v` → top module `mul2`  
- `mult_8.v` → top module `mul8`

**Standard Cell Library:**  `../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib`

## Steps for Optimization using Yosys

**Example_1: `mult_2.v` (top module `mul2`)**

**Step 1:** Invoke Yosys  
```bash
yosys
```
**Step 2:** Read standard cell library
```bash
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```

**Step 3:** Read Verilog design
```bash
read_verilog mult_2.v
```

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/mul2_01.png" width="600"/>

**Step 4:** Synthesize top module
```bash
synth -top mul2
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/mul2_02.png" width="600"/>

**Step 5:** Optimize logic using ABC
```bash
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/mul2_03.png" width="600"/>

**Step 6:** Show mapped netlist/graph
```bash
show
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/mul2_04.png" width="600"/>

**Step 7:** Write optimized netlist
```bash
write_verilog -noattr mul2_net.v
```

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/mul2_05.png" width="600"/>

**Step 8:** Open netlist in editor (optional)
```bash
!gvim mul2_net.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/mul2_06.png" width="600"/>

**Example_2: `mult_8.v` (top module `mult8`)**

- Repeat the same flow for mult_8.v with top module mult8.

```bash
yosys
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog mult_8.v
synth -top mult8
abc -liberty ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
write_verilog -noattr mult8_net.v
!gvim mul8_net.v
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/mul8_01.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/mul8_02.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/mul8_03.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/mul8_04.png" width="600"/>
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%202/Images/mul8_05.png" width="600"/>


