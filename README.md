# Calculator

## Overview
This app was designed to mimic the look and functionality of the iPhone calculator. The user can type in a mathematic expression using all standard operations and generate the solution.

<img width="370" height="655" alt="image" src="https://github.com/user-attachments/assets/16a00682-001d-4df3-b752-f9c51de89435" />

## Design and Architecture
This application divides responsibilities between two layers:
- QML Layer: Layout, Styling, Interaction
- C++ Layer: Application Logic, Mathematic Evaluation

The two layers communicate through Qt's context property mechanism. This happens upon app instantiation in the entry point and allows the QML components to invoke backend methods directly.

## Requirements
- Qt (5.15+ or Qt 6)
- C++ compiler
- QMake

## Build Instructions
```
chmod +x build_calculator.sh
./build_calculator.sh
```

## How to Run
```
./build/bin/calculator
```

