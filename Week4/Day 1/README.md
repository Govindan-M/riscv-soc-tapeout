# Day 1 - Circuit Design & SPICE Simulations

## 📘 Overview

**Circuit Design** is the process of connecting **logic gates** in specific configurations to achieve desired digital behavior — for example, creating an **inverter** using CMOS transistors.

## 🧩 Logic Gate Design

- Logic gates like **AND, OR, NOT, NAND, NOR, XOR** are building blocks.
- An **inverter** (NOT gate) is a key CMOS circuit combining NMOS and PMOS transistors.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/01.jpeg" width="600"/>

## 🧪 SPICE Simulations

**SPICE (Simulation Program with Integrated Circuit Emphasis)** is used to simulate electrical behavior before fabrication.

### 🔍 Main Uses

- Measure **delay**, **power**, and **voltage transfer** characteristics.
- Analyze **noise margins** and **device behavior**.
- Verify design before layout and manufacturing.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/02.jpeg" width="600"/>

## ⏱️ Delay & Power Models

| Model | Description |
| --- | --- |
| **4-Delay Table** | Delay values for different input and load conditions |
| **Power Models** | Estimate dynamic and static power |
| **Delay Models** | Approximate gate propagation delay |
| **Static Timing Analysis (STA)** | Checks timing paths without running full simulation |
| **Accurate Models** | Used for precise verification in post-layout simulations |

---

## ⚡ NMOS (n-Channel MOSFET)

### 🧠 Device Overview

An **NMOS transistor** is a four-terminal device that operates with **electrons** as charge carriers.

It’s fabricated on a **p-type substrate** with **two n⁺ diffusion regions** serving as **Source (S)** and **Drain (D)**.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/03.jpeg" width="600"/>

### 🧩 Step-by-Step Fabrication Process

### **Step 1: 4-Terminal Device**

- The NMOS transistor is a **4-terminal device**.
- It consists of:
    - **P-type substrate**
    - **Source**
    - **Drain**
    - **Gate**
    - **Body (Substrate terminal)**

### **Step 2: Isolation Regions**

- Two **isolation regions** made of **Silicon Dioxide (SiO₂)** are formed to separate each transistor and prevent leakage.

### **Step 3: N⁺ Diffusion Regions**

- Two heavily doped **n⁺ regions** are created on the p-substrate — one acts as **Source**, the other as **Drain**.

### **Step 4: Gate Oxide Formation**

- A **thin layer of silicon dioxide (SiO₂)** is grown between the two n⁺ regions.
- This layer serves as the **gate oxide**.

### **Step 5: Gate Deposition**

- Over the gate oxide, a **Polysilicon (Poly-Si)** or **Metal Gate** layer is deposited.
- This forms the **Gate terminal**.

### **Step 6: Terminal Identification**

| Terminal | Symbol | Description |
| --- | --- | --- |
| **Gate** | G | Controls channel formation |
| **Source** | S | Entry terminal for electrons |
| **Drain** | D | Exit terminal for electrons |
| **Body (Substrate)** | B | P-type substrate, usually connected to ground |

## Threshold Voltage (Vth)

The **Threshold Voltage** is the minimum gate-to-source voltage (VGSV_{GS}VGS) required for the transistor to start conducting.

VGS>Vth ⇒ NMOS is ON

VGS<Vth ⇒ NMOS is OFF

## 🔍 Device Operation and Threshold Voltage

### ⚙️ Initial Condition

- VGS=0V
- Drain, Source, and Body connected to **GND**

### 🔋 Behavior:

- Source–Body and Drain–Body form **PN junction diodes**.
- Both diodes are **reverse biased** → NMOS is **OFF**.
- Hence, **Source–Drain resistance is high**.

# ⚙️ Applying Gate-to-Source Voltage (Vgs = +ve)

When a voltage is applied to the gate, the **electric field** through the oxide affects the **substrate charge distribution**. The behavior of the NMOS depends on the magnitude of Vgs.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/04.jpeg" width="600"/>

---

### 1️⃣ Vgs = 0 V

- Gate, oxide, and substrate form a **capacitor**.
- P-substrate is filled with **holes** (majority carriers).
- **No channel exists → NMOS is OFF.**

---

### 2️⃣ Small Positive Vgs (Accumulation)

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/07.jpeg" width="600"/>

- Gate becomes slightly **positive**.
- Holes are **repelled** from the oxide interface.
- Positive ions remain, forming a **depletion region**.
- **Channel is still not conductive.**

