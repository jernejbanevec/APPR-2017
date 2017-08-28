# 4. faza: Analiza podatkov
library(ggplot2)
library(dplyr)
library(readr)
library(tibble)
library(mapproj)
library(GGally)
library(rvest)
library(digest)
library(shiny)
library(reshape2)

#PRIKAZ in poračun KORELACIJ

#TABELE, KI NISO VEČ TIDY DATA
#preureditev podatkov, ker se odločitev za otroka pozna pri naslednjem letu
crude.birth.rate.upgraded <- crude.birth.rate
crude.birth.rate.upgraded$LETO <- crude.birth.rate.upgraded$LETO + 1

# Tabela, z meritvama "NATALITETA" ter "REALNA.PLACA"
zdruzen.korelacija.nataliteta <- inner_join(crude.birth.rate.upgraded, real.wage, by = c("DRZAVA", "LETO"));

#Tabela, z meritvama "NOM.STEVILO.SPLAVOV" ter "REALNA.PLACA"
zdruzen.korelacija.splavi <- inner_join(nominalno.stevilo.splavov, real.wage, by = c("DRZAVA", "LETO"));


#KORELACIJE NATALITETA

#IZRAČUN KORELACIJE VSEH DRŽAV 
#tabeli pobrišemo prva 2 stolpca, ki nista pomembna za izračun korelacije
zdruzen.korelacija1 <- zdruzen.korelacija.nataliteta %>% select(NATALITETA, REALNA.PLACA);

#Iz matrike ki jo dobimo ko uporabimo funkcijo cor pridobimo podatek o Pearsonovem korelacijskem koeficientu (privzeta metoda)
korelacija.nataliteta <- cor(zdruzen.korelacija1)[1,2];

#lahko narišemo graf linearnega prileganja, brez intervala zaupanja
graf.korelacije.natalitete <- ggplot(zdruzen.korelacija1, aes(x=REALNA.PLACA, y=NATALITETA)) + geom_point() + geom_smooth(method = "lm", se=FALSE);

#poračunamo koeficient naklona premice 
lin <- lm(data = zdruzen.korelacija1, NATALITETA ~ REALNA.PLACA)


#alternativen izračun koeficienta naklona z uporabo znanja iz verjetnosti in statistike, kjer poračunamo še vzorčni standartni odklon za obe spremenljivki s korenjenjem variance
varianca.place <- var(zdruzen.korelacija1$REALNA.PLACA)
varianca.natalitete <- var(zdruzen.korelacija1$NATALITETA)
alternativen.koeficient.korelacije <- korelacija.nataliteta * (varianca.place)^(-0.5) * (varianca.natalitete)^(0.5)

#IZRAČUN KORELACIJE ZA IZBRANE DRŽAVE(ŠPANIJA, GRČIJA, ITALIJA, PORTUGALSKA) slabše finančno stanje
zdruzen.korelacija2 <- zdruzen.korelacija.nataliteta %>% filter(DRZAVA == "Spain"|DRZAVA == "Portugal"|DRZAVA == "Italy"|DRZAVA == "Greece") %>% select(NATALITETA, REALNA.PLACA);
korelacija.nataliteta.slabse <- cor(zdruzen.korelacija2)[1,2]
graf.korelacije.natalitete.izbrane <- ggplot(zdruzen.korelacija2, aes(x=REALNA.PLACA, y=NATALITETA)) + geom_point() + geom_smooth(method = "lm", se=FALSE);

#IZRAČUN KORELACIJE ZA IZBRANE DRŽAVE(ŠVICA, DANSKA, NEMČIJA, ŠVEDSKA) boljše finančno stanje
zdruzen.korelacija3 <- zdruzen.korelacija.nataliteta %>% filter(DRZAVA == "Sweden"|DRZAVA == "Germany"|DRZAVA == "Denmark"|DRZAVA == "Switzerland") %>% select(NATALITETA, REALNA.PLACA);
korelacija.nataliteta.boljse <- cor(zdruzen.korelacija3)[1,2]
graf.korelacije.natalitete.izbrane <- ggplot(zdruzen.korelacija3, aes(x=REALNA.PLACA, y=NATALITETA)) + geom_point() + geom_smooth(method = "lm", se=FALSE);

#največja korelacija
zdruzen.korelacija.max <- zdruzen.korelacija.nataliteta %>% filter(DRZAVA == "Netherlands") %>% select(NATALITETA, REALNA.PLACA);
najvecja.korelacija <- cor(zdruzen.korelacija.max)[1,2]
graf.korelacije.nizozemska <- ggplot(zdruzen.korelacija.max, aes(x=REALNA.PLACA, y=NATALITETA)) + geom_point() + geom_smooth(method = "lm", se=FALSE);
#najničja korelacija
zdruzen.korelacija.min <- zdruzen.korelacija.nataliteta %>% filter(DRZAVA == "Slovenia") %>% select(NATALITETA, REALNA.PLACA);
najmanjsa.korelacija <- cor(zdruzen.korelacija.min)[1,2]
graf.korelacije.slovenia <- ggplot(zdruzen.korelacija.min, aes(x=REALNA.PLACA, y=NATALITETA)) + geom_point() + geom_smooth(method = "lm", se=FALSE);

