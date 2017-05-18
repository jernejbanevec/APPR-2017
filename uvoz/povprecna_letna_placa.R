library(readr)
library(reshape2)
library(dplyr)

average.annual.wage <- read_csv("podatki/average_annual_wage.csv", 
                                col_names = c("DRZAVA", "i1", "i2", "i3", "i4", "LETO", "POVPRECNA.LETNA.PLACA", "i5"), 
                                skip = 1, na = '-', 
                                locale = locale(encoding = "Windows-1250")) %>%
  select(DRZAVA, LETO, POVPRECNA.LETNA.PLACA)
average.annual.wage$`LETO` <- parse_number(average.annual.wage$`LETO`)
average.annual.wage$`POVPRECNA.LETNA.PLACA`<- parse_number(average.annual.wage$`POVPRECNA.LETNA.PLACA`)