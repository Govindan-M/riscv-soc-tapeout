# Day 2: MOSFET Characteristics and CMOS Voltage Transfer Analysis

## ⚙️ Two Channel Variations

1. **Long Channel MOSFET**
2. **Short Channel MOSFET**

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/02.png" width="600"/>

These differ mainly due to **scaling effects** and **carrier velocity behavior** inside the channel.

---

## Drain Current Model (Long Channel)

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/01.png" width="600"/>

For the **saturation region**:

<p align="center">
    $$I_D = \mu_n C_{ox} \frac{W}{2L} (V_{GS} - V_{TH})^2$$
</p>

➡️ Shows **quadratic dependence** of ID on (VGS−VTH)

---

### Regions of Operation (Long Channel – 3 Regions)

**Cut-off Region:**

<p align="center">
    $$V_{GS} < V_{TH}$$
</p>
<p align="center">
    $$I_D = 0$$
</p>  
Behavior: No conduction

**Linear (Triode) Region:**

<p align="center">
    $$V_{DS} < V_{GS} - V_{TH}$$
</p>
<p align="center">
    $$I_D = \mu_n C_{ox} \frac{W}{L} \left[ (V_{GS} - V_{TH}) V_{DS} - \frac{V_{DS}^2}{2} \right]$$
</p>  
Behavior: Ohmic region

**Saturation Region:**

<p align="center">
    $$V_{DS} \ge V_{GS} - V_{TH}$$
</p>
<p align="center">
    $$I_D = \frac{1}{2} \mu_n C_{ox} \frac{W}{L} (V_{GS} - V_{TH})^2$$
</p>  
Behavior: Quadratic rise, constant current

---

## Short Channel Device (Quadratic → Linear Dependence)

### Characteristics

- Device length LLL is small (e.g., < 0.1 µm)
- High **electric field** in the channel
- **Velocity saturation** occurs; carrier velocity saturates at vsatv_{sat}vsat

---

### Velocity Saturation Effect

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/03.png" width="600"/>

When Echannel > Ecrit:

<p align="center">
    $$v = v_{sat}$$
</p>

Drain current becomes **linear** with VGS.

---

### Drain Current Model (Short Channel – Saturation)

<p align="center">
    $$I_D = W C_{ox} (V_{GS} - V_{TH}) v_{sat}$$
</p>

➡️ Shows linear dependence of ID on VGS−VTH.

---

### Regions of Operation (Short Channel – 4 Regions)

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/04.png" width="600"/>

**Cut-off Region:**

<p align="center">
    $$V_{GS} < V_{TH}$$
</p>
<p align="center">
    $$I_D = 0$$
</p>  
Behavior: Device OFF

**Linear Region:**

<p align="center">
    $$V_{DS} < V_{GS} - V_{TH}$$
</p>
<p align="center">
    $$I_D \propto V_{DS}$$
</p>  
Behavior: Ohmic (resistive)

**Saturation (before velocity saturation):**

<p align="center">
    $$V_{DS} = V_{GS} - V_{TH}$$
</p>
<p align="center">
    $$I_D \propto (V_{GS} - V_{TH})^2$$
</p>  
Behavior: Quadratic increase

**Velocity-Saturated Region:**



<p align="center">
    $$V_{DS} > V_{DS,sat}$$
</p>
<p align="center">
    $$I_D \propto (V_{GS} - V_{TH})$$
</p>  
Behavior: Linear increase with VGS

---

## Observation of ID vs VGS

**Long Channel:**

<p align="center">
    $$I_D \propto (V_{GS} - V_{TH})^2$$
</p>  
Graph: Parabolic, strong quadratic rise

**Short Channel:**

<p align="center">
    $$I_D \propto (V_{GS} - V_{TH})$$
</p>  
Graph: Linear after some point, due to velocity saturation

---

### 1️⃣ **Carrier Velocity**

- **Long Channel:** Velocity increases linearly with electric field. Proper formula:

<p align="center">
$$v \propto E$$
</p>

- **Short Channel:** Velocity saturates at vsatv_{sat}vsat. Proper formula:

<p align="center">
$$v = v_{sat}$$
</p>

---

### 2️⃣ **ID – VGS Relation**

- **Long Channel:** Quadratic dependence:

<p align="center">
$$I_D \propto (V_{GS} - V_{TH})^2$$
</p>

- **Short Channel:** Linear dependence (after velocity saturation):

<p align="center">
$$I_D \propto (V_{GS} - V_{TH})$$
</p>

---

### 3️⃣ **Regions of Operation**

- **Long Channel:** 3
- **Short Channel:** 4

---

### 4️⃣ **Dependence on L (Channel Length)**

- **Long Channel:** Inversely proportional to channel length:

<p align="center">
$$I_D \propto \frac{1}{L}$$
</p>

- **Short Channel:** Almost independent of L (velocity saturation dominates):

