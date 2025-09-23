# Day 1 - Introduction to Verilog RTL Design and Synthesis 
- **RTL design** refers to behavioral representation of the required Specification.
- **Verilog** is a Hardware Description Language (HDL) used to describe and simulate digital logic circuits.

## Introduction to Icarus Verilog (iverilog)

🔹 **iverilog** is a free and open-source Verilog simulation and synthesis tool.

🔹 Used primarily for simulating Verilog designs and testing them with a testbench.

🔹 The output of simulation is often a **dump VCD (Value Change Dump) file** which can be viewed using waveform viewers like **GTKWave**.

## Key Components in Simulation

🔧 **Design**  
  - The actual Verilog code (or modules) that define the logic circuit.  
  - Represents the intended functionality as per given specifications.

🧪 **Testbench**  
  - A non-synthesizable Verilog module that applies stimulus (test vectors) to the design.  
  - Used only for simulation purposes to verify that the design works as expected.
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%201/Images/testbench%20flow.png" width="600"/>

  - A **stimulus generator** is responsible for producing **Primary inputs** and sending them to the DUT (Design Under Test) to simulate different scenarios and validate the design’s functionality.

  - A **stimulus observer** is used to monitor outputs and check the correctness of the DUT’s response to the inputs applied by the stimulus generator.

🛠️ **Simulator**  
  - Tool used to run and monitor simulations (like iverilog + vvp or GTKWave for waveforms).  
  - Checks if the design behaves as expected when different inputs are applied.

## How the Simulator Works
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%201/Images/iverilog%20flow.png" width="600"/>

- 👀 The simulator monitors changes in input signals.  
- ⚡ If an input changes, the simulator:  
  - Evaluates the outputs based on the logic in the design.  
- 🔄 If inputs do not change, there is:  
  - No change in outputs.

> **In essence:**  
> ⚙️ Simulation is **event-driven** → Only runs computations when input signals change.

## Key Takeaways

- ✅ A Verilog simulation setup includes:  
  - Design (Verilog code)  
  - Testbench (stimulus generator)  
  - Simulator (to evaluate responses)

- ✅ Simulation helps verify the design before synthesis or hardware implementation.

- ✅ Understanding how simulators detect signal changes is crucial to writing efficient testbenches.

# 🛠️ Tool Flow Setup – Step-by-Step

This guide will help you set up the directory structure and clone the Sky130 RTL Design and Synthesis Workshop repository.

---

## 🗂️ 1. Create a Project Directory
This creates and enters a new directory called VLSI.

```bash
mkdir VLSI
cd VLSI
```


## 📁 2. Create a Directory for VSD Flow
This folder can be used to store additional tools, scripts, or outputs related to the VSD Flow methodology.
```bash
mkdir vsdflow
```


## 🔽 3. Clone the Sky130 RTL Design & Synthesis Workshop Repository
This command clones the official GitHub repository for the Sky130 RTL Design and Synthesis Workshop. It contains:
- RTL (Verilog) design files
- Synthesis scripts

```bash
git clone https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop
```

## 📂 4. Navigate into the Cloned Repository

Navigate into the main workshop folder that was cloned from the repository:

```bash
cd sky130RTLDesignAndSynthesisWorkshop
```

## 📚 5. Enter the Working Library Folder

Navigate into the `my_lib` directory —  **working area** inside the repository:

```bash
cd my_lib
```
 <img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%201/Images/iverilog%20tool%20setup.png" width="600"/>

## 📁 Structure of my_lib

This folder is structured into two key parts:

- Contains the standard cell library in .lib format.

- These are used during synthesis to map your RTL designs to physical cells.

### **verilog_model**

- Contains Verilog models corresponding to each standard cell defined in the .lib file.

- This is used for gate-level simulation and verification after synthesis.

### **verilog_files (Inside verilog_model)**

- This subfolder holds all our RTL design files.

- We can  write, modify, and simulate your Verilog source files here.
## 🧪 How to Simulate Verilog Design with Icarus Verilog and GTKWave


### 1. Compile the design and testbench using `iverilog`

