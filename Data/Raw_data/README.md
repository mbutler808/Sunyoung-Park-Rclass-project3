# README.md

This folder contains the raw data for this project. 

This dataset contains 35 columns, 34 data columns and one comment (Notes) field, as explained in `datadictionary.csv` or the table below. 

The cleaned dataset is saved in `../Processed_data/` in both `.rda` and `.csv` versions, with a data dictionary in the `README.md`.  

The code for processing the raw data is in **Sunyoung-Park-Rclass-project3 > Code > Processing_code**, and runs from that working directory. 

#Files

`plant_measurement_raw.csv` original raw data 
`datadictionary.csv` data dictionary for raw data (also below)

|variable| description|
|----------|--------------|
| Date | a date denoting when the plant morphology data of each sample was measured |
| Time | a time denoting when the plant morphology data of each sample was measured |
| Sample number | an integer denoting the continuous numbering sequence for each sample |
| Location | a character string denoting the location each individual was found and collected |
| Type | a character string denoting the land cover type each individual was found and collected |
| Treatment | a character string denoting whether a plant was vegetated or unvegetated |
| Size | a character string denoting the size of a plant (small, medium or large) |
| Species | a character string denoting the plant species |
| Plant type | a character string denoting the morphological type of a plant |
| Height | a number denoting the plant height (centimeters)|
| Width (farthest to farthest)| a number denoting the farthest width from tip to tip of a plant (centimeters)|
| Width (perpendicular)| a number denoting the width of a plant that is perpendicular to the width (farthest to farthest) (centimeters)| 
| Branch length (avg) | a number denoting the average measurement of 10 branch lengths of a plant (centimeters)| 
| Branch diameter (avg) | a number denoting the average measurement of 10 branch diameters of a plant (centimeter)| 
| Basal circumference | a number denoting the basal circumference of a plant (centimeters)| 
| Stem diameter | a number denoting the diameter of the stem (the part right after roots that are aboveground) of a plant (centimeters)|
| Stem height | a number denoting the height of the entire stem (centimeters)|
| Stem density | an integer denoting the number of stems of a plant |
| branches per stem | an integer denoting the number of branches per stem in a plant |
| leaves per branch (avg) | a number denoting the average number of leaves on 5 longest branches of a plant |
| Total leaves | an integer denoting the total number of leaves in a plant |
| Leaf Length (max) | a number denoting the maximum length from the measurements of 9 leaves in a plant (centimeters)|
|  Leaf Length (min) | a number denoting the minimum length from the measurements of 9 leaves in a plant (centimeters)|
| Leaf Length (avg) | a number denoting the average length of the measurements of 9 leaves in a plant (centimeters)|
| Leaf width (max) | a number denoting the maximum width from the measurements of 9 leaves in a plant(centimeters)|
| Leaf width (min) | a number denoting the minimum width from the measurements of 9 leaves in a plant(centimeters)|
| Leaf width (avg) | a number denoting the average width of the measurements of 9 leaves in a plant(centimeters)|
| Leaf thickness (max) | a number denoting the maximum thickness from the measurements of 9 leaves in a plant(centimeters)|
| Leaf thickness (min) | a number denoting the minimum thickness from the measurements of 9 leaves in a plant(centimeters)|
| Leaf thickness (avg) | a number denoting the average thickness of the measurements of 9 leaves in a plant(centimeters)|
| Biomass | a number denoting the biomass of the dried plants (grams)|
| measurement location | a character string denoting the location where the morphological measurements were made |
| note | a character string with text providing additional relevant information for data |
| leaf:branch (total; biomass) | a ratio denoting the total biomass of leaf in a plant to the total biomass of branch in a plant (grams)|
| leaf:branch (single branch; biomass) | a ratio denoting the total biomass of leaf in one branch of a plant to the total biomass of the one branch in a plant (grams)|

