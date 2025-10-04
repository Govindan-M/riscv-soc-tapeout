# Task 1 – BabySoC Fundamentals & Functional Modelling

## 📝 System-on-Chip (SoC) Overview

A **System-on-Chip (SoC)** integrates all essential electronic components into a single chip. Compared to multi-chip designs, SoCs offer:

- **Enhanced performance** – reduced latency via on-chip integration.
- **Lower power consumption** – optimized interconnects and power domains.
- **Compact form factor** – ideal for mobile, embedded, and IoT devices.

SoCs are used in **smartphones, tablets, IoT modules, edge devices, and embedded systems**.

---

## 🧩 Key Components of a Typical SoC

### Central Processing Unit (CPU)

- Acts as the **brain** of the system.
- Executes instructions, performs calculations, and controls data flow.
- Can be **single-core or multi-core** for parallel processing.

### Memory

- **RAM**: temporary storage for fast access.
    - **SRAM** – very fast, used for cache/registers.
    - **DRAM** – slower, cheaper, used as main memory.
- **ROM**: stores firmware and boot code.
- **Flash Memory**: non-volatile storage for programs and data.

### Peripherals

- Specialized hardware blocks for tasks such as:
    - **GPU** – graphics acceleration
    - **DSP** – signal processing
    - **Timers & Clocks** – synchronization
    - **I/O Interfaces** – USB, SPI, I²C, Ethernet, Wi-Fi, Bluetooth

### Interconnect

- Communication backbone for CPU, memory, and peripherals.
- Architectures:
    - **Bus-based** (AMBA, Wishbone)
    - **Network-on-Chip (NoC)** – scalable routing for complex SoCs

---

## ⚡ BabySoC: An Educational SoC Model

**BabySoC** is a simplified, open-source SoC built on the **RVMYTH RISC-V processor core**, designed for learning SoC fundamentals.

### Architecture Highlights

<img src="https://github.com/Govindan-M/riscv-soc-tapeout/blob/main/Week%202/Images/vsdbabysoc_block_diagram.png" width="600"/>

- **RVMYTH CPU Core** – executes instructions and simple programs
- **Phase-Locked Loop (PLL)** – stable, high-frequency system clock
- **10-bit DAC** – digital-to-analog conversion for external devices (e.g., speakers, displays)
- **Memory & I/O** – communication with peripherals and external modules

📌 Provides a **minimal, hands-on platform** to learn CPU-memory-peripheral integration without complex commercial SoC designs.

---

## ✅ Why BabySoC is Useful for Learning

- **Reduces complexity** – avoids million-transistor commercial designs
- **Focuses on fundamentals** – CPU-peripheral communication, memory, interconnects
- **Hands-on exposure** – integrates IP cores, runs drivers, tests functionality
- **Architectural insight** – demonstrates real-world system integration in a simplified model

---

## 🛠️ Functional Modeling in SoC Design

Functional modelling is done **before RTL and physical design**, to verify system behavior and guide implementation.

### Roles of Functional Models

- **Exploration & Specification** – high-level behavior in C/C++/SystemC; tests architectures and power-performance trade-offs
- **Verification** – ensures logical correctness early; catches software/hardware bugs cheaply
- **Bridge to Implementation** – serves as a **golden reference** for RTL and physical design
- **System-level Co-Design** – enables hardware-software co-development for performance-critical SoCs
