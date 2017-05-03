library(readr)
library(reshape2)
library(dplyr)

crude.birth.rate <- read_csv("podatki/crude_birth_rateCSV.csv", 
                             col_names = c("LETO", "DRŽAVA", "i", "NATALITETA", "i2"), 
                             skip = 1, na = '-')
crude.birth.rate <- crude.birth.rate[c(2,1,4,3,5)]
crude.birth.rate$i <-NULL 
crude.birth.rate$i2 <-NULL
crude.birth.rate$`LETO` <- as.numeric(crude.birth.rate$`LETO`)
crude.birth.rate$`NATALITETA` <- as.numeric(crude.birth.rate$`NATALITETA`)
View(crude.birth.rate)
