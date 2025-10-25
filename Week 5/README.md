
# 📌 Week 5 - Submission
## **OpenROAD Installation, Floorplan, and Placement**

This repository contains the deliverables for **Week 5**, which involves setting up the **OpenROAD Flow Scripts** environment and executing the **Floorplan** and **Placement** stages of the physical design flow.  
This task transitions from **SPICE-level design (Week 4)** to **backend implementation** using OpenROAD.


## OpenROAD

**OpenROAD** is an open-source, fully automated RTL-to-GDSII flow for digital IC design. It supports synthesis, floorplanning, placement, clock tree synthesis, routing, and final layout generation. OpenROAD enables rapid design iterations, making it ideal for academic research and industry prototyping.

---

## OpenROAD Installation Guide

### 📚 Contents
- Steps to Install OpenROAD and Run GUI
  1. Clone the OpenROAD Repository
  2. Run the Setup Script
  3. Build OpenROAD
  4. Verify Installation
  5. Run the OpenROAD Flow
  6. Launch the GUI
- ORFS Directory Structure and File Formats

---

### Steps to Install OpenROAD and Run GUI

#### 1. Clone the OpenROAD Repository
```bash
git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts
cd OpenROAD-flow-scripts
```
![Clone Repository](https://github.com/spatha0011/spatha_vsd-hdp/blob/main/Day14/Images/installation1.jpg)
✅ Repository cloned successfully.
#### 2. Run the Setup Script
```bash
sudo ./setup.sh
```
![Run Setup Script](https://github.com/spatha0011/spatha_vsd-hdp/blob/main/Day14/Images/installation2.jpg)
✅ Dependencies installed and environment prepared.

#### 3. Build OpenROAD
```bash
./build_openroad.sh --local
```
![Build OpenROAD](https://github.com/spatha0011/spatha_vsd-hdp/blob/main/Day14/Images/installation3.jpg)
✅ OpenROAD compiled locally and binaries created.
#### 4. Verify Installation
```bash
source ./env.sh
yosys -help
openroad -help
```
![Verify Installation 1](https://github.com/spatha0011/spatha_vsd-hdp/blob/main/Day14/Images/installation4.jpg)  
![Verify Installation 2](https://github.com/spatha0011/spatha_vsd-hdp/blob/main/Day14/Images/installation5.jpg)
✅ Installation verified — yosys and OpenROAD responding successfully.

#### 5. Run the OpenROAD Flow
```bash
cd flow
make
```
![Run Flow](https://github.com/spatha0011/spatha_vsd-hdp/blob/main/Day14/Images/installation6.jpg)
✅ Flow executed successfully — synthesis, placement, and floorplan complete.

#### 6. Launch the GUI
```bash
make gui_final
```
![Launch GUI](https://github.com/spatha0011/spatha_vsd-hdp/blob/main/Day14/Images/installation7.jpg)
✅ GUI launched successfully — core area and standard cells visible.

✅ Installation Complete! You can now explore the full RTL-to-GDSII flow using OpenROAD.

---

## ORFS Directory Structure and File Formats

```
OpenROAD-flow-scripts/
├── docker           -> Docker-based installation scripts
├── docs             -> Documentation for OpenROAD flow scripts
├── flow             -> Files related to running RTL-to-GDS flow
├── jenkins          -> Regression tests for each build update
├── tools            -> Required tools to run RTL-to-GDS flow
├── etc              -> Dependency installer scripts and helpers
├── setup_env.sh     -> Source this file to initialize OpenROAD environment
```

### Inside the `flow/` Directory
```
flow/
├── design           -> Built-in example designs across different technology nodes
├── makefile         -> Automated flow runs using makefile setup
├── platform         -> Technology libraries, LEF files, GDS, etc.
├── tutorials
├── util
├── scripts
```

---

## 📝 Short Summary of Execution

1. **Steps Followed:**  
   Cloned the [OpenROAD Flow Scripts repository](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts) and installed all necessary prerequisites as listed in the [Week 5 Reference Repo](https://github.com/spatha0011/spatha_vsd-hdp/blob/main/Day14/README.md).  
   Initialized the OpenROAD environment and ran the flow using the standard configuration, explicitly stopping the script after the **Placement** stage.

2. **Challenges Faced:**  
   Encountered issues with conflicting system packages during prerequisite installation.

3. **Resolution:**  
   Resolved the issue by using a specific version of the setup script provided in the referenced repository that handled dependency management more robustly.

---

## 📚 References

- [OpenROAD Week 5 Reference Repository – spatha_vsd-hdp (Day 14)](https://github.com/spatha0011/spatha_vsd-hdp/blob/main/Day14/README.md)  

> This guide was followed for step-by-step flow execution, environment setup, and verification for the **Floorplan and Placement** stages.
