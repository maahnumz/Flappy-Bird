# Flappy-Bird

# Flappy Bird on FPGA 🎮  
**Course:** EE 271 – Digital Circuits and Systems, University of Washington  
**Platform:** Intel/Altera DE1-SoC FPGA Development Board  


## 🧠 Project Overview
This project is a hardware implementation of the classic *Flappy Bird* game built entirely in **SystemVerilog** on the **DE1-SoC FPGA board**.  
It was completed as the **final lab (Lab 6)** in the UW *Intro to Digital Logic* course, which required designing a complete interactive digital system using finite state machines, timing logic, and peripheral interfaces.

The objective was to recreate the core mechanics of *Flappy Bird* — controlling a bird that flaps upward when a button is pressed and falls due to gravity otherwise — while avoiding a scrolling series of obstacles (“pipes”) on a VGA display.  
The game keeps score using the board’s HEX displays.


## 🧩 Features
- **Real-time gameplay** driven by FPGA logic (no microprocessor or software).  
- **Button control:** KEY[0] acts as the bird’s “flap” input.  
- **Gravity simulation:** Continuous downward movement unless flapping.  
- **Scrolling pipe obstacles:** Generated and moved across the screen using counters and shift registers.  
- **Collision detection:** Determines game over when the bird intersects a pipe.  
- **Score display:** Decimal score shown on on-board HEX displays.  
- **Reset mechanism:** Switch input (SW[0]) resets the game state.  
- **Video output:** HEX display driver integrated for rendering gameplay.


## 🧱 System Design
The project was implemented as a hierarchy of **SystemVerilog modules**:
Each module was individually tested in **ModelSim** with a testbench before being integrated at the top level.


## ⚙️ Hardware Requirements
- **DE1-SoC FPGA Board** (Intel/Altera Cyclone V)  
- **VGA Monitor** (640 × 480 @ 60 Hz)  
- **Power and USB-Blaster cable for programming**  
- Optional: External speakers for sound extensions (not required for base project)


## 🧪 Testing
- Verified submodules using ModelSim simulation (`*.do` and testbench files included).  
- Tested on physical hardware using Quartus II Programmer.  
- Debugged timing and signal synchronization via on-board LEDs.  


## 📈 Results
- Fully functional hardware game with real-time VGA rendering.  
- Stable gameplay with frame-rate synchronization and accurate collision detection.  
- Score updates correctly on the DE1 HEX display.  
- Demonstrated and verified by course TA for final project check-off.


## 🛠 Tools Used
- **Quartus II / Intel FPGA Lite Edition**  
- **ModelSim-Altera Edition** (simulation)  
- **SystemVerilog** (HDL design)  
- **VGA driver library** provided by UW EE 271 course staff  



