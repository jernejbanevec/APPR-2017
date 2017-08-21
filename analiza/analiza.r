# 4. faza: Analiza podatkov

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
graf.korelacije.natalitete <- ggplot(zdruzen.korelacija1, aes(x=NATALITETA, y=REALNA.PLACA)) + geom_point() + geom_smooth(method = "lm", se=FALSE);

#poračunamo koeficient naklona premice 
lin <- lm(data = zdruzen.korelacija1, NATALITETA ~ REALNA.PLACA)


#alternativen izračun koeficienta naklona z uporabo znanja iz verjetnosti in statistike, kjer poračunamo še vzorčni standartni odklon za obe spremenljivki s korenjenjem variance
varianca.place <- var(zdruzen.korelacija1$REALNA.PLACA)
varianca.natalitete <- var(zdruzen.korelacija1$NATALITETA)
alternativen.koeficient.korelacije <- korelacija.nataliteta * (varianca.place)^(-0.5) * (varianca.natalitete)^(0.5)

#IZRAČUN KORELACIJE ZA IZBRANE DRŽAVE(ŠPANIJA, GRČIJA, ITALIJA, PORTUGALSKA) slabše finančno stanje
zdruzen.korelacija2 <- zdruzen.korelacija.nataliteta %>% filter(DRZAVA == "Spain"|DRZAVA == "Portugal"|DRZAVA == "Italy"|DRZAVA == "Greece") %>% select(NATALITETA, REALNA.PLACA);
korelacija.nataliteta.slabse <- cor(zdruzen.korelacija2)[1,2]
graf.korelacije.natalitete.izbrane <- ggplot(zdruzen.korelacija2, aes(x=NATALITETA, y=REALNA.PLACA)) + geom_point() + geom_smooth(method = "lm", se=FALSE);

#IZRAČUN KORELACIJE ZA IZBRANE DRŽAVE(ŠVICA, DANSKA, NEMČIJA, ŠVEDSKA) boljše finančno stanje
zdruzen.korelacija3 <- zdruzen.korelacija.nataliteta %>% filter(DRZAVA == "Sweden"|DRZAVA == "Germany"|DRZAVA == "Denmark"|DRZAVA == "Switzerland") %>% select(NATALITETA, REALNA.PLACA);
korelacija.nataliteta.boljse <- cor(zdruzen.korelacija3)[1,2]
graf.korelacije.natalitete.izbrane <- ggplot(zdruzen.korelacija3, aes(x=NATALITETA, y=REALNA.PLACA)) + geom_point() + geom_smooth(method = "lm", se=FALSE);

#največja korelacija
zdruzen.korelacija.max <- zdruzen.korelacija.nataliteta %>% filter(DRZAVA == "Netherlands") %>% select(NATALITETA, REALNA.PLACA);
najvecja.korelacija <- cor(zdruzen.korelacija.max)[1,2]
graf.korelacije.nizozemska <- ggplot(zdruzen.korelacija.max, aes(x=NATALITETA, y=REALNA.PLACA)) + geom_point() + geom_smooth(method = "lm", se=FALSE);
#najničja korelacija
zdruzen.korelacija.min <- zdruzen.korelacija.nataliteta %>% filter(DRZAVA == "Slovenia") %>% select(NATALITETA, REALNA.PLACA);
najmanjsa.korelacija <- cor(zdruzen.korelacija.min)[1,2]
graf.korelacije.slovenia <- ggplot(zdruzen.korelacija.min, aes(x=NATALITETA, y=REALNA.PLACA)) + geom_point() + geom_smooth(method = "lm", se=FALSE);

#KORELACIJE SPLAVI (splav se naredi v prvih sedmih tednih, zato ne prištevam leta)

#odštejemo prva dva nepomembna stolpca
zdruzen.splavi1 <- zdruzen.korelacija.splavi %>% filter(DRZAVA != "Portugal"|DRZAVA != "Poland") %>% select(NOM.STEVILO.SPLAVOV, REALNA.PLACA);

