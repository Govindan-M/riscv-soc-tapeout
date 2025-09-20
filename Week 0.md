# 📌 Week 0 - Submission



## **Task 1 - Getting started with Digital VLSI SoC Design and Planning**
For the complete step-by-step flow from application testing to tapeout 


### **Step 1 - Test the Application**
- Verify target application requirements.  
- Establish functionality and performance goals.  
- **Tools:** Basic compilers, C/C++ simulators  
- **Outcome 0:** Validated application code with requirements.

---

### **Step 2 - Specifications → C Model**
- Build a C model that captures the specification and acts as the *golden reference* for verification.  
- **Outcome 1:** Working C model proving the design intent.

---

### **Step 3 - RTL Architecture (Verilog)**
- Translate the C model into RTL (Verilog '**Soft Copy**').  
- Partition design into:
  - Processor (gate-level netlist)
  - Peripherals (IP blocks, analog macros)
- **Tools:** Icarus Verilog (simulation), GTKWave (waveform viewing)  
- **Outcome 2:** RTL design ready for synthesis & simulation.

---

### **Step 4 - GPIO & SoC Integration**
- Integrate GPIO and other peripherals into the SoC.  
- Verify integration using testbenches and regression simulation.  
- **Tools:** Icarus Verilog, GTKWave  
- **Outcome 3:** Fully functional SoC integration.

---

### **Step 5 - RTL → GDSII (Physical Design)**
- Physical design stages:
  - Floorplanning
  - Placement
  - Clock Tree Synthesis (CTS)
  - Routing
  - Timing closure
- **Tools:**
  - Yosys → logic synthesis
  - OpenSTA → static timing analysis
  - OpenLane → RTL → GDSII flow
  - Magic → layout editing, DRC/LVS  
- **Outcome:** Netlist and layout mapped to technology library; ready for sign-off.

---

### **Step 6 - GDSII File & Sign-off**
- Generate GDSII file and run signoff:
  - DRC (Design Rule Check)
  - LVS (Layout vs Schematic)
- Send GDSII to foundry for tape-out.
- **Tools:** Magic (DRC/LVS), Ngspice (analog/Spice simulations)  
- **Outcome:** Chip ready for fabrication (tape-in).

---

### **Step 7 - Peripheral Setup with Fabricated Chip**
- Connect and configure external peripherals with the fabricated chip.
- Validate chip behavior on real hardware.
- **Outcome 4:** Verified Chip with peripheral integration.

---

### **Step 8 - Real-World Applications**
The fabricated chip can be used in:
- iWatch & wearables
- Arduino boards & embedded controllers
- TV panels & consumer electronics
- AC & other home appliances

---

## ✅ Important Notes  

✨ All **5 Outcomes (O0, O1, O2, O3, O4)** must produce **functionally equivalent** results across stages.  

⚡ Target working frequency: **100 MHz – 130 MHz**  

⏳ Estimated timeline (Steps 1–7): **14 months**  

🚀 Stay consistent, stay positive, and keep building towards **tape-out success!**


## 🛠️**Task 2 - Tools Installation Instructions**

- In this task, we focus on setting up the **essential open-source tools** required for Digital VLSI SoC design and verification.  
- These tools will be the foundation for the upcoming design flow, from RTL to GDSII.  

### 💻 System Check  
Before installing, confirm that your system meets the following minimum requirements:  
- ✅ 6 GB RAM  
- ✅ 50 GB HDD  
- ✅ Ubuntu 20.04+  
- ✅ 4 vCPU  

---

## 📋 Tools Installation Status

- The tools were installed following the documented steps. 
- Screenshots have been added to validate installation, ensuring each component is ready for use in the design flow.