---

### 3️⃣ Moderate Vgs (Depletion Region Increases)

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/05.jpeg" width="600"/>

- Depletion width **increases** as the electric field strengthens.
- The substrate surface potential becomes more **negative**.
- **Still no conduction** between Source and Drain.

---

### 4️⃣ Higher Vgs → Channel Formation (Strong Inversion)

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/06.jpeg" width="600"/>

- The semiconductor surface **inverts to n-type material**, forming a conductive channel.
- This phenomenon is called **“strong inversion”**.
- If Vgs = 0, strong inversion occurs at Vgs = Vt0.
- **Electrons** from the Source are attracted beneath the gate, forming a **thin n-type channel**.
- NMOS now **conducts from Source → Drain**.

## 🧮 Applying Gate-to-Source Voltage – Body Effect

When the gate-to-source voltage is increased further, it influences the **threshold voltage** Vt and channel formation:

- Further increase in Vgs is required.
- No repulsion of carriers occurs; **depletion layer width does not change**.
- Electrons from the heavily doped **n⁺ Source** are drawn under the gate.
- A continuous **n-type channel** forms from Source → Drain, **modulated by Vgs**.

### 🔸 Effect

- Increasing Vgs increases the depletion width.
- More gate voltage is required to achieve inversion → Vt increases.

### 🔹 Observation

- Increasing Vgs attracts more positive charge through the oxide.
- Some channel charges are **pulled toward the Source**.
- Inversion occurs at a slightly **higher voltage**:
    
                                                           Vgs =Vt0+V1
    
- The semiconductor surface inverts to n-type **only when the gate voltage surpasses this corrected threshold**.

# ⚡ Two Scenarios: Effect of Source-Body Bias (Vsb)

The **threshold voltage** and channel formation of an NMOS are influenced by the **source-to-body voltage (Vsb)**. There are **two key scenarios**:

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/08.jpeg" width="600"/>

---

### 1️⃣ Vsb = 0

- No additional bias between source and body.
- The **depletion layer width** remains standard.
- Strong inversion occurs when **Vgs = Vt0**.
- Channel forms normally from Source → Drain.
- NMOS conducts as expected with no extra voltage needed.

---

### 2️⃣ Vsb = +ve Value

- Positive bias between Source and Body creates **additional reverse-bias** across the PN junction.
- This **increases the depletion layer width** slightly.
- More gate voltage (Vgs) is required to achieve strong inversion.
- Corrected threshold voltage:

Vt=Vt0+γ(2ϕF+Vsb−2ϕF)Vt = Vt0 + \gamma \left( \sqrt{2\phi_F + Vsb} - \sqrt{2\phi_F} \right)

Vt=Vt0+γ(2ϕF+Vsb

−2ϕF

)

- NMOS requires slightly higher Vgs for conduction due to the **body effect**.
- The channel still forms from Source → Drain, but **threshold shifts**.

---

### Formula Explanation

- **Vt**: Threshold voltage with source-to-body bias applied; the gate voltage required to form a strong inversion layer.
- **Vt0**: Threshold voltage at Vsb = 0; base threshold voltage without substrate bias.
- **γ (gamma)**: Body-effect coefficient, quantifies how Vt changes with Vsb:

γ=2qεsiNACox\gamma = \frac{\sqrt{2 q \varepsilon_{si} N_A}}{C_{ox}}

γ=Cox2qεsiNA

Where:

- **q** = electronic charge (1.6×10−191.6 \times 10^{-19}1.6×10−19 C)
- **ε_si** = permittivity of silicon
- **N_A** = acceptor doping concentration of p-type substrate
- **Cox** = gate oxide capacitance per unit area, Cox=εox/toxCox = \varepsilon_{ox} / t_{ox}Cox=εox/tox
- **φF (Fermi potential)**: Energy difference between intrinsic Fermi level and doped substrate Fermi level:

ϕF=kTqln⁡NAni\phi_F = \frac{kT}{q} \ln{\frac{N_A}{n_i}}

ϕF=qkTlnniNA

Where:

- **k** = Boltzmann constant (1.38×10−231.38 \times 10^{-23}1.38×10−23 J/K)
- **T** = absolute temperature (K)
- **n_i** = intrinsic carrier concentration of silicon (~1.5×10101.5 \times 10^{10}1.5×1010 cm⁻³ at 300K)
- **Vsb**: Source-to-body voltage; a positive value creates a **reverse-biased junction**, increasing the depletion layer width and requiring **higher Vgs** to invert the channel.

