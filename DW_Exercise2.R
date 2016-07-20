#Load libraries
library(dplyr)
library(tidyr)

#Load Titanic data set
titanic_dataset <- read.csv("titanic_original.csv")

#Change empty strings in embarked to S
titanic_dataset$embarked[titanic_dataset$embarked == ''] <- "S"

#calculate mean of values in age and replace missing values with mean
age_mean <- mean(titanic_dataset$age, na.rm = TRUE)
titanic_dataset$age[is.na(titanic_dataset$age)] <- age_mean

#Replace all missing values in boat with NA
titanic_dataset$boat[titanic_dataset$boat == ""] <- NA

#Add dummy variable for those in a cabin
chg_cabin_number <- titanic_dataset$cabin %>% lapply(as.character) %>% 
  unlist()
titanic_dataset$has_cabin_number <- ifelse(nchar(chg_cabin_number) > 0, 1, 0)

#Export to csv
write.csv(titanic_dataset, "titanic_clean.csv")


