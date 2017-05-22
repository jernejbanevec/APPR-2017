# 3. faza: Vizualizacija podatkov
library(ggplot2)
library(dplyr)
library(readr)
library(tibble)

#Uvozimo ZEMLJEVID

evropa <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                          "ne_50m_admin_0_countries", encoding = "UTF-8") %>%
  pretvori.zemljevid() %>% filter(continent == "Europe" | sovereignt %in% c("Turkey", "Cyprus"),
                                  long > -30, sovereignt != "Russia")

#prikaz zemljevida brez podatkov in oznak
ggplot() +  geom_polygon(data = evropa, aes(x = long, y = lat, group = group)) +
  coord_map(xlim = c(-25, 40), ylim = c(32, 72))

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

zdruzeno <- left_join(data, average.population)

#pobrišemo vrstice imajo vrednost "NA"
row.has.na <- apply(zdruzeno, 1, function(x){any(is.na(x))})
zdruzeno <- zdruzeno[!row.has.na,]

#stevilo splavov na 1000 prebivalcev drzave
nominalno.stevilo.splavov <- zdruzeno %>% 
  group_by(DRZAVA, LETO) %>% 
  summarise(NOM.STEVILO.SPLAVOV = STEVILO.SPLAVOV / POPULACIJA * 1000)
