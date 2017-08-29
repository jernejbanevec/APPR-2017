# 2. faza: Uvoz podatkov

#CELOTEN UVOZ VSEH PODARTKOV

library(readr)
library(dplyr)
library(rvest)


#tabela indeksa cen
consumer.price.index <- read_csv("podatki/consumer_price_index.csv", col_names = c("i", "p", "i2", "DRZAVA", "i3", "i4", "i5", "i6", "LETO", "i7", "i8", "STA", "i9", "i10", "i11", "i12", "INDEX.CEN", "i13", "i14"), 
                                 skip = 1, na = '-', 
                                 locale = locale(encoding = "UTF-8")) %>%
  filter(p == "Consumer prices - all items", STA == "Index") %>%
  select(DRZAVA, LETO, INDEX.CEN)


#tabela povprečne letna plače v dolarjih
average.annual.wage <- read_csv("podatki/average_annual_wage.csv", 
                                col_names = c("i1", "DRZAVA", "i2", "i3", "LETO", "i4", "i5", "i6", "i7", "i8", "i9", "i10","POVPRECNA.LETNA.PLACA", "i11", "i12"), 
                                skip = 1, na = '-', 
                                locale = locale(encoding = "Windows-1250")) %>%
  select(DRZAVA, LETO, POVPRECNA.LETNA.PLACA)
average.annual.wage$`LETO` <- parse_number(average.annual.wage$`LETO`)
average.annual.wage$`POVPRECNA.LETNA.PLACA`<- parse_number(average.annual.wage$`POVPRECNA.LETNA.PLACA`)


#tabela natalitete (število rojenih na 1000 ljudi)
crude.birth.rate <- read_csv("podatki/crude_birth_rateCSV.csv", 
                             col_names = c("LETO", "DRZAVA", "i", "NATALITETA", "i2"), 
                             skip = 1, na =c("", " ", "-", ":")) %>%
  select(DRZAVA, LETO, NATALITETA)   

crude.birth.rate$NATALITETA <- parse_number(crude.birth.rate$NATALITETA)
crude.birth.rate$LETO <- parse_number(crude.birth.rate$LETO)
crude.birth.rate$DRZAVA <- gsub("^Germany.*$", "Germany", crude.birth.rate$DRZAVA)


#tabela števila splavov za določene države
xml <- file("podatki/stevilo_splavov.xml") %>% read_xml()
records <- xml %>% xml_nodes(xpath="//record")
fields <- records[[1]] %>% xml_nodes(xpath="./field") %>% xml_attr("name")
data <- sapply(fields[-length(fields)], function(x) {     sapply(records, . %>% xml_nodes(xpath=sprintf("./field[@name='%s']", x)) %>%      xml_contents() %>% as.character()) }) %>% data.frame()
names(data) <- c("DRZAVA", "LETO", "i1", "i2", "i3", "i4", "STEVILO.SPLAVOV")
data$i1 <- NULL
data$i2 <- NULL
data$i3 <- NULL
data$i4 <- NULL
data$LETO <- parse_number(data$LETO)
data$`STEVILO.SPLAVOV`<- parse_number(data$`STEVILO.SPLAVOV`)
data$DRZAVA <- gsub("United Kingdom of Great Britain and Northern Ireland", "United Kingdom", data$DRZAVA)
data$DRZAVA <- gsub("Czechia", "Czech Republic", data$DRZAVA)
data$DRZAVA <- gsub("Russian Federation", "Russia", data$DRZAVA)


#tabela števila prebivalcev za določene države za določeno leto
average.population <- read_csv("podatki/population.csv", 
                               col_names = c("LETO", "DRZAVA", "SORT.KOLICINA", "POPULACIJA", "i"), 
                               skip = 1, na =c("", " ", "-", ":")) %>% filter(SORT.KOLICINA == "Average population - total") %>%
  select(DRZAVA, LETO, POPULACIJA)   



average.population$LETO <- parse_number(average.population$LETO)
average.population$DRZAVA <- gsub("^Germany.*$", "Germany", average.population$DRZAVA)
average.population$POPULACIJA <-gsub(",","",average.population$POPULACIJA)
average.population$POPULACIJA <- parse_number(average.population$POPULACIJA)

# REALNA PLACA ZA DOLOČENO DRZAVO NA DOLOCENO LETO GLEDE NA DEN INDEX CEN (zaenkrat zgolj podatki)

sestavljen.data.frame <- left_join(average.annual.wage, consumer.price.index);

#pobrišemo vrstice imajo vrednost "NA"
row.has.na <- apply(sestavljen.data.frame, 1, function(x){any(is.na(x))})
sestavljen.data.frame <- sestavljen.data.frame[!row.has.na,]

#stevilo splavov na 1000 prebivalcev drzave
real.wage <- sestavljen.data.frame %>% 
  group_by(DRZAVA, LETO) %>% 
  summarise(REALNA.PLACA = POVPRECNA.LETNA.PLACA / INDEX.CEN * 100)



#NOMINALNO STEVILO SPLAVOV NA 1000 PREBIVALCEV (zaenkrat zgolj podatki)

zdruzeno <- left_join(data, average.population);

#pobrišemo vrstice imajo vrednost "NA"
row.has.na <- apply(zdruzeno, 1, function(x){any(is.na(x))})
zdruzeno <- zdruzeno[!row.has.na,]

#stevilo splavov na 1000 prebivalcev drzave
nominalno.stevilo.splavov <- zdruzeno %>% 
  group_by(DRZAVA, LETO) %>% 
  summarise(NOM.STEVILO.SPLAVOV = STEVILO.SPLAVOV / POPULACIJA * 1000)