To simulate your design, run the `iverilog` command with your **design file** and **testbench file** as arguments.

**Example: Simulating a 2x1 Multiplexer**

If your Verilog source and testbench files are:

- `good_mux.v` (design)

```bash
module good_mux (input i0 , input i1 , input sel , output reg y);
always @ (*)
begin
	if(sel)
		y <= i1;
	else 
		y <= i0;
end
endmodule

```
- `tb_good_mux.v` (testbench)


```bash

module tb_good_mux;
	reg i0,i1,sel; 	// Inputs
	wire y; 	// Outputs
// Instantiate the Unit Under Test (UUT)
	good_mux uut (
		.sel(sel),
		.i0(i0),
		.i1(i1),
		.y(y)
	);
	initial begin
	$dumpfile("tb_good_mux.vcd");
	$dumpvars(0,tb_good_mux);
	// Initialize Inputs
	sel = 0;
	i0 = 0;
	i1 = 0;
	#300 $finish;
	end
always #75 sel = ~sel;
always #10 i0 = ~i0;
always #55 i1 = ~i1;
endmodule

```


Navigate to the `verilog_files/` directory in the terminal and run:

```bash
iverilog good_mux.v tb_good_mux.v
```
This compiles the files and produces an executable ./a.out by default.

### 2. Run the simulation and generate waveform dump (.vcd file)

Run the compiled executable to simulate and dump the waveform data:

`./a.out`


Assuming your testbench includes $dumpfile("tb_good_mux.vcd") and $dumpvars commands, this will create the waveform dump file tb_good_mux.vcd.

### 3. View the waveform in GTKWave

Launch GTKWave with the generated .vcd file to visualize the simulation:

```bash 
gtkwave tb_good_mux.vcd
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%201/Images/dump%20the%20vcd%20file.png" width="600"/>

### 4. Edit design and testbench files side-by-side with gvim

You can open your testbench and design files in gvim for editing:
```bash
gvim -O tb_good_mux.v good_mux.v
```
## 📚 5. View the Simulation Waveform in GTKWave

After running the simulation and generating the `.vcd` file, open it using GTKWave to visualize the waveform:

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%201/Images/gtkwave%20waveform.jpeg" width="600"/>

## 🔍 Basic GTKWave Controls

When viewing waveforms in GTKWave, here are **5 essential keys/functions** you should know:

| Key / Function           | Description                                      |
|-------------------------|------------------------------------------------|
| **Zoom Fit**             | Automatically fits the entire waveform in view. Useful for a full overview. |
| **Zoom In**              | Zooms into the waveform for a closer look at signal transitions.            |
| **Zoom Out**             | Zooms out to show a wider time window.                                       |
| **Backward Transition** | Moves the cursor to the previous signal transition (edge).                   |
| **Forward Transition**  | Moves the cursor to the next signal transition (edge).

## 📝 Command Summary

| Command                                            | Purpose                                  |
|--------------------------------------------------|------------------------------------------|
| `iverilog <design_name.v> <testbench_name.v>`     | Compile design and testbench              |
| `./a.out`                                         | Run simulation and generate waveform     |
| `gtkwave <testbench_name>.vcd`                    | View simulation waveform                  |
| `gvim -O <testbench_name.v> <design_name.v>`      | Edit testbench and design side-by-side   |

# Introduction To Yosys
## ⚙️ **Synthesizer**
Tool used for converting RTL to netlist
## **Yosys Setup**
🔹 read_verilog → Loads RTL design (Verilog).

🔹 read_liberty → Loads standard cell library (.lib) with gate, timing, and power info.

🔹 write_verilog → Writes out synthesized gate-level netlist.
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%201/Images/yosys%20setup.png" width="600"/>

## **Verify the Synthesis**
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%201/Day%201/Images/netlist%20synthesis.png" width="600"/>

### **Key Points**

👉 The top module name stays the same.

👉 The primary inputs/outputs remain unchanged between RTL and netlist.

👉 The same testbench can be used for both RTL and synthesized netlist.

**Difference:**

🔹 RTL → behavioral (always blocks, operators).

🔹 Netlist → structural (gates & flip-flops from .lib).
