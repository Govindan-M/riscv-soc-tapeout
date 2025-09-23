# Day 1 - Introduction to Verilog RTL Design and Synthesis

## 1. Introduction to Verilog RTL Design

🔹 **RTL (Register Transfer Level) design** refers to modeling digital circuits at the level of data flow between registers.

🔹 **Verilog** is a Hardware Description Language (HDL) used to describe and simulate digital logic circuits.

## 2. Introduction to Icarus Verilog (iverilog)

🔹 **iverilog** is a free and open-source Verilog simulation and synthesis tool.

🔹 Used primarily for simulating Verilog designs and testing them with a testbench.

🔹 The output of simulation is often a **dump VCD (Value Change Dump) file** which can be viewed using waveform viewers like **GTKWave**.

## 3. Key Components in Simulation

🔧 **Design**  
  - The actual Verilog code (or modules) that define the logic circuit.  
  - Represents the intended functionality as per given specifications.

🧪 **Testbench**  
  - A non-synthesizable Verilog module that applies stimulus (test vectors) to the design.  
  - Used only for simulation purposes to verify that the design works as expected.

🛠️ **Simulator**  
  - Tool used to run and monitor simulations (like iverilog + vvp or GTKWave for waveforms).  
  - Checks if the design behaves as expected when different inputs are applied.

## 4. How the Simulator Works

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