#KORELACIJE SPLAVI (splav se naredi v prvih sedmih do desetih tednih, zato ne prištevam leta)

#odštejemo prva dva nepomembna stolpca in izločimo države ki imajo oz so imele v tem obdobju prepovedane splave
zdruzen.splavi1 <- zdruzen.korelacija.splavi %>% filter(DRZAVA != "Portugal" & DRZAVA != "Poland")
zdruzen.splavi1$DRZAVA <- NULL
zdruzen.splavi1$LETO <- NULL


#Iz matrike ki jo dobimo ko uporabimo funkcijo cor pridobimo podatek o Pearsonovem korelacijskem koeficientu (privzeta metoda)
korelacija.splavi <- cor(zdruzen.splavi1)[1,2];

#lahko narišemo graf linearnega prileganja, brez intervala zaupanja
graf.korelacije.splavi <- ggplot(zdruzen.splavi1, aes(x=REALNA.PLACA, y=NOM.STEVILO.SPLAVOV)) + geom_point() + geom_smooth(method = "lm", se=FALSE);

#poračunamo koeficient naklona premice 
lin <- lm(data = zdruzen.splavi1, NOM.STEVILO.SPLAVOV~REALNA.PLACA)


#IZRAČUN KORELACIJE ZA IZBRANE DRŽAVE(ŠPANIJA, GRČIJA, ITALIJA, PORTUGALSKA) slabše finančno stanje
zdruzen.korelacija.splavi2 <- zdruzen.korelacija.splavi %>% filter(DRZAVA == "Spain"|DRZAVA == "Italy"|DRZAVA == "Greece");
zdruzen.korelacija.splavi2$DRZAVA <- NULL
zdruzen.korelacija.splavi2$LETO <- NULL
korelacija.splavi.slabse <- cor(zdruzen.korelacija.splavi2)[1,2]
graf.korelacije.splavi.izbrane2 <- ggplot(zdruzen.korelacija.splavi2, aes(x=NOM.STEVILO.SPLAVOV, y=REALNA.PLACA)) + geom_point() + geom_smooth(method = "lm", se=FALSE);

#IZRAČUN KORELACIJE ZA IZBRANE DRŽAVE(ŠVICA, DANSKA, NEMČIJA, ŠVEDSKA) boljše finančno stanje
zdruzen.korelacija.splavi3 <- zdruzen.korelacija.splavi %>% filter(DRZAVA == "Sweden"|DRZAVA == "Germany"|DRZAVA == "Denmark"|DRZAVA == "Switzerland");
zdruzen.korelacija.splavi3$DRZAVA <- NULL
zdruzen.korelacija.splavi3$LETO <- NULL
korelacija.splavi.boljse <- cor(zdruzen.korelacija.splavi3)[1,2]
graf.korelacije.splavi.izbrane3 <- ggplot(zdruzen.korelacija.splavi3, aes(x=NOM.STEVILO.SPLAVOV, y=REALNA.PLACA)) + geom_point() + geom_smooth(method = "lm", se=FALSE);

#največja korelacija
zdruzen.korelacija.splavi.max <- zdruzen.korelacija.splavi %>% filter(DRZAVA == "Germany");
zdruzen.korelacija.splavi.max$DRZAVA <- NULL
zdruzen.korelacija.splavi.max$LETO <- NULL
najvecja.korelacija.splavi <- cor(zdruzen.korelacija.splavi.max)[1,2]
graf.korelacije.nemčija <- ggplot(zdruzen.korelacija.splavi.max, aes(x=REALNA.PLACA, y=NOM.STEVILO.SPLAVOV)) + geom_point() + geom_smooth(method = "lm", se=FALSE);

#najnižja korelacija
zdruzen.korelacija.splavi.min <- zdruzen.korelacija.splavi %>% filter(DRZAVA == "Belgium");
zdruzen.korelacija.splavi.min$DRZAVA <- NULL
zdruzen.korelacija.splavi.min$LETO <- NULL
najmanjsa.korelacija.splavi <- cor(zdruzen.korelacija.splavi.min)[1,2]
graf.korelacije.Belgija <- ggplot(zdruzen.korelacija.splavi.min, aes(x=REALNA.PLACA, y=NOM.STEVILO.SPLAVOV)) + geom_point() + geom_smooth(method = "lm", se=FALSE);

#naredim novo tabelo, katera mi bo pomagala pri izdelavi shiny-a 
zdruzen.korelavija.splavi1 <- zdruzen.korelacija.splavi
zdruzen.korelavija.splavi1$REALNA.PLACA <- NULL
zdruzen1 <- inner_join(zdruzen.korelacija.nataliteta, zdruzen.korelavija.splavi1, by = c("DRZAVA", "LETO"))
zdruzen1$REALNA.PLACA <- zdruzen1$REALNA.PLACA / 10000
zdruzen1 <- zdruzen1[c(1,2,3,5,4)]

#naredimo tidy data
zdruzen <- melt(zdruzen1, id.vars = c("DRZAVA","LETO"), measure.vars = names(zdruzen1)[-1][-1], variable_name = "VRSTA", value.name = "KOLICINA", na.rm = TRUE)
zdruzen$VRSTA <- zdruzen$variable
zdruzen$variable <- NULL
zdruzen <- zdruzen[c(1,2,4,3)]