---

### Key Points

- Vt0 is the base threshold without any substrate bias.
- The term 2ϕF+Vsb−2ϕF\sqrt{2\phi_F + Vsb} - \sqrt{2\phi_F}2ϕF+Vsb−2ϕF accounts for the **extra voltage needed** to overcome additional depletion caused by Vsb.
- γ scales this effect depending on the **doping concentration** and **oxide capacitance**.
- Overall, **threshold voltage increases with increasing Vsb**, meaning the NMOS needs a higher Vgs to turn on.

# Resistive Operation and MOSFET Current

## 1️⃣ Resistive Operation (Vgs = Vt)

When **Vgs = Vt**, the MOSFET is at the **edge of strong inversion**. At any point along the channel, the **induced charge** is given by:

Qi(x)=−Cox[(Vgs−Vt)−V(x)]Q_i(x) = -C_{ox} \left[ (Vgs - Vt) - V(x) \right]

Qi(x)=−Cox[(Vgs−Vt)−V(x)]

Where:

- Qi(x)Q_i(x)Qi(x) is the channel charge at position xxx from the source.
- V(x)V(x)V(x) is the voltage at point xxx along the channel.
- CoxC_{ox}Cox is the gate oxide capacitance per unit area.

---

## 2️⃣ Drain Current Derivation

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/09.jpeg" width="600"/>

The **drain current** is primarily due to **drift current**, with a small contribution from **diffusion current**:

ID=μnWQi(x)dV(x)dxI_D = \mu_n W Q_i(x) \frac{dV(x)}{dx}

ID=μnWQi(x)dxdV(x)

Substitute Qi(x)Q_i(x)Qi(x) to get:

ID=μnCoxWL[(Vgs−Vt)VDS−VDS22]I_D = \mu_n C_{ox} \frac{W}{L} \left[ (Vgs - Vt)V_{DS} - \frac{V_{DS}^2}{2} \right]

ID=μnCoxLW[(Vgs−Vt)VDS−2VDS2]

Where:

- μn\mu_nμn = electron mobility
- WWW = channel width
- LLL = channel length
- VDSV_{DS}VDS = drain-to-source voltage

---

## 3️⃣ MOSFET Operating Regions

### (a) Cutoff Region

Vgs<Vt⇒ID=0Vgs < Vt \quad \Rightarrow \quad I_D = 0

Vgs<Vt⇒ID=0

### (b) Linear (Triode) Region

VDS<Vgs−VtV_{DS} < Vgs - Vt

VDS<Vgs−Vt

ID=μnCoxWL[(Vgs−Vt)VDS−VDS22]I_D = \mu_n C_{ox} \frac{W}{L} \left[ (Vgs - Vt)V_{DS} - \frac{V_{DS}^2}{2} \right]

ID=μnCoxLW[(Vgs−Vt)VDS−2VDS2]

### (c) Saturation Region

VDS≥Vgs−VtV_{DS} \ge Vgs - Vt

VDS≥Vgs−Vt

ID=12μnCoxWL(Vgs−Vt)2I_D = \frac{1}{2} \mu_n C_{ox} \frac{W}{L} (Vgs - Vt)^2

ID=21μnCoxLW(Vgs−Vt)2

---

## 4️⃣ Channel-Length Modulation

In reality, the current **slightly increases with VDSV_{DS}VDS** even in saturation due to **effective channel shortening**:

ID=12μnCoxWL(Vgs−Vt)2(1+λVDS)I_D = \frac{1}{2} \mu_n C_{ox} \frac{W}{L} (Vgs - Vt)^2 \left( 1 + \lambda V_{DS} \right)

ID=21μnCoxLW(Vgs−Vt)2(1+λVDS)

Where:

- λ\lambdaλ = channel-length modulation parameter (~0.01–0.05 V⁻¹)

---

## 5️⃣ Key Parameters

- CoxC_{ox}Cox = gate oxide capacitance
- toxt_{ox}tox = oxide thickness
- γ\gammaγ = body effect coefficient = 2qεsiNACox\frac{\sqrt{2 q \varepsilon_{si} N_A}}{C_{ox}}Cox2qεsiNA
- ϕF\phi_FϕF = Fermi potential = kTqln⁡NAni\frac{kT}{q} \ln \frac{N_A}{n_i}qkTlnniNA
- Kn′K_n'Kn′ = process transconductance = μnCox\mu_n C_{ox}μnCox
- KnK_nKn = device transconductance = Kn′WLK_n' \frac{W}{L}Kn′LW

