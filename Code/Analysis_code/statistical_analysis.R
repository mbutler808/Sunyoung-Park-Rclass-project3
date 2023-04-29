title: ""Cleaning R script for identifying best predictors of biomass for 13 plant species""
author: "Sunyoung Park"
date: "04/22/2023"
output: textedit_document
---

  
This TextEdit file loads the cleaned data and does some initial analysis. 


# Analysis 

# In this analysis script, I am analyzing direct measurements of 11 different morphological characteristics and aboveground biomass to identify the best non-destructive indicators for the aboveground biomass of each of the 13 plant species.  

# I am using regression analysis to perform my analysis. 



###############################
# Morph measurement and biomass correlation analysis script
#
# This script loads the processed, cleaned data, 
# does a simple analysis and saves the results
# to the results folder
###############################

## ---- setup -----


# load needed packages. make sure they are installed
require(ggplot2) #for plotting
require(lattice) # for plotting
require(magrittr) #for piping
require(knitr) #for formatting output



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


## ---- testfornormality ----

# This part of the code tests for normality using a Shapiro-Wilk test.
# The loop tests for normality in each species in the same order the dataframes are listed in spec.

# We split the plant (d1) dataframe into a list of dataframes (aka spec) by species. 
spec <- with(dat, split(dat, list(Species = Species)))
spec <- lapply(spec, function(x) x[, colSums(is.na(x)) == 0])

spec


# The below is how you test for normality by species for the 13 species we are going to study. 


for (i in 1:length(spec)) {
  
  print(shapiro.test(spec[[i]]$Biomass))
  
}

### not sure if there's a way to make this a table?


# Or this, to test for normality for each species individually one at a time. 

print(shapiro.test(spec[["Aptenia cordifolia"]]$Biomass))
print(shapiro.test(spec[["Artemisia californica"]]$Biomass))
print(shapiro.test(spec[["Baccharis pilularis"]]$Biomass))
print(shapiro.test(spec[["Chondropetalum tectorum"]]$Biomass))
print(shapiro.test(spec[["Euphorbia spp."]]$Biomass))
print(shapiro.test(spec[["Gnaphalium spp."]]$Biomass))
print(shapiro.test(spec[["Lactucca spp."]]$Biomass))
print(shapiro.test(spec[["Onetheria biennis"]]$Biomass))
print(shapiro.test(spec[["Rhus integrifolia"]]$Biomass))
print(shapiro.test(spec[["Salix spp."]]$Biomass))
print(shapiro.test(spec[["Solidago spp."]]$Biomass))
print(shapiro.test(spec[["Unidentified shrub"]]$Biomass))
print(shapiro.test(spec[["Unplanted weed"]]$Biomass))


# From the test, we observe: 
# Normally distributed data (p-value > 0.05): Aptenia cordifolia, Artemisia californica, Chondropetalum tectorum, Gnaphaluim spp., Rhus integrifolia, Solidago spp., Unidentified shrub


# Not normally distributed data (p-value < 0.05): Baccharis pilularis, Euphorbia spp., Lactucca spp., Onetheria biennis, Salix spp., Unplanted weed




## ---- linear_regression_model_A.cordifolia ----

# Look at each species and its morphological measurements to see which measurement(s) would be a good biomass indicator for each species. Then we can test with a regular linear regression model for normally distributed data. 

spec

#Aptenia cordifolia: test for leaves per branch measurements

m1 <- lm(Biomass ~ Leaves_per_branch,
data= spec [["Aptenia cordifolia"]])
summary(m1)

# R-squared value is 0.3025 and p-value is 0.07236, which means that the model doesn't explain the variation of the data and it is also not significant.


#Aptenia cordifolia: test for branch length measurements

m1 <- lm(Biomass ~ Branch_length,
data= spec [["Aptenia cordifolia"]])
summary(m1)

# R-squared value is 0.7172 and p-value is 0.002438, which means that the model relatively explains the variation of the data (fits the regression model) and it is also significant. This morphological characteristic might be a good biomass indicator for Aptenia cordifolia.

# ggplot to plot it

ggplot(data=subset(dat,Species=="Aptenia cordifolia"), aes(x=Branch_length, y=Biomass), na.rm=TRUE) +      geom_point() +
  stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
  xlab("Branch Length (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Branch Length vs. Biomass for", substitute(paste(italic("Aptenia cordifolia"))))
            

