# 3. faza: Vizualizacija podatkov
library(ggplot2)
library(dplyr)
library(readr)
library(tibble)
library(mapproj)

#Uvozimo ZEMLJEVID

evropa <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                          "ne_50m_admin_0_countries", encoding = "UTF-8") %>%
  pretvori.zemljevid() %>% filter(continent == "Europe" | sovereignt %in% c("Turkey", "Cyprus"),
                                  long > -30, sovereignt != "Russia")

#prikaz zemljevida brez podatkov in oznak

ggplot() +  geom_polygon(data = evropa, aes(x = long, y = lat, group = group)) +
  coord_map(xlim = c(-25, 40), ylim = c(32, 72))


#poskrbim da se ujemajo imena

evropa$name_sort <- gsub("^Slovak Republic$", "Slovakia", evropa$name_sort) %>% factor() #zemljevid

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

#graf, ki pokaže število splavov na 1000 prebivalcev za izbrane države

splavi <- ggplot(data = nominalno.stevilo.splavov %>% filter(DRZAVA %in% c("Portugal", "Slovenia", "Poland", "Romania")), aes(x = LETO, y = NOM.STEVILO.SPLAVOV)) + geom_point() + geom_line(col="red") + facet_wrap(~DRZAVA, ncol=4)

#graf, ki pokaže spreminjanje realne plače za Grčijo in Španijo, katere imata trenutno slabo finančno stanje ter Švico 

rojstva <- ggplot(data = crude.birth.rate %>% filter(DRZAVA %in% c("Greece", "Spain", "Switzerland")), aes(x = LETO, y = NATALITETA)) + geom_point() + geom_line(col="red") + facet_wrap(~DRZAVA, ncol=3)

#oznake na zemljevidu, katerih velikost pove realno plačo in barva število splavljenih otrok

ggplot() + geom_polygon(data = evropa %>%
                          left_join(nominalno.stevilo.splavov %>% filter(LETO == 2005),
                                    by = c("name_long" = "DRZAVA")),
                        aes(x = long, y = lat, group = group, fill = NOM.STEVILO.SPLAVOV)) +
  geom_point(data = evropa %>% filter(long >= -25, long <= 40, lat >= 32, lat <= 79) %>%
               group_by(name_long) %>% summarise(x = mean(long), y= mean(lat)) %>%
               inner_join(real.wage %>% filter(LETO == 2005), by = c("name_long" = "DRZAVA")),
             aes(x = x, y = y, size = REALNA.PLACA))+
  coord_map(xlim = c(-25, 40), ylim = c(32, 72))


#oznake na zemljevidu, katerih velikost pove realno plačo in število novorojenih otrok

ggplot() + geom_polygon(data = evropa %>%
                          left_join(crude.birth.rate %>% filter(LETO == 2005),
                                    by = c("name_long" = "DRZAVA")),
                        aes(x = long, y = lat, group = group, fill = NATALITETA)) +
  geom_point(data = evropa %>% filter(long >= -25, long <= 40, lat >= 32, lat <= 79) %>%
               group_by(name_long) %>% summarise(x = mean(long), y= mean(lat)) %>%
               inner_join(real.wage %>% filter(LETO == 2005), by = c("name_long" = "DRZAVA")),
             aes(x = x, y = y, size = REALNA.PLACA))+
  coord_map(xlim = c(-25, 40), ylim = c(32, 72))