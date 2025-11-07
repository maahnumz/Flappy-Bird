# Flappy Bird on FPGA 🎮  
**Course:** EE 271 – Digital Circuits and Systems, University of Washington  
**Instructor:** Prof. Nicole Hamilton  
**Platform:** Intel DE1-SoC FPGA Board + 16×16 Bi-Color LED Array  

---

## 🧠 Project Overview
This project implements a hardware-based version of *Flappy Bird* entirely in **SystemVerilog** on the **DE1-SoC FPGA**.  
It was the **final project (Lab 6)** for UW EE 271 *Intro to Digital Logic*, demonstrating full system-level digital design with real-time interactivity.

The game logic is synthesized directly in hardware. The player controls a red “bird” LED that flaps upward when the push-button is pressed and falls due to gravity when released. Pipes (green LEDs) scroll horizontally across a **16×16 bi-color LED array**, creating an obstacle course. The player’s score is shown on the board’s HEX display.

---

## ✨ Features
- **Real-time gameplay** implemented fully in logic (no CPU/software).  
- **Single-button control** (KEY input): press = flap up, release = fall down.  
- **Scrolling pipe obstacles** rendered in green on the 16×16 LED array.  
- **Collision detection** between the red bird and green pipes triggers Game Over.  
- **Score display** on the board’s 7-segment HEX output.  
- **Clock divider** for smooth animation timing and gravity simulation.  
- **Reset** switch to restart the game instantly.  

---

## 🧱 System Design
The project is organized into modular SystemVerilog files:

| File | Description |
|:----|:-------------|
| `DE1_SoC.sv` | Top-level integration module; connects all submodules and maps signals to board I/O (LED array, HEX, buttons, switches). |
| `LEDDriver.sv` | Drives the 16×16 bi-color LED matrix using row/column scanning to display the bird and pipe patterns. |
| `bird.sv` | Handles vertical movement logic based on gravity and button presses. |
| `pipeShift.sv` | Generates and shifts pipe columns across the screen; creates openings at varying heights. |
| `collision.sv` | Detects overlap between bird position and pipe positions to trigger game reset. |
| `clock_divider.sv` | Divides the 50 MHz system clock into lower-frequency enable signals for animation and display updates. |
| `button.sv` | Debounces mechanical button inputs to prevent false triggers. |
| `Press.sv` | Implements single-pulse flap input logic derived from debounced button presses. |
| `single_hex.sv` | Controls one HEX display digit for score output. |

Each module was unit-tested in ModelSim and verified on the DE1-SoC board.

---

## ⚙️ Hardware Requirements
- **Intel/Altera DE1-SoC FPGA board**  
- **16×16 bi-color (RED/GREEN) LED matrix display board**  
- **VGA power/logic headers or GPIO pins connected to LED matrix**  
- **1 push button (KEY[0])** – bird flap control  
- **1 switch (SW[0])** – reset game  
- **7-segment HEX display** – score counter  

---

## 🧪 Testing and Verification
- Each module simulated in **ModelSim** using custom testbenches.  
- Timing verified by LED animation rate and stable frame updates.  
- Final integration tested on hardware to confirm real-time response and collision accuracy.  

---

## 📈 Results
- Functional Flappy Bird game displayed on a 16×16 LED array.  
- Responsive controls with smooth animation and gravity behavior.  
- Correct pipe movement and collision detection.  
- Stable score increment and reset operation verified by TA during lab check-off.  

---

## 🛠 Tools Used
- **Intel Quartus II Lite Edition** (for synthesis and programming)  
- **ModelSim-Altera Edition** (for simulation and debugging)  
- **SystemVerilog HDL**  
- **DE1-SoC board GPIO interface documentation** (from UW EE 271 website)  








