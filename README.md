# BIOREGEN-FINAL-REPORT CODES
We involve all the codes and excel files used in our project, such as data analysis, simulation, frontend and backend of website.

Let's introduce what role each part of the codes plays in our project.

## Data Analysis

This folder contains the MATLAB scripts and datasets used to extract rate constants from experimental fluorescence measurements in our toehold-mediated DNA strand displacement system.

  ### Purpose
  
  The goal of the data analysis scripts is to:
  - Import raw fluorescence data from Excel.
  - Preprocess and sanitize the data (e.g., remove negative values).
  - Fit a bimolecular reaction ODE to experimental data to extract rate constants for each reaction variant.
  - Report the mean reaction rate constant in units of M⁻¹s⁻¹ for each gate variant.

  ### File Description

  Each script corresponds to a specific DNA strand displacement reaction with a different rate constant:
  - Ginit.m: Analyzes the control strand with no mismatches.
  - G1e2.m, G1e3.m, G1e4.m, G1e5.m, G1e6.m: Analyze variants with engineered mismatches targeting different kinetic rates.
  - Gnew.m: Analyzes new sequences designed in the second design iteration (Section 5 of the report).

## Simulation

## Website
This website provides a user-friendly interface for automated design of DNA toehold sequences that match a desired strand displacement rate constant (k). The tool combines a curated database of experimentally characterized sequences with computational screening using NUPACK to ensure structural viability.

  ### Purpose
  Designing custom DNA sequences with precise kinetic behaviours typically requires time-consuming simulations and manual filtering to avoid secondary structure. Our tool automates this process by:
  - Accepting a desired rate constant as user input.
  - Matching this to an appropriate sequence from our experimentally verified database.
  - Running secondary structure validation to ensure sequence usability.
  - Displaying a clean, intuitive interface for biologists, engineers, and molecular programmers.

  ### System Overview
  The tool is built using a full-stack architecture:
  - Frontend: HTML + JavaScript interface with real-time feedback and result display.
  - Backend: Python logic via a Django server that:
    - Parses user input.
    - Loads and filters a .CSV database of DNA toehold sequences.
    - Calls NUPACK (via Python) to screen for problematic secondary structures (e.g. hairpins).
    - Returns a matching sequence with validated properties.

  ### How It Works
1. **User Input**  
   The user enters a desired rate constant in the input field on the homepage (e.g., `3 × 10⁴ M⁻¹s⁻¹`).
2. **Sequence Matching**  
   The backend identifies the closest matching toehold sequence from the database using a lightweight heuristic (minimizing `|user_k − k_database|`).
3. **Secondary Structure Check**  
   Using NUPACK, the tool ensures that the selected toehold does not form unwanted secondary structures under typical conditions (25°C, DNA mode).
4. **Output**  
   The selected DNA toehold sequence, its associated rate constant, and structure check result are returned and displayed to the user.

  ### File Description
  - frontend.html: Implements the user interface. Features include input form, output display, and visual feedback.
  - Backend.ipynb: Contains backend logic, including:
    - .CSV parsing
    - Sequence matching
    - NUPACK integration for secondary structure validation
    - Output formatting

