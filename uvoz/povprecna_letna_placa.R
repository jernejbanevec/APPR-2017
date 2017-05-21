library(readr)
library(dplyr)

average.annual.wage <- read_csv("podatki/average_annual_wage.csv", 
                                col_names = c("i1", "DRZAVA", "i2", "i3", "LETO", "i4", "i5", "i6", "i7", "i8", "i9", "i10","POVPRECNA.LETNA.PLACA", "i11", "i12"), 
                                skip = 1, na = '-', 
                                locale = locale(encoding = "Windows-1250")) %>%
  select(DRZAVA, LETO, POVPRECNA.LETNA.PLACA)
average.annual.wage$`LETO` <- parse_number(average.annual.wage$`LETO`)
average.annual.wage$`POVPRECNA.LETNA.PLACA`<- parse_number(average.annual.wage$`POVPRECNA.LETNA.PLACA`)