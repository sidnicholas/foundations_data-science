#Load dplyr and tidyr
library(dplyr)
library(tidyr)

#Load the data in RStudio
refine <- read.csv("refine_original.csv")

#Clean up the company column
Philips <- gsub(pattern = "(^f|F|p|P).*", replacement = "Philips", x = refine$company)
Akzo <- gsub(pattern = "(^a|A).*", replacement = "Akzo", x = Philips)
Van <- gsub(pattern = "(^v|V).*", replacement = "Van Houten", x = Akzo)
Unilever <-gsub(pattern = "(^u|U).*", replacement = "Unilever", x = Van)
#Add Unilever to the refine dataframe
refine$company <- Unilever
#Seperate the product code and number and add column names
sep_prod <- refine %>% separate(Product.code...number, c("product_code", "product_number"), sep = "-")

#create new column based on product codes
prod_p <- gsub(pattern = "p", replacement = "SmartPhone", x = sep_prod$product_code)
prod_v <- gsub(pattern = "v", replacement = "TV", x = prod_p)
prod_x <- gsub(pattern = "x", replacement = "Laptop", x = prod_v)
prod_q <- gsub(pattern = "q", replacement = "Tablet", x = prod_x)
#append category variable to data frame
sep_prod$product_category <- prod_q

#Move category to the third position in the data frame
refine <- sep_prod[c(1, 2, 3, 8, 4, 5, 6, 7)]

#create a new varialbe that combines address, city and state
refine$full_address <- paste(refine$address, refine$city, refine$country, sep = ", ")

#create dummy variables for company
refine$company_philips <- ifelse(refine$company == "Philips", 1, 0)
refine$company_azko <- ifelse(refine$company == "Azko", 1, 0)
refine$company_van_houten <- ifelse(refine$company == "Van Houten", 1, 0)
refine$company_unilever <- ifelse(refine$company == "Unilever", 1, 0)

#create dummy variables for product categories
refine$product_smartphone <- ifelse(refine$product_category == "SmartPhone", 1, 0)
refine$product_tv <- ifelse(refine$product_category == "TV", 1, 0)
refine$product_laptop <- ifelse(refine$product_category == "Laptop", 1, 0)
refine$product_tablet <- ifelse(refine$product_category == "Tablet", 1, 0)
write.csv(refine, "refine_clean.csv")
