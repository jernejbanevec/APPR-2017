library(readr)
library(dplyr)

crude.birth.rate <- read_csv("podatki/crude_birth_rateCSV.csv", 
                             col_names = c("LETO", "DRZAVA", "i", "NATALITETA", "i2"), 
                             skip = 1, na =c("", " ", "-", ":")) %>%
  select(DRZAVA, LETO, NATALITETA)   

crude.birth.rate$NATALITETA <- parse_number(crude.birth.rate$NATALITETA)
crude.birth.rate$LETO <- parse_number(crude.birth.rate$LETO)
crude.birth.rate$DRZAVA <- gsub("^Germany.*$", "Germany", crude.birth.rate$DRZAVA)
