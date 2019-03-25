library(dplyr)
library(tidyverse)

titanic_data <- as.data.frame(read.csv(file = "/Users/Rhubarbking1/Documents/practice/titanic_original.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE))

#replace missing values in "embarked" column with "S"
titanic_data <- mutate(titanic_data, 
                      embarked1 = case_when(embarked != "S" & embarked != "C" & embarked != "Q" ~ "S", 
                      TRUE ~ as.character(embarked)))

titanic_data <- mutate(titanic_data, embarked = embarked1)

titanic_data$embarked1 <- NULL

#calculate mean of age column
#replace missing values in age column with mean age
titanic_data <- mutate_at(titanic_data, vars(age), ~ifelse(is.na(.x), mean(.x, na.rm = TRUE), .x))

#fill missing values in lifeboat column with "None" or "NA"
titanic_data <- mutate_at(titanic_data, vars(boat), ~ifelse(boat == "" | boat == " ", NA, boat))

#create new column "has_cabin_number" - binary value based on whether there is a cabin number
titanic_data <- mutate(titanic_data, has_cabin_number = ifelse(cabin == "" | cabin == " ", 0, 1))

write.csv(titanic_data, "/Users/Rhubarbking1/Documents/practice/titanic_clean.csv")