#### ✅ Yosys – Logic Synthesis Tool  
**Purpose**: Converts RTL (Verilog) into a gate-level netlist for synthesis.  
```bash
$ sudo apt-get update  
$ git clone https://github.com/YosysHQ/yosys.git  
$ cd yosys  
$ sudo apt install make  
$ sudo apt-get install build-essential clang bison flex \
libreadline-dev gawk tcl-dev libffi-dev git \
graphviz xdot pkg-config python3 libboost-system-dev \
libboost-python-dev libboost-filesystem-dev zlib1g-dev  
$ make config-gcc  
$ make  
$ sudo make install  

```

<div align="center">✅ Yosys Successfully Installed</div>

#### ✅ Icarus Verilog – RTL Simulation
**Purpose**: Compiles and simulates Verilog code at the RTL stage.

```bash
$ sudo apt-get update  
$ sudo apt-get install iverilog  
```
<div align="center">✅ Icarus Verilog Successfully Installed</div>

#### ✅ GTKWave – Waveform Viewer

**Purpose**: Visualizes simulation output (VCD/FSDB) for debugging signals.

```bash
$ sudo apt-get update  
$ sudo apt install gtkwave  
```

<div align="center">✅ GTKWave Successfully Installed</div>

#### ⚡ OpenSTA - Static Timing Analysis (Optional, Not required for SFAL participants)

**Purpose**: Performs timing verification for digital circuits.  
🔗 [OpenSTA GitHub Repo](https://github.com/The-OpenROAD-Project/OpenSTA)  

#### ✅ Ngspice – Circuit-Level Simulation (Optional)

**Purpose**: Analog/mixed-signal circuit simulation.  

```bash
$ tar -zxvf ngspice-37.tar.gz
$ cd ngspice-37
$ mkdir release && cd release
$ ../configure --with-x --with-readline=yes --disable-debug
$ make
$ sudo make install
```
<div align="center">✅ Ngspice Successfully Installed</div>

#### ✅ Magic – VLSI Layout Tool


**Purpose:** Used for IC layout, design rule checking (DRC), and extraction.


```bash
$ sudo apt-get install m4 tcsh csh libx11-dev tcl-dev tk-dev libcairo2-dev \
mesa-common-dev libglu1-mesa-dev libncurses-dev
$ git clone https://github.com/RTimothyEdwards/magic
$ cd magic
$ ./configure
$ make
$ sudo make install
```
<div align="center">✅ Magic Successfully Installed</div>

#### ✅ OpenLANE – End-to-End Physical Design Flow (with Docker)

**Purpose:** Provides automated RTL-to-GDSII flow using OpenROAD tools & Sky130 PDK.


#### **System Update**
```bash
sudo apt-get update
sudo apt-get upgrade
```


#### **Install Core Dependencies**
```bash
sudo apt install -y build-essential python3 python3-venv python3-pip make git
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```
#### **Docker Setup**
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
```
#### **Docker User Setup & Reboot**
```bash
sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot

#After Reboot Verification

docker run hello-world
```

<div align="center">
✅ Docker is installed and running successfully!
</div>


#### **Check Dependencies**
```bash
git --version
docker --version
python3 --version
python3 -m pip --version
make --version
python3 -m venv -h
```
<div align="center">
✅ Version Check Completed
</div>


#### **Clone & Build OpenLane**
```bash
cd $HOME
git clone https://github.com/The-OpenROAD-Project/OpenLane
cd OpenLane
make
make test
```
<div align="center">✅ OpenLANE Successfully Installed</div>

## 📝 Submission Overview

This repository serves as the official **Week 0 submission** for the Digital VLSI SoC Design program.

### Task 1 – Getting started with Digital VLSI SoC Design and Planning
- Step-by-step flow from application testing to tapeout
- Outcomes from C model → RTL → SoC integration → Fabricated chip

### Task 2 – Tools Installation Instructions
- Installation of essential open-source tools:  
  Yosys, Icarus Verilog, GTKWave, Magic, OpenLANE, Ngspice, OpenSTA
- Screenshots and ✅ Successfully Installed confirmations


### 🔗 Links

- **Week 0 Repo:** [Add your Week 0 repo link here]()  
- **Main Repo:** [https://github.com/Govindan-M/riscv-soc-tapeout.git]()
