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
	`1_A.cordifolia_branchlength.png` - linear regression for Aptenia cordifolia in .png format
	`2_A.californica_width.png` - linear regression for Artemisia californica in .png format
	`3_C.tectorum_density.png` - linear regression for Chondropetalum tectorum in .png format
	`4_Gnaphalium_branchperstem.png` - linear regression for Gnaphalium spp. in .png format
	`5_R.integrifolia_branchlength.png` - linear regression for Rhus integrifolia in .png format
	`6_Solidago_avgleaflength.png` - linear regression for Solidago spp. in .png format
	`7_B.pilularis_width.png` - linear regression for Baccharis pilularis in .png format
	`8_Euphorbia_width.png` - linear regression for Euphorbia spp. in .png format
	`9_Lactucca_totalleaves.png` - linear regression for Lactucca spp. in .png format
	`10_O.biennis_height.png` - linear regression for Onetheria biennis in .png format
	`11_Salix_height.png` - linear regression for Salix spp.a in .png format
```

