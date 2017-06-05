# REALNA PLACA ZA DOLOČENO DRZAVO NA DOLOCENO LETO GLEDE NA DEN INDEX CEN

sestavljen.data.frame <- left_join(average.annual.wage, consumer.price.index);

#pobrišemo vrstice imajo vrednost "NA"
row.has.na <- apply(sestavljen.data.frame, 1, function(x){any(is.na(x))})
sestavljen.data.frame <- sestavljen.data.frame[!row.has.na,]

#stevilo splavov na 1000 prebivalcev drzave
real.wage <- sestavljen.data.frame %>% 
  group_by(DRZAVA, LETO) %>% 
  summarise(REALNA.PLACA = POVPRECNA.LETNA.PLACA / INDEX.CEN * 100)
