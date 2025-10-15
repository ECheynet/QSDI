# QSDI: Matlab Implementation of the Questionnaire on Supervisor–Doctoral Student Interaction

## Overview
This repository provides a Matlab implementation of the QSDI (Questionnaire on Supervisor–Doctoral Student Interaction) test, based on the model developed by **Mainhard et al. (2009)**.  
The QSDI framework analyzes interpersonal dynamics between doctoral supervisors and their students across two key dimensions: **Influence (Dominance–Submission)** and **Proximity (Cooperation–Opposition)**. 
These interactions leads to eight relational categories:  `DC`, `CD`, `CS`, `SC`, `SO`, `OS`, `OD`, `DO`.

These categories provide a structured way to **visualize, quantify, and compare** perceptions of supervisor–student relationships, supporting research, feedback, and self-assessment in doctoral supervision.

---

## Repository Contents
- **`QSDI.m`**  Core function that processes and analyzes supervisor–student questionnaire data, returning interactional profiles and category scores.  
- **`Documentation.mlx`**  Live Script documentation providing theoretical background, usage instructions, and example analysis.  
- **`spider_plot` toolbox**  Visualization utility for radar (spider) plots [2] 
   
---

## Usage
1. Place supervisor and student QSDI questionnaire data in the `/QSDI_Test_Data/` folder as `.csv` files.  
2. Run the main script to:
   - Load data and call the `QSDI` function.  
   - Generate spider plots comparing supervisor and student perceptions.  
   - Save figures automatically in the `/figures/` directory.
  
## References

Mainhard, T., Van Der Rijst, R., Van Tartwijk, J., & Wubbels, T. (2009). *A model for the supervisor–doctoral student relationship*. Higher education, 58(3), 359-373.

Moses (2025). *spider_plot* [GitHub Release v20.8](https://github.com/NewGuy012/spider_plot/releases/tag/20.8). Retrieved October 15, 2025. 

