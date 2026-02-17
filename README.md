

# Hardware-Accelerated KNN Classifier on FPGA 🚀

A real-time, hardware-accelerated **K-Nearest Neighbors (KNN)** classification engine implemented entirely in Verilog on the **Xilinx ZedBoard**. This project calculates Euclidean-like (Manhattan) distances in parallel, sorts neighbors in real-time, and classifies input data in just **32 clock cycles**.

## 🎯 Key Features

* **High Performance:** Complete classification latency of ~320ns (at 100MHz).
* **Hardware Acceleration:** Pipelined distance calculation and parallel sorting network.
* **Interactive Interface:** Fully controlled via on-board Buttons and Switches.
* **Visual Feedback:** State-machine driven LED indicators for user guidance.
* **Configurable K:** Supports dynamic switching between  and  neighbors.

## 🛠 Hardware & Tools

* **Board:** Avnet ZedBoard (Zynq-7000 SoC)
* **Inputs:** 8 Slide Switches, 3 Push Buttons
* **Outputs:** 5 User LEDs
* **Language:** Verilog HDL
* **Synthesis:** Xilinx Vivado

## 🕹 Control Scheme (The LED Interface)

The system uses a state machine to guide the user through entering coordinates. Watch the **LEDs** to know which input is expected next.

| LED | Name | Status Meaning |
| --- | --- | --- |
| **LED2** | `LOAD_X` | System is waiting for **X Coordinate**. |
| **LED3** | `LOAD_Y` | System is waiting for **Y Coordinate**. |
| **LED4** | `LOAD_K` | System is waiting for **K Value** (3 or 5). |
| **LED1** | `DONE` | Classification Complete. |
| **LED0** | `CLASS` | **OFF** = Class 0, **ON** = Class 1. |

### 🎮 How to Demo

1. **System Reset:**
* Press **BTNR (Right Button)**.
* *Check:* **LED2** turns ON. (Ready for X)


2. **Input X Coordinate:**
* Set **Switches [7:0]** to desired X value (e.g., `00001100`).
* Press **BTNC (Center Button)** to load.
* *Check:* **LED2** turns OFF, **LED3** turns ON.


3. **Input Y Coordinate:**
* Set **Switches [7:0]** to desired Y value.
* Press **BTNC (Center Button)** to load.
* *Check:* **LED3** turns OFF, **LED4** turns ON.


4. **Input K Value:**
* Set **Switches [2:0]** to 3 (`011`) or 5 (`101`).
* Press **BTNC (Center Button)** to load.
* *Check:* **LED4** turns OFF. System is ready.


5. **Run Classification:**
* Press **BTNL (Left Button)**.
* *Result:*
* **LED1** lights up (Computation Done).
* **LED0** shows the result (ON = Class 1 / OFF = Class 0).





## 🏗 Architecture

The system is composed of four main hardware modules:

1. **`knn_core`**: The top-level wrapper managing data flow and state.
2. **`dist_cal`**: High-speed Manhattan Distance calculator ().
3. **`kclass`**: A parallel sorting network that maintains the top  nearest neighbors.
4. **`vote`**: Majority voting logic to determine the final class based on the  neighbors.

## 🔌 Pin Mapping (ZedBoard)

* **Clock:** `Y9` (100 MHz)
* **Reset:** `R18` (BTNR)
* **Load:** `P16` (BTNC)
* **Start:** `N15` (BTNL)
* **Switches:** `F22`, `G22`... (SW0-SW7)
* **LEDs:** `T22`, `T21`... (LED0-LED4)
