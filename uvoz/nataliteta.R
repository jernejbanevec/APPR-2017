crude.birth.rate <- read_csv("crude_birth_rateCSV.csv", 
                             col_names = c("LETO", "DRAVA", "izbriši", "NATALITETA", "izbriši2"), 
                             skip = 1, na = '-', 
                             locale = locale(encoding = "Windows-1250"))
crude.birth.rate <- crude.birth.rate[c(2,1,4,3,5)]
crude.birth.rate$izbriši <-NULL 
crude.birth.rate$izbriši2 <-NULL 
