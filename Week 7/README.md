# 📌 Week 7 – Submission
This Week summarizes the execution of the full Physical Design flow (RTL-to-GDSII) for the BabySoC using OpenROAD, culminating in the generation of the critical post-route SPEF file.

---
## 🎯 I. OBJECTIVES & DELIVERABLES

The core objective was to successfully transform the synthesized netlist into a physical layout and extract accurate parasitic information for timing sign-off.

| Metric | Target / Process | Deliverable | Status |
| :--- | :--- | :--- | :--- |
| **Flow Completion** | RTL -> Synthesis -> Floorplan -> Placement -> CTS -> Routing | Routed Layout | COMPLETE |
| **Quality** | Zero Design Rule Check (DRC) Violations Post-Route | Routing Logs | Achieved: 0 DRC |
| **Timing** | Clock Skew < 1 ns Post-CTS | CTS Log | Target Met |
| **Output** | Post-Route Parasitic Extraction | **vsdbabysoc.spef** | GENERATED |

---
## 🏗️ II. OPENROAD FLOW SETUP

The execution environment was prepared using The-OpenROAD-Project's flow scripts on the Sky130 HD PDK.

### A. Environment Initialization
1. Clone and Initialize: `git clone --recursive ...`
2. Build Tools: `./build_openroad.sh --local`
3. Source Environment: `source ./env.sh`

### B. Design Configuration (`config.mk`)
Key configuration parameters for the **vsdbabysoc** design:
* **PLATFORM:** sky130hd
* **DIE_AREA:** 0 0 1600 1600
* **CORE_AREA:** 20 20 1590 1590
* **MACRO_PLACEMENT_CFG:** $(DESIGN_DIR)/macro.cfg
* **ADDITIONAL_LEFS/LIBS/GDS:** Required macro models (avsddac, avsdpll).

---
## 🚀 III. EXECUTION SEQUENCE (RTL-to-GDSII)

All steps utilized the same design configuration and were executed sequentially using the `make` command.

| Step | Command Argument | Primary Output / Goal |
| :--- | :--- | :--- |
| **1. Synthesis** | `synth` | Gate-level Netlist (.v) |
| **2. Floorplan** | `floorplan` | Die Area, Power Rings, Macro Placement |
| **3. Placement** | `place` | Global & Detailed Standard Cell Placement |
| **4. CTS** | `cts` | Balanced Clock Tree Network (H-tree) |
| **5. Routing** | `route` | All Signal Nets Connected (0 DRC violations) |
| **6. Parasitics** | `parasitics` | **SPEF File Generation** |

### Visual Verification Points
* **Floorplan:** Verification of correct macro placement and power ring continuity. 
* **Placement:** Inspection of cell density and legality; no overlap or high congestion areas.
* **Routing:** Final check confirming $100\%$ routing completion and **zero DRC violations**. 

---
## 🧠 IV. CONCEPT HIGHLIGHT: SPEF GENERATION

### A. SPEF Definition
**SPEF (Standard Parasitic Exchange Format)** is a standardized file format that captures the **electrical parasitics (Resistance and Capacitance)** of all interconnects and nets as physically routed in the layout.

### B. Importance
This extraction is vital because the actual delays of signals on long wires are determined by the physical $R$ and $C$ values. The timing tool (OpenSTA) uses the SPEF file to back-annotate these realistic parasitic values, moving from less accurate **Wire Load Models (WLM)** to **Post-Route Static Timing Analysis (STA)**, which is essential for chip sign-off.

### C. Output Location
The extracted file, `vsdbabysoc.spef`, is located in: `results/sky130hd/vsdbabysoc/parasitics/`

---
## 📝 V. CONCLUSION & NEXT STEPS

Week 7 successfully implemented the complete physical design flow, generating a layout that meets all DRC constraints and possesses the necessary parasitic information for sign-off. The design is now ready for the final timing validation phase.
