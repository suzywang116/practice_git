#Biostatistics for Public Health
#Created by :Shu Xu
#Last updated 09/03/2021
#New York University School of Global Public Health


#This is a do-file for Stata lab required for Lesson 1. 
#It contains all syntax to complete Lesson 1.
#
#Section 1.1: Changing work directory.
#Section 1.2: Read Stata data files
#Section 1.3: Compute new variable
#Section 1.4: Selection of a subset of data
#
#
#Additional codes
#Section 1.5: Save a new Stata data set
#Section 1.6: Recode a variable
 
#You can execute the code all at once, or you can highlight part of the code and execute it.

################ Section 1.1: Changing work directory ##########
# The command "getwd()" displays your current directory in the Results window. 
# working directory is a folder on your computer where R looks for datasets or other files
getwd()

#Use the "setwd()" command, followed by a path on your computer,to change the current directory
#It points R to a folder on your computer.
#YOU NEED TO CHANGE THE PATH TO THE FOLDER ON YOUR COMPUTER
setwd("G://My Drive//NYU Classes//NYU GPH GU 2995_2021 Fall//Teaching//Lab 1")

#downlaoding and loading the librarires to load the .dta or . csv files
install.packages("foreign")
install.packages("readstata13")
install.packages("dplyr")
install.packages("readxl")

# To use a package, invoke the library(package) command to load it into the current Rstudio session
library(foreign)
library(readstata13)
library(dplyr)

######################################################################
############ Section 1.2 To read\open non-stata files#################
######################################################################

#Use the read.csv command to import csv files.
#The below command  will import heart.csv, which you can later save as heart.R
heart <- read.csv(file = "heart.csv", header = T, stringsAsFactors = T )
View(heart)
edit(heart)

#you can import stata files with  .dta files using two way
#First way is through using .dta function from readstata13 package 
heights <- read.dta13("heights.dta")
View(heights)
edit(heights)

#*Q1: How many observations does the dataset have?
#*Q2: How many variables does the dataset have?
#*Q3: Does the dataset include the variable, gender?

# You can  also use dta files by using haven library and  read_dta command 
install.packages("haven")
library(haven)
heights <- read_dta("heights.dta")

#use str function to look at value labels quickly 
str(heights)

######################################################################
##############Section 1.3 Compute new variable ########################
######################################################################

#Recode gender, currenly coded as "1" for females and "2" for males, 
#into a new variable (new_gender) with codes "0" and "1"

#Here, we convert height--measured in centimeters in the dataset--to a 
#new variable measured in inches.
heights$height_inch = heights$height/2.54

#Here we took the natural log of the original height variable to
#create the logged height
heights$height_ln = log(heights$height)

#*Q4: How many variables does the dataset have now?
#*Q5: How many observations does the dataset have now?  

# assigning 1000 as missing value for cholestrol variable 
heart$chol[heart$chol==1000]<-NA

######################################################################
##############Section 1.4 Selection of a subset of data ##############
######################################################################

# assigning NA as missing value for age
hearts$age[hearts$age == 999]<-NA

# create a new temporary dataset, heights_subset, if one is younger than 30 yrs
heights_subset <-heights[which(heights$age<30),]
#now summarize age variable using summary() option 
summary(heights_subset$age)


######################################################################
############## Additional codes (1): Save a new R data set ###########
######################################################################

#*Recode "age", a continous variable, into a categorical one. To do this we create a 
#new variable, age_groups with values of 1, 2, 3, 4, and 5 corresponding to 0-29 years,
#30-39 years, 40-49, 50-59, and 60+, respectively. 

heights$age_groups <- cut(heights$age, c(0,30,40,50,60,90), right = FALSE, labels = c(1:5))
#check the frequency of each age group
table(heights$age_groups)

#label the values of the age_groups varibale 
heights$age_groups <-ordered(heights$age_groups, levels=c(1,2,3,4,5), 
                           labels=c("below 30yrs", "30 thru 39", "40 thru 49", "50 thry 59","above 60 yrs"))


######################################################################
############## Additional codes (2): Save a new R data set ###########
######################################################################

#Export a R data set to CSV in R
write.csv(heights_subset, "heights_subset.csv", row.names = TRUE)


### End of Lab 1###