# 📌 Week 3 – Submission

This week focuses on **post-synthesis verification of BabySoC** using Gate-Level Simulation (GLS) and introduces **Static Timing Analysis (STA)** using OpenSTA.

---

## **Task 1 – Theory & Objective**

**Objective:**

- Understand and perform **Gate-Level Simulation (GLS)** after synthesis.
- Validate functional correctness of the synthesized netlist.
- Get introduced to **Static Timing Analysis (STA)** concepts, including setup/hold checks, slack, and path-based timing analysis.

**Reference Material:**

- GLS methodology: [VSD_HDP – Day 6](https://github.com/Ananya-KM/VSD_HDP/blob/main/Day%206.md)
- STA foundational course (free for 4 days): STA Fundamentals – Udemy

---

## **Task 2 – Part 1: Post-Synthesis GLS (Functional Validation)**

**Steps:**

1. **Synthesize BabySoC Design**
    - Load top-level and submodules, read Liberty libraries, and synthesize using Yosys.
    - Map D-flip-flops and optimize the netlist.
2. **Run Gate-Level Simulation (GLS)**
    - Compile the synthesized netlist with the testbench using Icarus Verilog.
    - Generate `.vcd` waveform files for post-synthesis simulation.
3. **Compare GLS Output with Functional Simulation**
    - Use the Week 2 RTL simulation as a reference.
    - Verify outputs match bit-by-bit; confirm **GLS = Functional outputs**.

**Comment:**

✔️ GLS validates that synthesis preserved the logical and temporal correctness of the design.

**Deliverables:**

- Synthesis logs
- GLS waveform screenshots
- Short note confirming GLS outputs match functional simulation

---

## **Task 3 – Part 2: Fundamentals of STA (Static Timing Analysis)**

**Focus Areas:**

- Setup and hold checks
- Slack calculation
- Clock definitions
- Path-based timing analysis

**Instructions:**

- Go through the Udemy STA course for foundational concepts.
- Take notes or summarize key points in **bullet format** (1-page maximum).

**Deliverable:**

- One-page STA summary notes (bullet points are fine)

---

## **Task 4 – Part 3: Generate Timing Graphs with OpenSTA**

**Tools & References:**

- OpenSTA GitHub: [OpenSTA Repository](https://github.com/The-OpenROAD-Project/OpenSTA)
- Reference Script: [Example Script – Day 19](https://github.com/arunkpv/vsd-hdp/blob/main/docs/Day_19.md)
- Help Documentation: [OpenSTA PDF](https://github.com/The-OpenROAD-Project/OpenSTA/blob/master/doc/OpenSTA.pdf)

**Steps:**

1. Load the synthesized netlist and timing constraints into OpenSTA.
2. Generate timing graphs, including setup and hold paths, slack analysis, and critical paths.
3. Capture at least one timing report and its corresponding graph.

**Deliverables:**

- OpenSTA input scripts
- Timing reports and graphs (screenshots with user ID and timestamp visible)
- Observations: critical path identification, slack interpretation, and overall timing summary

---

## **End-of-Week 3 Goals**

By completing this week, you will:

1. Successfully perform **GLS** and validate functional correctness of BabySoC post-synthesis.
2. Gain foundational understanding of **STA concepts**.
3. Generate and interpret **timing graphs** using OpenSTA to analyze timing paths, slack, and critical paths.

---

**✅ Submission Checklist:**

- Synthesis logs and netlist
- GLS waveform screenshots
- Short note confirming GLS = Functional outputs
- STA summary notes (1-page)
- OpenSTA scripts, timing reports, and graphs
