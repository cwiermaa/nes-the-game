# "The Game" (NES Project)

A small, complete NES homebrew game written in 6502 assembly.

## Overview

**The Game** is a simple arcade-style project created as an early exercise in building a complete game from start to finish.

The player controls a triangular "bullet" moving continuously from left to right. A target moves vertically along the right side of the screen. The objective is to hit the target and score as many points as possible.

---

## Gameplay

* The player moves automatically from left to right
* Use controls to adjust movement:

  * **Up / Down** – move vertically
  * **Left** – slow down slightly (brake)
  * **Right** – increase speed

### Objective

* Hit the moving target to score points
* Gain **+1 point** per successful hit
* Gain **+1 life every 10 hits**
* Missing the target costs a life

### Lives & Progression

* Start with **3 lives**
* Missing the target:

  * No death animation
  * Player wraps back to the left side
* Game ends when all lives are lost

---

## Difficulty Settings

The title screen allows tuning of core gameplay parameters:

* **Target Speed**
* **Bullet Speed**
* **Target Size**

These settings allow the game to range from very easy to quite challenging.

---

## Audio

The title screen music is intentionally minimal:

* Square wave melody (B♭ scale)
* Harmony on the second square wave (thirds)

There is a subtle "ping" sound effect for hitting the target, and a minor trill for the Game Over music.

---

## Technical Notes

* Written in 6502 assembly
* Designed for the Nintendo Entertainment System (NES)
* Focused on simplicity and completeness rather than advanced techniques
* Represents an early step in learning:

  * input handling
  * game state management
  * rendering and timing

---

## Project Structure

```text
code/   - Core game logic and rendering
data/   - Graphics data
tools/  - Assembler binaries and build tooling
```

---

## Build

This project uses **WLA-DX v9.3** as the assembler.

### Windows

```bat
build.bat
```

### Notes

* The required assembler binaries are included under `tools/`
* Newer versions of WLA-DX may not be syntax-compatible

---

## Notes

* This was my first complete game project (created at age 15). It was also submitted for a minigame competition.
* The goal was to produce something fully playable from title screen to game over
* Code structure reflects the original development workflow with minimal refactoring