<p align="center">
$$I_D \text{ almost independent of } L$$
</p>

---

### 5️⃣ **Device Control**

- **Long Channel:** Voltage-controlled
- **Short Channel:** Partially field-controlled

## Peak Current Variation

- **Long Channel MOSFET:** Quadratic increase as VGS rises
- **Short Channel MOSFET:** Saturates early due to velocity saturation

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/05.png" width="600"/>

---

### **Lab 1: NGSpice Simulation – ID vs VDS**

**Objective:** To observe the drain current variation with drain-to-source voltage for an NMOS transistor.

**Procedure:**

1. Open the file using
    
    `vim day2_nfet_idvds_L015_w039.spice`
    
2. Run the simulation using
    
    `ngspice day2_nfet_idvds_L015_w039.spice`
    
3. Plot the graph using
    
    `plot -vdd#branch`

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/7a.png" width="600"/>

**Observation:**

- The curve shows **three regions of operation** for the MOSFET:
    1. **Cut-off region**
    2. **Linear (Triode) region**
    3. **Saturation region**
- For short-channel devices, velocity saturation modifies the current equation, leading to a transition from **quadratic to linear dependence** on VGS.

---

### **Lab 2: NGSpice Simulation – ID vs VGS**

**Objective:** To analyze the drain current variation with gate-to-source voltage.

**Procedure:**

1. Open the file using
    
    `vim day2_nfet_idvgs_L015_w039.spice`
    
2. Run the simulation using
    
    `ngspice day2_nfet_idvgs_L015_w039.spice`
    
3. Plot the graph using
    
    `plot -vdd#branch`

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/7b.png" width="600"/>

**Observation:**

- As VGS increases, IDI_DID increases nonlinearly and then saturates due to **velocity saturation**.
- The tangent slope near the threshold region moves toward the **x-axis**, with the **approximate threshold voltage ≈ 0.7 V**.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/6.png" width="600"/>

---

### **📗 CMOS Voltage Transfer Characteristics (VTC)**

**Definition:**

The CMOS Voltage Transfer Characteristic (VTC) describes the relationship between the **input voltage (Vin)** and **output voltage (Vout)** of a CMOS inverter. It is used to understand **switching behavior** and determine the **noise margins** of digital circuits.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/08.png" width="600"/>

---

### **Key Observations**

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/09.png" width="600"/>

1. **Input Low (Vin=0V)**
    - NMOS is **OFF**.
    - PMOS is **ON**.
    - Output Vout = VDD (logic HIGH).
2. **Input High (Vin=VDD)**
    - NMOS is **ON**.
    - PMOS is **OFF**.
    - Output Vout = 0V (logic LOW).
3. **Switching Point (Vm)**
    - The input voltage at which Vout=Vin
    - Defines the inverter’s **transition region**.
    - Determines the **noise margins**: NMH and NML.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/10.png" width="600"/>

---

### **Steps to Plot VTC**

### **Step 1: Convert PMOS Gate-Source Voltage to Vin**

- For PMOS, the gate voltage relative to source controls conduction.
- Express the PMOS VGS in terms of Vin.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/11.png" width="600"/>

### **Step 2: Convert NMOS Drain-Source Voltage to Vout**

- NMOS drain current depends on VDS = Vout and VGS=Vin.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/12.png" width="600"/>

### **Step 3: Convert PMOS Drain-Source Voltage to Vout**

- PMOS drain current depends on VSD= VDD−Vout and VSG=VDD−Vin.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/13.png" width="600"/>

### **Step 4: Merge NMOS and PMOS Load Curves**

- Plot ID vs Vout curves for both NMOS and PMOS.
- The intersection determines the output voltage for each input.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/14.png" width="600"/>

### **Step 5: Draw Vout vs Vin**

- Connect all points of intersection for varying Vin.
- The resulting curve is the **VTC**.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week4/Day%202/Images/15.png" width="600"/>

---

### **VTC Characteristics**

| Feature | Description |
| --- | --- |
| **Logic HIGH Output** | Vout=VDD when Vin is low |
| **Logic LOW Output** | Vout=0V when Vin is high |
| **Transition Region** | Middle portion of VTC, slope determines **switching speed** |
| **Noise Margins** | Determined by intersection points where slope = -1 |
| **Gain** | Maximum slope magnitude in transition region |

---

### **Graphical Behavior**

1. Vin low → Vout  high (PMOS ON, NMOS OFF)
2. Vin increasing → Vout starts falling as NMOS conducts
3. Vin= switching voltage VM →  Vout = Vin
4. Vin high → Vout low (NMOS ON, PMOS OFF)

---

### **Important Notes**

- **Slope of VTC** in the transition region affects **propagation delay**.
- **Threshold voltage** of NMOS and PMOS determines the **switching point**.
- **VTC curve** is essential for **digital circuit design**, noise analysis, and sizing of transistors.
