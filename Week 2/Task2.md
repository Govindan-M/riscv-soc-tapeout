# Task 2 – VSDBabySoC: Pre-Synthesis Simulation & Functional Validation

This experiment demonstrates the **pre-synthesis simulation** of the **VSDBabySoC** design using **Icarus Verilog** and waveform visualization via **GTKWave**. The primary goal is to verify **functional correctness** and ensure proper interaction between the submodules (RISC-V core, PLL, and DAC) before proceeding to synthesis.

---

## Objectives

- Convert TL-Verilog source files into synthesizable Verilog.
- Simulate the complete SoC system to verify clock, DAC, and reset activity.
- Observe digital-to-analog conversion waveform behavior in GTKWave.

---

## Project Directory Structure

```
VSDBabySoC/
├── src/
│   ├── include/
│   │   ├── sandpiper.vh
│   │   └── other headers
│   ├── module/
│   │   ├── vsdbabysoc.v      # Top module integrating CPU, PLL, DAC
│   │   ├── rvmyth.tlv        # RISC-V core source (TLV format)
│   │   ├── avsdpll.v         # PLL circuit generating clock signal
│   │   ├── avsddac.v         # DAC converting digital values to analog
│   │   └── testbench.v       # Simulation stimulus
└── output/
    └── pre_synth_sim/        # Output waveform & compiled simulation files
```

---

## Step 1: Clone the Repository

```bash
cd ~/VLSI
git clone https://github.com/manili/VSDBabySoC.git
cd VSDBabySoC
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%202/Images/gitclone-v.png" width="600"/>

---

## Step 2: Environment Setup & File Conversion

1. Install required packages and create a Python virtual environment:

```bash
sudo apt update
sudo apt install python3-venv python3-pip
python3 -m venv sp_env
source sp_env/bin/activate
pip install pyyaml click sandpiper-saas
```

2. Convert `rvmyth.tlv` to Verilog for simulation:

```bash
sandpiper-saas -i ./src/module/*.tlv -o rvmyth.v --bestsv --noline -p verilog --outdir ./src/module/
```
<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%202/Images/v-tlv%20files.png" width="600"/>  

3. Deactivate the virtual environment after conversion:

```bash
deactivate
```

---

## Step 3: Run Pre-Synthesis Simulation

1. Create output directory:

```bash
mkdir -p ~/VLSI/VSDBabySoC/output/pre_synth_sim
cd ~/VLSI/VSDBabySoC/src/module
```

2. Compile the simulation using Icarus Verilog:

```bash
iverilog -o ~/VLSI/VSDBabySoC/output/pre_synth_sim/pre_synth_sim.out \
-DPRE_SYNTH_SIM \
-I ~/VLSI/VSDBabySoC/src/include \
-I ~/VLSI/VSDBabySoC/src/module \
~/VLSI/VSDBabySoC/src/module/testbench.v
```

3. Run the simulation to generate the waveform:

```bash
vvp ~/VLSI/VSDBabySoC/output/pre_synth_sim/pre_synth_sim.out
```

> Ensure a .vcd file is generated in output/pre_synth_sim/.
> 

---

## Step 4: View Waveforms with GTKWave

```bash
gtkwave ~/VLSI/VSDBabySoC/output/pre_synth_sim/pre_synth_sim.vcd
```

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%202/Images/setup%20for%20waveform.png" width="600"/> 

### Key Signals to Observe

- `REF` – Reference clock input
- `CLK` / `OUT_CLK` – PLL output
- `reset` – Active-high reset input
- `RV_TO_DAC[9:0]` – 10-bit digital output from RVMYTH core
- `OUT` – DAC analog output
- `ENb_CP`, `ENb_VCO` – Control enable signals


<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%202/Images/pre_synth_sim%20output.png" width="600"/> 

---

## Step 5: Viewing Analog Output

1. Right-click on the `OUT` signal in GTKWave.
2. Select **Data Format → Analog → Step**.
3. This converts the signal into a smooth analog-like waveform, showing voltage variations versus digital input codes.

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%202/Images/digital%20output.png" width="600"/>


<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%202/Images/analog%20output.png" width="600"/> 

---

## Observations

- `REF` remains stable, confirming a consistent clock input.
- `ENb_CP` and `ENb_VCO` toggle correctly, showing proper control activity.
- `RV_TO_DAC[9:0]` varies as expected, confirming CPU-driven digital input to the DAC.
- `OUT` rises and falls proportionally, demonstrating correct digital-to-analog conversion.
- Low `reset` indicates normal SoC operation.
- DAC output shows a linear relationship between 10-bit digital input and analog output.
- PLL output frequency responds dynamically to changes in `REF`, validating locked clock generation.

---

## Conclusion

The pre-synthesis simulation successfully validates **functional modeling** of the VSDBabySoC. The **RISC-V core**, **PLL**, and **DAC** operate in sync, producing consistent analog outputs based on digital input patterns. These results confirm functional stability and **readiness for synthesis**.
