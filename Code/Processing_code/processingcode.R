###############################
# processing script
#
#this script loads the raw data, processes and cleans it 
#and saves it as Rds file in the Processed_data folder


# Setup

# This code is needed to pull the code chunks contained in `processingcode.R` into active memory:


## ---- packages --------
#load needed packages. make sure they are installed.
require(dplyr) #for data processing/cleaning
require(tidyr) #for data processing/cleaning
require(skimr) #for nice visualization of data 


## ---- loaddata1.1 --------
data_location <- "../../Data/Raw_data/plant_measurement_raw.csv"
data_path <- "../../Data/Raw_data/"

## ---- loaddata1.2 --------
rawdata <- read.csv(data_location, check.names=FALSE)

## ---- loaddata1.3 --------

# We can look in the data dictionary for a variable explanation. I am using the paste function here to add the path to the filename.

# sep=“” adds no space when pasting.
dictionary <- read.csv(paste(data_path, "datadictionary.csv", sep=""))
print(dictionary)



## ---- exploredata --------

# Different ways to look at the data

dplyr::glimpse(rawdata)

summary(rawdata)

head(rawdata)

skimr::skim(rawdata)


## ---- exploredata2 --------

# We temporarily change the variable names to short names in this script for convenience. 

longnames <- names(rawdata)
names(rawdata) <- c("Date", "Time", "Sample number", "Location", "Type", "Treatment", "Size", "Species", "Plant type", "Height", "Width_farthest", "Width_perpendicular", "Branch_length", "Branch_diameter", "Basal_circ", "Stem_diameter", "Stem_height", "Stem_density", "Branches_per_stem", "Leaves_per_branch", "Total_leaves", "Leaf_lmax", "Leaf_lmin", "Leaf_lavg", "Leaf_wmax", "Leaf_wmin", "Leaf_wavg", "Leaf_tmax", "Leaf_tmin", "Leaf_tavg", "Biomass", "Measurement_location", "Note", "leaf: branch (total; biomass)", "leaf: branch (single branch; biomass)")


## ---- cleandata1 --------

# We check to make sure there is 14 species of plants for the dataset.

unique(rawdata$Species)

# Letʻs save rawdata as d1, and modify d1 so we can compare versions. 

d1 <- rawdata
unique(d1$Species)


## ---- cleandata2 -------- 

# Get rid of date and time, notes, 'Leaf: branch (total; biomass)' and 'Leaf: branch (single; biomass)' from the column
# We don't need these for our analysis.
d1 <- d1[,3:32]


# Some morphological measurements are missing for some species. It is because those measurements are irrelevant to certain species depending on the types of plant species (forbs, trees, and shrub) they are. 
#Turn any blanks or n/a's into NA

d1[d1==""] <- NA
d1[d1=="n/a"] <- NA


# Coerce all the entries of the morphological measurement variables to numeric
num <- c(8:29)
d1[,num] <- apply(d1[,num], 2, function(x) as.numeric(as.character(x)))



skimr::skim(d1)


## ---- cleandata3 -------- 

# We turn species into a categorical variable.

d1$Species <- as.character(d1$Species)

# We want to separate the measurements by species so we can look at morph measurements that correlate with the biomass of each species separately. 

# We split the plant (d1) dataframe into a list of dataframes (aka spec) by species. 
spec <- with(d1, split(d1, list(Species = Species)))
spec <- lapply(spec, function(x) x[, colSums(is.na(x)) == 0])

spec


## ---- cleandata4 -------- 

# Look at each species and their morph measurements
# Since Festuca Mairei only has three samples, we are going to eliminate it from the sample species, due to not enough sample size.
# We are also going to eliminate Unplanted weed and Unidentified shrub due to lack of identification on these species. 

Rows1 <- which(grepl("Festuca Mairei", d1$Species)) 
Rows2 <- which(grepl("Unplanted weed", d1$Species)) 
Rows3 <- which(grepl("Unidentified shrub", d1$Species)) 

d1 <- d1[-c(Rows1, Rows2, Rows3),]
d1


# Redefine spec with a new list of species (excluding Festuca Mairei, Unplanted weed and Unidentified shrub). 
spec <- with(d1, split(d1, list(Species = Species)))
spec <- lapply(spec, function(x) x[, colSums(is.na(x)) == 0])

spec



## ---- savedata --------

# Save the clean data as processed data
# We save d1, which is a dataframe as the clean data and will convert to spec, which is a list, on analysis script for data analysis.

processeddata <- d1      # clean data


## ---- savedata2 --------

# Location to save file

# We save the clean data as RDS file, as well as a copy as .csv.
# RDS/Rdata preserves coding like factors, characters, numeric, etc.

save_data_location <- "../../Data/Processed_data/processeddata.rds"
saveRDS(processeddata, file = save_data_location)

save_data_location_csv <- "../../Data/Processed_data/processeddata.csv"
write.csv(processeddata, file = save_data_location_csv, row.names=FALSE)


