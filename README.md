# Hardware-Accelerated KNN Classifier on FPGA 🚀
![Verilog](https://img.shields.io/badge/Language-Verilog-blue)
![FPGA](https://img.shields.io/badge/Platform-Zynq--7000-green)
![Vivado](https://img.shields.io/badge/Tool-Vivado-orange)
![Board](https://img.shields.io/badge/Board-ZedBoard-red)
![Clock](https://img.shields.io/badge/Clock-100MHz-purple)
![Award](https://img.shields.io/badge/Award-1st%20Place-gold)

A real-time, hardware-accelerated **K-Nearest Neighbour (KNN)** classification engine implemented entirely in **Verilog HDL** on the **Xilinx ZedBoard (Zynq-7000 SoC)**.

This project computes Manhattan distances in hardware, maintains the K nearest neighbours using sequential insertion logic, and classifies input data deterministically using a fully RTL-based architecture.

Developed for **Dream to Start – Tantrotsav 2026**, this project secured **1st Place along with a ₹10,000 cash award.**

---

## 🎯 Key Features

- Fully RTL-based hardware implementation (No ARM / No Python)
- Manhattan distance metric (|x - xi| + |y - yi|)
- Configurable K selection (3 or 5)
- Deterministic hardware execution
- FSM-based user interaction
- Resource-efficient sequential architecture

---

## 🛠 Hardware & Tools

- **Board:** Avnet ZedBoard (Zynq-7000 SoC)
- **Inputs:** 8 Slide Switches, 3 Push Buttons
- **Outputs:** 5 User LEDs
- **Language:** Verilog HDL
- **Toolchain:** Xilinx Vivado
- **Clock:** 100 MHz

---

## 🕹 Control Scheme (LED-Based Interface)

The system uses a user FSM to guide coordinate and K-value entry.

| LED | Name | Meaning |
|-----|------|---------|
| LED2 | LOAD_X | Waiting for X Coordinate |
| LED3 | LOAD_Y | Waiting for Y Coordinate |
| LED4 | LOAD_K | Waiting for K Value (3 or 5) |
| LED1 | DONE | Classification Complete |
| LED0 | CLASS | OFF = Class 0, ON = Class 1 |

---

## 🎮 Demo Flow

1. **Reset System**
   - Press **BTNR**
   - LED2 turns ON (Ready for X)

2. **Enter X Coordinate**
   - Set `SW[7:0]`
   - Press **BTNC**
   - LED3 turns ON

3. **Enter Y Coordinate**
   - Set `SW[7:0]`
   - Press **BTNC**
   - LED4 turns ON

4. **Enter K Value**
   - Set `SW[2:0]` to:
     - `011` → K = 3
     - `101` → K = 5
   - Press **BTNC**

5. **Start Classification**
   - Press **BTNL**

6. **View Result**
   - LED1 → DONE
   - LED0 → Class Output

---

## 🏗 Architecture

The system consists of modular hardware blocks:

- **knn_core** – Top-level wrapper coordinating modules
- **dist_cal** – Manhattan distance computation unit
- **kclass** – K-min tracking using sequential insertion logic
- **vote** – Majority voting logic
- **user_fsm** – User interaction controller

The architecture separates control and datapath for clarity and scalability.

---

## 📊 Design Philosophy

### Why Manhattan Distance?
Avoids multipliers and square-root operations, reducing FPGA resource usage.

### Why Sequential K Tracking?
Optimizes LUT utilization while maintaining deterministic latency.

### Why Fixed-Point Arithmetic?
Floating-point arithmetic significantly increases FPGA area consumption.

---

## 🔌 Pin Mapping (ZedBoard)

- Clock: Y9 (100 MHz)
- Reset: R18 (BTNR)
- Load: P16 (BTNC)
- Start: N15 (BTNL)
- Switches: SW0–SW7
- LEDs: LED0–LED4

---

## 🏆 Achievement

🥇 **1st Place – Dream to Start**  
🎉 Tantrotsav 2026  
💰 ₹10,000 Prize  

---

## 🚀 Future Improvements

- Parallel distance computation
- BRAM-based scalable dataset
- AXI-based PS–PL integration
- Higher-dimensional feature support
