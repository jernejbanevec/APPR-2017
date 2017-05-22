library(readr)
library(dplyr)

average.population <- read_csv("podatki/population.csv", 
                             col_names = c("LETO", "DRZAVA", "SORT.KOLICINA", "POPULACIJA", "i"), 
                             skip = 1, na =c("", " ", "-", ":")) %>% filter(SORT.KOLICINA == "Average population - total") %>%
  select(DRZAVA, LETO, POPULACIJA)   

crude.birth.rate$POPULACIJA <- parse_number(crude.birth.rate$NATALITETA)
crude.birth.rate$LETO <- parse_number(crude.birth.rate$LETO)
crude.birth.rate$DRZAVA <- gsub("^Germany.*$", "Germany", crude.birth.rate$DRZAVA)