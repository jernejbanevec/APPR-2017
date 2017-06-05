library(readr)
library(dplyr)

crude.birth.rate <- read_csv("podatki/crude_birth_rateCSV.csv", 
                             col_names = c("LETO", "DRZAVA", "i", "NATALITETA", "i2"), 
                             skip = 1, na =c("", " ", "-", ":")) %>%
  select(DRZAVA, LETO, NATALITETA)   

crude.birth.rate$NATALITETA <- parse_number(crude.birth.rate$NATALITETA)
crude.birth.rate$LETO <- parse_number(crude.birth.rate$LETO)
<<<<<<< HEAD
crude.birth.rate$DRZAVA <- gsub("^Germany (including former GDR)*$", "Germany", crude.birth.rate$DRZAVA)
=======
crude.birth.rate$DRZAVA <- gsub("^Germany.*$", "Germany", crude.birth.rate$DRZAVA)
>>>>>>> 2e73097a309de6be602f84a928707c94db2045a0
