# Analiza podatkov s programom R, 2016/17

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2016/17

## Tematika

Za tematiko svojega projekta sem izbral analizo morebitne povezanosti med povprečno realno mesečno plačo (v določenem letu) in odločanjem parov za otroke oz nataliteto (številom, ki pove, koliko (živih) otrok se rodi v letu na tisoč prebivalcev) v določenem letu. Realno mesečno plačo bi primerjal tudi s številom splavov v določeni državi za določeno leto. Pri analizi podatkov vem, da bom moral biti pozoren na dejstvo, da se v odločitev para za otroka lahko pozna komaj naslednje leto, ko pa je povprečna realna mesečna plača lahko že drugačna. Zavedam se tudi, da obstaja možnost ničelne oz. zelo šibke korelacije med zgornjimi spremenljivkami.

1. TABELA: Povprečna neto mesečna plača za določeno državo
* 1. stolpec: Leto
* 2. stolpec: Država
* 3. stolpec ali meritev: Povprečna neto mesečna plača

2. TABELA: Indeks cen (consumer price index) za določeno državo
* 1. stolpec: Leto
* 2. stolpec: Država
* 3. stolpec ali meritev: Indeks cen

3. TABELA: Nataliteta za določeno državo
* 1. stolpec: Leto
* 2. stolpec: Država
* 3. stolpec ali meritev: Nataliteta

4. TABELA: Število splavov za določeno državo
* 1. stolpec: Leto
* 2. stolpec: Država
* 3. stolpec ali meritev: Število splavov



## Podatki

Podatki bodo za časovno obdobje od leta 2000 do 2015 naprej za Evropske države, razen pri številu splavov mogoče krajše časovno obdobje. Podatke bom pa črpal iz naslednjih virov:
* http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=05J1002S&ti=&path=../Database/Dem_soc/05_prebivalstvo/30_Rodnost/05_05J10_rojeni_SL/&lang=2 (CSV)
* http://ec.europa.eu/eurostat/tgm/table.do?tab=table&init=1&language=en&pcode=tps00111&plugin=1 (CSV)
* http://ec.europa.eu/eurostat/tgm/table.do?tab=table&init=1&language=en&pcode=tps00112&plugin=1 (CSV)
* http://data.un.org/Data.aspx?q=abortion&d=POP&f=tableCode%3a17 (XML)
* http://www.un.org/esa/population/publications/2011abortion/2011abortionwallchart.html (CSV)
* http://www.un.org/en/development/desa/population/publications/policy/world-abortion-policies-2013.shtml (CSV)
* http://www.un.org/esa/population/publications/2007_Abortion_Policies_Chart/2007AbortionPolicies_wallchart.htm (CSV)

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
