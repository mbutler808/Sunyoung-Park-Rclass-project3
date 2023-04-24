###############################
# Morph measurement analysis script
#
# This script loads the processed, cleaned data, 
# does a simple analysis and saves the results
# to the results folder
###############################

## ---- setup -----
# load needed packages. make sure they are installed
require(ggplot2) #for plotting



# path to data and results 
data_path <- "../../Data/Processed_data/"

results_path <- "../../Results/"


## ---- functions ----
# function to paste path to output filenames

addpath <- function( filename, path=data_path ) {
    location <- paste( path, filename, sep="")
	return( location )
}

## ---- loaddata ----
# load data
dat <- readRDS( addpath("processeddata.rds", data_path) )



## ---- header ----
######################################
# Data fitting/statistical analysis
######################################


## ---- test for normality ----

# This part of the code tests for normality using a Shapiro Test
# the loop tests for normality in each species in the same order the dataframes are listed in spec


### the below is how you test for normality by species one at a time

print(shapiro.test(spec[["Aptenia cordifolia"]]$Biomass))
print(shapiro.test(spec[["Artemisia californica"]]$Biomass))
print(shapiro.test(spec[["Baccharis pilularis"]]$Biomass))
print(shapiro.test(spec[["Chondropetalum tectorum"]]$Biomass))
print(shapiro.test(spec[["Euphorbia spp."]]$Biomass))
print(shapiro.test(spec[["Gnaphaluim spp."]]$Biomass))
print(shapiro.test(spec[["Lactucca spp."]]$Biomass))
print(shapiro.test(spec[["Onetheria biennis"]]$Biomass))
print(shapiro.test(spec[["Rhus integrifolia"]]$Biomass))
print(shapiro.test(spec[["Salix spp."]]$Biomass))
print(shapiro.test(spec[["Solidago spp."]]$Biomass))
print(shapiro.test(spec[["Unidentified shrub"]]$Biomass))
print(shapiro.test(spec[["Unplanted weed"]]$Biomass))


##normally distributed data (p > 0.05): Aptenia cordifolia, Artemisia californica, Chondropetalum tectorum, #Gnaphaluim spp., Rhus integrifolia, Solidago spp., Unidentified shrub


##not normally distributed data (p < 0.05): Baccharis pilularis, Euphorbia spp., Lactucca spp., Onetheria #biennis, Salix spp., Unplanted weed



#Look at each species and its morphological measurements to see which measurement(s) would be a good biomass indicator for each species. Then we can test with a regular linear regression model for normally distributed data. 

spec

##Aptenia cordifolia: test for leaves per branch measurements

m1 <- lm(Biomass ~ Leaves_per_branch,
data= spec [["Aptenia cordifolia"]])
summary(m1)

### R-squared value is 0.3025 and p-value is 0.07236, which means that the model doesn't explain the variation of the data and it is also not significant.

##Aptenia cordifolia: test for branch length measurements

m1 <- lm(Biomass ~ Branch_length,
data= spec [["Aptenia cordifolia"]])
summary(m1)

### R-squared value is 0.7172 and p-value is 0.002438, which means that the model relatively explains the variation of the data (fits the regression model) and it is also significant. This morphological characteristic might be a good biomass indicator for Aptenia cordifolia.


##Artemisia californica: test for width perpendicular measurements
m1 <- lm(Biomass ~ Width_perpendicular,
data= spec[["Artemisia californica"]])
summary(m1)


### R-squared value is 0.9425 and p-value is 0.0008057, which means that the model does explain the variation of the data (fits the regression model) and it is also significant. This morphological characteristic might be a good biomass indicator for Artemisia californica.

m1 <- lm(Biomass ~ Width_perpendicular + Width_farthest,
data= spec[["Artemisia californica"]])
summary(m1)

m1 <- lm(Biomass ~ Width_perpendicular + Width_farthest + Branches_per_stem,
data= spec[["Artemisia californica"]])
summary(m1)

m1 <- lm(Biomass ~ Width_perpendicular + Branches_per_stem,
data= spec[["Artemisia californica"]])
summary(m1)