---

## 6️⃣ Pinch-Off & Saturation

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/10.jpeg" width="600"/>

- When VDS=Vgs−VtV_{DS} = Vgs - VtVDS=Vgs−Vt, the channel near the **drain is pinched off**.
- Further increase in VDSV_{DS}VDS does **not affect the channel charge near the source**, so the current **saturates**.

---

## 7️⃣ Typical SPICE Simulation

- **Vgs** = 1 V, 1.5 V, 2 V …
- **VDS** = 0 → 2 V sweep
- Observe the **linear → saturation transition** in the output characteristics.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/11.jpeg" width="600"/>

# Introduction to SPICE

## 1️⃣ What is SPICE?

SPICE (**Simulation Program with Integrated Circuit Emphasis**) is a **widely used electronic circuit simulator**. It allows engineers and students to **analyze analog and digital circuits** before fabrication.

Key features:

- Simulates **DC, AC, transient, noise, and temperature behavior** of circuits.
- Uses a **netlist** description of the circuit (nodes, devices, and connections).
- Supports **MOSFET, BJT, diode, resistor, capacitor, inductor, and voltage/current sources**.

---

## 2️⃣ SPICE Setup

A typical SPICE workflow involves:

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/12.jpeg" width="600"/>

1. **Define the circuit**: Create a schematic or netlist with nodes, elements, and connections.
2. **Select devices**: Include MOSFETs, BJTs, resistors, capacitors, etc.
3. **Assign models**: Specify **technology parameters** for each device using **model files**.
4. **Run simulation**: Perform **DC, AC, transient, or parametric analysis**.
5. **Analyze results**: Examine **voltages, currents, power, gain, frequency response**, and other characteristics.

---

## 3️⃣ Five Important Formulas Used in SPICE

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/15.jpeg" width="600"/>

1. **Threshold Voltage** (including body effect)

Vt=Vt0+γ(2ϕF+VSB−2ϕF)V_t = V_{t0} + \gamma \left( \sqrt{2\phi_F + V_{SB}} - \sqrt{2\phi_F} \right)

Vt=Vt0+γ(2ϕF+VSB

−2ϕF

)

1. **Body Effect Coefficient (γ)**

γ=2qεsiNACox\gamma = \frac{\sqrt{2 q \varepsilon_{si} N_A}}{C_{ox}}

γ=Cox2qεsiNA

1. **Fermi Potential (φF)**

ϕF=kTqln⁡NAni\phi_F = \frac{kT}{q} \ln \frac{N_A}{n_i}

ϕF=qkTlnniNA

1. **Linear (Triode) Region Drain Current**

ID=Kn[(VGS−Vt)VDS−VDS22]I_D = K_n \left[ (V_{GS} - V_t)V_{DS} - \frac{V_{DS}^2}{2} \right]

ID=Kn[(VGS−Vt)VDS−2VDS2]

1. **Saturation Region Drain Current**

ID=12Kn(VGS−Vt)2(1+λVDS)I_D = \frac{1}{2} K_n (V_{GS} - V_t)^2 (1 + \lambda V_{DS})

ID=21Kn(VGS−Vt)2(1+λVDS)

Where:

- Kn′Kn'Kn′ = process transconductance (Kn' = μn Cox)
- Kn=Kn′WLKn = Kn' \frac{W}{L}Kn=Kn′LW = device transconductance
- λ\lambdaλ = channel-length modulation parameter (~0.01–0.05 V⁻¹)

---

## 4️⃣ Technology Parameters in SPICE Models

SPICE MOSFET models require **technology constants**, for example:

