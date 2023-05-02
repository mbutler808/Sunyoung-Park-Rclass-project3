# Sunyoung's Final Project for ZOOL 710

This repository contains a dataset of direct measurements of 11 different morphological characteristics and aboveground biomass for 14 plant species found in urban greenspaces of Southern California. The main goal of this research is to identify relevant measurements of each plant species to biomass, and establish a non-destructive biomass indicator for each of the 14 plant species. 

# History

2023-4-22 First release with Data and Code folders with materials for data cleaning and initial exploration.

2023-4-24 Completed cleaning of Raw data and data dictionary, processing code and processed data

2023-4- 


# Software requirements

This template lays out a data analysis project and report writing using R, Quarto, Github and a reference manager for bibtex. A plain text editor is also necessary, and wordprocessing software to open .docx if you wish to use that format (e.g. MS Word, MacOS Pages, or [LibreOffice](https://www.libreoffice.org/)). 

# Repository structure

* All data goes into the `Data` folder and any subfolders.
* All code goes into the `Code` folder or subfolders.
* All results (figures, tables, computed values) go into `Results` folder or subfolders.
* All products (manuscripts, supplement, presentation slides, web apps, etc.) go into `Products` subfolders.
* See the various `README.md` files in those folders for some more information.


# Repository content


Please see the `README.md` files in each folder for more details.

* The repo has morphological measurement data of 13 plants species in the `Raw_data` folder. 
* The `Processing_code` folder contains several files that load the raw data, perform a bit of cleaning, and save the result in the `Processed_data` folder. 
* The `Analysis_code` folder contains several files that load the processed data, do an exploratory analysis, and fit a simple model. These files produce figures and some numeric output (tables), which are saved to the `results` folder.
* The `Products` folder contains an example `bibtex` and CSL style files for references. Those files are used by the example manuscript and slides.
* The  `Manuscript` folder contains a template for a report written as Quarto file.


# Getting started

The project can be reproduced by executing the code in the following order:

1.  First run the processing code, which will produce the processed data. 
2.  Then run the analysis scripts, which will take the processed data and produce some results. 
3.  Then you can run the manuscript, poster and slides example files in any order. Those files pull in the generated results and display them. These files also pull in references from the `bibtex` file and format them according to the CSL style.

