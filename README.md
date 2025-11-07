# Flappy Bird on FPGA 🎮  
**Course:** EE 271 – Digital Circuits and Systems, University of Washington

**Instructor:** Nicole Hamilton

**Platform:** Intel/Altera DE1-SoC FPGA Development Board  


## 🧠 Project Overview
This project is a hardware implementation of the classic *Flappy Bird* game, built entirely in **SystemVerilog** on the **DE1-SoC FPGA board** and displayed on a **16×16 bi-color LED array board**.  
It was completed as the **final lab (Lab 6)** in the UW *Intro to Digital Logic* course, which required designing a fully functional interactive digital system using finite state machines, counters, and synchronous logic.

The game recreates the core *Flappy Bird* mechanics: the player controls a red LED “bird” that rises when a button is pressed and falls under simulated gravity otherwise, while avoiding green LED “pipes” scrolling horizontally across the display. The score is tracked using the board’s built-in HEX displays.


## 🧩 Features
- **Real-time gameplay** executed entirely in FPGA logic (no CPU or software).  
- **Button input:** KEY[0] acts as the bird’s flap control.  
- **Gravity simulation:** Bird position updates continuously based on a timing counter.  
- **Scrolling obstacles:** Green pipes move from right to left, with randomly generated vertical gaps.  
- **Collision detection:** Determines game-over when the bird overlaps a pipe.  
- **Score tracking:** Decimal score displayed on the DE1-SoC HEX displays.  
- **Reset switch:** SW[0] resets the game state to restart play.  
- **Display hardware:** Output rendered on a 16×16 bi-color LED matrix (red = bird, green = pipes).  


## 🧱 System Design
The design consists of multiple **SystemVerilog modules** connected in a hierarchical structure:

| Module | Description |
| ------- | ------------ |
| `flappy_top.sv` | Integrates all submodules and connects to DE1-SoC I/O pins and the LED matrix interface. |
| `bird.sv` | Tracks the bird’s vertical position and applies upward motion when the button is pressed. |
| `pipe_generator.sv` | Creates new pipe positions using a pseudo-random LFSR and scrolls them across the array. |
| `collision.sv` | Detects overlap between the bird’s coordinates and the pipe pattern. |
| `score_counter.sv` | Increments score whenever the bird successfully passes a pipe. |
| `led_driver.sv` | Converts internal (x, y, color) states into row/column signals for the 16×16 bi-color LED array. |
| `clock_divider.sv` | Generates slower timing signals from the 50 MHz system clock for movement and updates. |

Each module was independently simulated in **ModelSim** before top-level integration and board testing.


## ⚙️ Hardware Requirements
- **Intel/Altera DE1-SoC FPGA Board** (Cyclone V)  
- **16×16 Bi-Color LED Array Board** connected via GPIO header  
- **Power and USB-Blaster cable** for programming  
- **Push-buttons and switches** on the DE1-SoC board  


## 🧪 Testing
- Verified all submodules with ModelSim testbenches (`*.sv` + `.do` files).  
- Hardware-tested using Quartus II Programmer on the physical board.  
- Validated real-time response, smooth scrolling, and accurate collision logic.  
- Used LEDs and HEX displays for debugging state transitions.  


## 📈 Results
- Achieved fully playable *Flappy Bird* with clear red/green LED display.  
- Stable, flicker-free animation across the 16×16 LED matrix.  
- Correct scoring and reset functionality.  
- Successfully demonstrated and checked off during the final lab presentation.


## 🛠 Tools Used
- **Quartus II / Intel FPGA Lite Edition**  
- **ModelSim-Altera Edition** (simulation)  
- **SystemVerilog** (HDL design)  
- **DE1-SoC + 16×16 LED Array Board**