# plot to .png file

a.cordifolia <- ggplot(data=subset(dat,Species=="Aptenia cordifolia"), aes(x=Branch_length, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Branch Length (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Branch Length vs. Biomass for", substitute(paste(italic("Aptenia cordifolia"))))

ggsave(filename = addpath("A.cordifolia_branchlength.png", results_path), a.cordifolia)




## ---- linear_regression_model_A.californica ----

#Artemisia californica: test for width farthest measurements

m1 <- lm(Biomass ~ Width_farthest,
data= spec[["Artemisia californica"]])
summary(m1)

# R-squared value is 0.9594 and p-value is 0.0003998, which means that the model does explain the variation of the data (fits the regression model) and it is also significant. This morphological characteristic might be a good biomass indicator for Artemisia californica since it has the highest R-squared value.
 

# ggplot to plot it

ggplot(data=subset(dat,Species=="Artemisia californica"), aes(x=Width_farthest, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Width (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Width vs. Biomass for", substitute(paste(italic("Artemisia californica"))))
            

# plot to .png file

a.californica <- 
ggplot(data=subset(dat,Species=="Artemisia californica"), aes(x=Width_farthest, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Width (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Width vs. Biomass for", substitute(paste(italic("Artemisia californica"))))
            
ggsave(filename = addpath("a.californica_width.png", results_path), a.californica)



## Artemisia californica: now we test if using multiple morphological characteristics as biomass indicators will increase the R-squared value.  


m1 <- lm(Biomass ~ Width_perpendicular + Width_farthest + Branches_per_stem,
data= spec[["Artemisia californica"]])
summary(m1)

# R-squared value is 0.9733 and p-value is 0.01599, which means that the model does explain the variation of the data (fits the regression model) and it is also significant. These three morphological characteristics can be used together as better biomass indicators for Artemisia californica than one individual characteristic, since it has a higher R-squared value.





## ---- linear_regression_model_C.tectorum ----

#Chondropetalum tectorum : test for stem density measurements

m1 <- lm(Biomass ~ Stem_density,
data= spec[["Chondropetalum tectorum"]])
summary(m1)

# R-squared value is 0.9177 and p-value is 0.001661, which means that the model does explain the variation of the data (fits the regression model) and it is also significant. This morphological characteristic might be a good biomass indicator for Chondropetalum tectorum since it has the highest R-squared value.
 

# ggplot to plot it

ggplot(data=subset(dat,Species=="Chondropetalum tectorum"), aes(x=Stem_density, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Stem Density (n)") + 
  ylab("Biomass (g)") +
  ggtitle("Stem Density vs. Biomass for", substitute(paste(italic("Chondropetalum tectorum"))))
            

# plot to .png file

c.tectorum <- 
ggplot(data=subset(dat,Species=="Chondropetalum tectorum"), aes(x=Stem_density, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Stem Density (n)") + 
  ylab("Biomass (g)") +
  ggtitle("Stem Density vs. Biomass for", substitute(paste(italic("Chondropetalum tectorum"))))
            
ggsave(filename = addpath("c.tectorum_density.png", results_path), c.tectorum)




## ---- linear_regression_model_Gnaphalium.spp. ----

#Gnaphalium spp. : test for branch per stem measurements

m1 <- lm(Biomass ~ Branches_per_stem,
data= spec[["Gnaphalium spp."]])
summary(m1)

# R-squared value is 0.8425 and p-value is 0.01788, which means that the model does explain the variation of the data (fits the regression model) and it is also significant. This morphological characteristic might be a good biomass indicator for Gnaphalium spp. since it has the highest R-squared value.


# ggplot to plot it

ggplot(data=subset(dat,Species=="Gnaphaluim spp."), aes(x=Branches_per_stem, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Branches per stem (n)") + 
  ylab("Biomass (g)") +
  ggtitle("Branches per stem vs. Biomass for", substitute(paste(italic("Gnaphalium spp."))))
            

# plot to .png file

Gnaphalium <-  ggplot(data=subset(dat,Species=="Gnaphalium spp."), aes(x=Branches_per_stem, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Branches per stem (n)") + 
  ylab("Biomass (g)") +
  ggtitle("Branches per stem vs. Biomass for", substitute(paste(italic("Gnaphalium spp."))))

ggsave(filename = addpath("Gnaphalium_branchperstem.png", results_path), Gnaphalium)



## ---- linear_regression_model_R.integrifolia ----

#R.integrifolia : test for branch length measurements

m1 <- lm(Biomass ~ Branch_length,
data= spec[["Rhus integrifolia"]])
summary(m1)

# R-squared value is 0.955 and p-value is 0.002662, which means that the model does explain the variation of the data (fits the regression model) and it is also significant. This morphological characteristic might be a good biomass indicator for Rhus integrifolia since it has the highest R-squared value.


# ggplot to plot it

ggplot(data=subset(dat,Species=="Rhus integrifolia"), aes(x=Branch_length, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Branch Length(n)") + 
  ylab("Biomass (g)") +
  ggtitle("Branch Length vs. Biomass for", substitute(paste(italic("Rhus integrifolia"))))
            

# plot to .png file

R.integrifolia <-  ggplot(data=subset(dat,Species=="Rhus integrifolia"), aes(x=Branch_length, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Branch Length (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Branch Length vs. Biomass for", substitute(paste(italic("Rhus integrifolia"))))


ggsave(filename = addpath("R.integrifolia_branchlength.png", results_path), R.integrifolia)







## ---- linear_regression_model_solidago ----

# Solidago spp. : test for average leaf length measurements

m1 <- lm(Biomass ~ Leaf_lavg,
data= spec[["Solidago spp."]])
summary(m1)

# R-squared value is 0.9923 and p-value is 1.431e-05, which means that the model does explain the variation of the data (fits the regression model) and it is also significant. This morphological characteristic might be a good biomass indicator for Solidago spp. since it has the highest R-squared value.


# ggplot to plot it

ggplot(data=subset(dat,Species=="Solidago spp."), aes(x=Leaf_lavg, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Average leaf length (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Average leaf length vs. Biomass for", substitute(paste(italic("Solidago spp."))))
            

# plot to .png file

solidago <-  ggplot(data=subset(dat,Species=="Solidago spp."), aes(x=Leaf_lavg, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Average leaf length (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Average leaf length vs. Biomass for", substitute(paste(italic("Solidago spp."))))
            

ggsave(filename = addpath("solidago_avgleaflength.png", results_path), solidago)








## ---- linear_regression_model_unidentifiedshrub ----

# Unidentified shrub  : test for branch length measurements

m1 <- lm(Biomass ~ Branch_length,
data= spec[["Unidentified shrub"]])
summary(m1)

# R-squared value is 0.9454 and p-value is 0.0007269, which means that the model does explain the variation of the data (fits the regression model) and it is also significant. This morphological characteristic might be a good biomass indicator for Unidentified shrub since it has the highest R-squared value.


# ggplot to plot it

ggplot(data=subset(dat,Species=="Unidentified shrub"), aes(x=Branch_length, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Branch Length (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Branch Length vs. Biomass for", substitute(paste(italic("Unidentified shrub"))))
            

# plot to .png file

unidentifiedshrub <-  ggplot(data=subset(dat,Species=="Unidentified shrub"), aes(x=Branch_length, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Branch Length (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Branch Length vs. Biomass for", substitute(paste(italic("Unidentified shrub"))))


ggsave(filename = addpath("unidentifiedshrub_branchlength.png", results_path), unidentifiedshrub)



# For non-normally distributed data (where the response variable, biomass, is not normally distributed), we use a generalized linear model (glm). 
# We can also use a log transformation to transform the data to a more normally distributed dataset.
# For our analysis, we will use a log transformation before. 



## ---- linear_regression_model_B.pilularis ----


spec[["Baccharis pilularis"]]$log <- log(spec[["Baccharis pilularis"]]$Biomass)

print(shapiro.test(spec[["Baccharis pilularis"]]$log))

y <- rnorm(spec[["Baccharis pilularis"]]$log)
qqnorm(y); qqline(y)




# Baccharis pilularis: test for width measurements 

m1 <- lm(log ~ Width_farthest,
       data = spec[["Baccharis pilularis"]])
summary(m1)


# R-squared value is 0.8904 and p-value is 0.0008862, which means that the model does explain the variation of the data (fits the regression model) and it is also significant. This morphological characteristic might be a good biomass indicator for Baccharis pilularis since it has the highest R-squared value.


# ggplot to plot it

ggplot(data=subset(dat,Species=="Baccharis pilularis"), aes(x=Width_farthest, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Width (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Width vs. Biomass for", substitute(paste(italic("Baccharis pilularis"))))
            

# plot to .png file

b.pilularis <-  ggplot(data=subset(dat,Species=="Baccharis pilularis"), aes(x=Width_farthest, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Width (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Width vs. Biomass for", substitute(paste(italic("Baccharis pilularis"))))


ggsave(filename = addpath("b.pilularis_width.png", results_path), b.pilularis)





## ---- linear_regression_model_Euphorbia ----


# Euphorbia spp.: test for width measurements 

m1 <- lm(Biomass ~ Width_farthest,
       data = spec[["Euphorbia spp."]])
summary(m1)


# R-squared value is 0.8814 and p-value is 0.0001094, which means that the model does explain the variation of the data (fits the regression model). Even though the dataset was not normally distributed, the R-squared value is greater without a log transformation.  


# ggplot to plot it

ggplot(data=subset(dat,Species=="Euphorbia spp."), aes(x=Width_farthest, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Width (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Width vs. Biomass for", substitute(paste(italic("Euphorbia spp."))))
            

# plot to .png file

euphorbia <-  ggplot(data=subset(dat,Species=="Euphorbia spp."), aes(x=Width_farthest, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Width (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Width vs. Biomass for", substitute(paste(italic("Euphorbia spp."))))


ggsave(filename = addpath("euphorbia_width.png", results_path), euphorbia)







## ---- linear_regression_model_Lactucca ----


# Lactucca spp.: test for width measurements 

m1 <- lm(Biomass ~ Total_leaves,
       data = spec[["Lactucca spp."]])
summary(m1)

# R-squared value is 0.9937 and p-value is 0.0001378, which means that the model does explain the variation of the data (fits the regression model). Even though the dataset was not normally distributed, the R-squared value is greater without a log transformation.  



# ggplot to plot it

ggplot(data=subset(dat,Species=="Lactucca spp."), aes(x=Total_leaves, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Total Leaves (n)") + 
  ylab("Biomass (g)") +
  ggtitle("Total Leaves vs. Biomass for", substitute(paste(italic("Lactucca spp."))))
            

# plot to .png file

Lactucca <-  ggplot(data=subset(dat,Species=="Lactucca spp."), aes(x=Total_leaves, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Total Leaves (n)") + 
  ylab("Biomass (g)") +
  ggtitle("Total Leaves vs. Biomass for", substitute(paste(italic("Lactucca spp."))))


ggsave(filename = addpath("lactucca_totalleaves.png", results_path), lactucca)









## ---- linear_regression_model_O.biennis ----


spec[["Onetheria biennis"]]$log <- log(spec[["Onetheria biennis"]]$Biomass)

print(shapiro.test(spec[["Onetheria biennis"]]$log))

y <- rnorm(spec[["Onetheria biennis"]]$log)
qqnorm(y); qqline(y)


# Onetheria biennis: test for height measurements 

m1 <- lm(log ~ Height,
       data = spec[["Onetheria biennis"]])
summary(m1)

# R-squared value is 0.8165 and p-value is 0.0005163, which means that the model does explain the variation of the data (fits the regression model) and it is also significant. This morphological characteristic might be a good biomass indicator for Onetheria biennis since it has the highest R-squared value.



# ggplot to plot it

ggplot(data=subset(dat,Species=="Onetheria biennis"), aes(x=Height, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Height (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Height vs. Biomass for", substitute(paste(italic("Onetheria biennis"))))
            

# plot to .png file

O.biennis <-  ggplot(data=subset(dat,Species=="Onetheria biennis"), aes(x=Height, y=Biomass), na.rm=TRUE) + geom_point() +
 stat_smooth(method = "lm", formula = y ~ x,
              geom = "smooth", se = FALSE) +
xlab("Height (cm)") + 
  ylab("Biomass (g)") +
  ggtitle("Height vs. Biomass for", substitute(paste(italic("Onetheria biennis"))))


ggsave(filename = addpath("o.biennis_height.png", results_path), o.biennis)



