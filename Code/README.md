# Code Folder

## Code Location:

This directory contains `.R` or `.qmd` scripts in the folders as appropriate:

- Processing_code cleans raw data and converts to processed data
- Analysis_code performs analyses on cleaned data. 



## Code Documentation:

## **`Processingcode.R` - cleans raw data, outputs clean data**

**Inputs**

```{r}
reads in the following files from `../../Data/Raw_data/`
	`plant_measurement_raw.csv` - The raw data
	`datadictionary.csv` - The data dictionary for the raw data
```

**Outputs**

```{r}
outputs to `../../Data/Processed_data/`
	`processeddata.rds` - clean data in rds (R) format
	`processeddata.csv` - clean data in .csv format
```


## **`Analysis_code.R` - cleans data, outputs exploratory and statistical analysis**

**Inputs**

```{r}
reads in the following files from `../../Data/Processed_data/`
	`processeddata.csv` - clean data in .csv format
	`processeddata.rds` - clean data in rds (R) format
```

**Outputs**
```{r}
outputs to `../../Results/`

