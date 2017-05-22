library(readr)
library(dplyr)

average.population <- read_csv("podatki/population.csv", 
                             col_names = c("LETO", "DRZAVA", "SORT.KOLICINA", "POPULACIJA", "i"), 
                             skip = 1, na =c("", " ", "-", ":")) %>% filter(SORT.KOLICINA == "Average population - total") %>%
  select(DRZAVA, LETO, POPULACIJA)   



average.population$LETO <- parse_number(average.population$LETO)
average.population$DRZAVA <- gsub("^Germany.*$", "Germany", average.population$DRZAVA)
average.population$POPULACIJA <-gsub(",","",average.population$POPULACIJA)
average.population$POPULACIJA <- parse_number(average.population$POPULACIJA)

row.has.na <- apply(average.population, 1, function(x){any(is.na(x))})
average.population <- average.population[!row.has.na,]