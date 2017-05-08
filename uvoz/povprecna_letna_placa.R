library(readr)
library(reshape2)
library(dplyr)

average.annual.wage <- read_csv("podatki/average_annual_wage.csv", 
                                col_names = c("DRŽAVA", "i1", "i2", "i3", "i4", "LETO", "POVPREČNA LETNA PLAČA (v $)", "i5"), 
                                skip = 1, na = '-', 
                                locale = locale(encoding = "Windows-1250"))
average.annual.wage$i1 <- NULL
average.annual.wage$i2 <- NULL
average.annual.wage$i3 <- NULL
average.annual.wage$i4 <- NULL
average.annual.wage$i5 <- NULL
average.annual.wage$`LETO` <- as.numeric(average.annual.wage$`LETO`)
average.annual.wage$`POVPREČNA LETNA PLAČA (v $)`<- as.numeric(average.annual.wage$`POVPREČNA LETNA PLAČA (v $)`)
View(average.annual.wage)