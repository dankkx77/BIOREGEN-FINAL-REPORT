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