- **Vto (Vt0)** → Zero-bias threshold voltage
- **Gamma (γ)** → Body-effect coefficient
- **Kn'** → Process transconductance (μn Cox)
- **Kn** → Device transconductance (Kn' W/L)
- **Lambda (λ)** → Channel-length modulation factor

These parameters are defined in a **technology file** or **model file** associated with the process.

---

## 5️⃣ Technology File & Netlist Description

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/13.jpeg" width="600"/>

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/14.jpeg" width="600"/>

### ***NETLIST Description***

```
M1 vdd nl 0 0 nmos W=1.8u L=1.2u
```

- **M1** → Instance name of the MOSFET.
- **vdd, nl, 0, 0** → Nodes connected to **Drain, Gate, Source, Body** respectively.
    - `vdd` = Drain node
    - `nl` = Gate node
    - `0` = Source node (connected to ground)
    - `0` = Body/Substrate node (also connected to ground)
- **nmos** → Refers to the MOSFET model name defined in the `.LIB` or `.MODEL` file.
- **W=1.8u L=1.2u** → Width (1.8 µm) and Length (1.2 µm) of the MOSFET channel.

---

```
R1 in nl 55
```

- **R1** → Instance name of the resistor.
- **in, nl** → Nodes connected to resistor terminals (input to gate node).
- **55** → Resistance value in Ohms (55 Ω).

---

```
Vdd vdd 0 2.5
```

- **Vdd** → Instance name of the voltage source.
- **vdd, 0** → Positive and negative nodes of the voltage source.
    - `vdd` = positive terminal
    - `0` = negative terminal (ground)
- **2.5** → Voltage value in volts. Supplies power to the MOSFET drain.

---

```
Vin in 0 2.5
```

- **Vin** → Instance name of input voltage source.
- **in, 0** → Nodes connected to input.
    - `in` = gate of the MOSFET
    - `0` = ground reference
- **2.5** → Input voltage applied to the gate.

---

```
*** .include xxxx lum model.mod ***
```

- This is a **comment line** (***). SPICE ignores it.
- Indicates that you can include an **external model file** for device parameters: `xxxx lum model.mod`.
- Helps SPICE know the **MOSFET physical and electrical properties** (Vto, gamma, Kn’, lambda, etc.).

---

```
.LIB "xxxx 025um model.mod" CMOS MODELS
```

- **.LIB** → SPICE directive to include a **library of models**.
- `"xxxx 025um model.mod"` → Filename containing NMOS/PMOS models for a **0.25 µm CMOS technology**.
- **CMOS MODELS** → Comment describing the content of the library.
# NGSPICE Simulation: NMOS IV Characteristics

### **Step 1: Open Terminal**

Open your terminal in Linux/macOS or Git Bash in Windows.

---

### **Step 2: Navigate to Working Directory**

```bash
cd 
```

Browse your home or desired directory to store project files.

---

### **Step 3: Clone GitHub Repository**

```bash
git clone https://github.com/kunalg123/sky130CircuitDesignWorkshop.git
```

- This downloads the **Sky130 Circuit Design Workshop** repository.

---

### **Step 4: Enter Design Directory**

```bash
cd sky130CircuitDesignWorkshop/design/
ls
cd sky130_fd_pr/
```

- Lists the contents and navigates to the **physical design project folder**.

---

### **Step 5: Explore Cells**

```bash
cd cells/nfet_01v8
```

- Navigate to the NMOS transistor cell (`nfet_01v8`).
- View the transistor model parameters:

```bash
less sky130_fd_pr__nfet_01v8__tt.pm3.spice
```

> Contains NMOS transistor parameters for typical corner (tt).
> 

```bash
less sky130_fd_pr__nfet_01v8__tt.corner.spice
```

> Contains different W & L values for NMOS in various corners.
> 

---

### **Step 6: Explore Model Library**

```bash
cd ../../models/
less sky130.lib.spice
```

> This file contains all NMOS and PMOS models for different process corners.
> 

---

### **Step 7: Edit NMOS IV Simulation Netlist**

```bash
vim day1_nfet_idvds_L025_W065.spice
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/16.png" width="600"/>

- Here you can **define the NMOS instance, nodes, and simulation commands**.

---

### **Step 8: Run NGSPICE**

```bash
ngspice
```

- Opens the NGSPICE interactive console.

---

### **Step 9: Load Your Netlist**

In NGSPICE terminal:

```
ngspice day1_nfet_idvds_L2_W5.spice
```

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/17.png" width="600"/>

- Loads your netlist for simulation.

---

### **Step 10: Plot IV Characteristics**

```
plot -vdd#branch
```

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/18.png" width="600"/>

- Plots the **drain current vs. drain voltage**.
- The `#branch` shows the current through the voltage source Vdd (typical way to observe ID).

---

### **Step 11: Analyze Waveforms**

- Observe **linear region, saturation region, and pinch-off** behavior.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%201/Images/19.png" width="600"/>

- Compare the effects of **different W/L, corners, and model parameters** on NMOS IV curves.

---

✅ **Notes:**

- `less` → View file content without editing.
- `vim` → Edit netlist to change NMOS parameters or add simulation commands.
- NGSPICE interprets **.lib** files and corner spice models for accurate transistor behavior.
