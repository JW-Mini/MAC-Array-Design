# MAC-Array-Design
<img width="627" height="587" alt="Screenshot 2026-10-17 085728" src="https://github.com/user-attachments/assets/90be35a1-35ae-41ba-aee0-9cbfed248c53" />

Design, simulation, and chip placement of a 3x3 MAC array for Advanced Digital Design - Spring 2026.

## Design Goal
Tasked with individually implementing a systolic MAC array in Verilog, performing synthesis and testbench verification via
**Cadence Genus** and **Cadence Xcelium**. The MAC array design is then placed and routed into a physical design using
**Cadence Innovus** and run with the same testbench to check functionality. Timing and power constraints are also maintained throughout
the design.

## Context
A Multiply-Accumulate (MAC) array is an array of execution units that multiply numbers and add the results to a running sum. This has many applications,
including machine learning and image process, due to its usefulness in matrix multiplication. Due to the large size of a typical array, the digital design
pipeline (RTL programming) is commonly used over the analog design pipeline (manual transistor placement); this also makes array designs easier to scale.
