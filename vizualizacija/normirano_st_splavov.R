
zdruzeno <- left_join(data, average.population)

#pobrišemo vrstice imajo vrednost "NA"
row.has.na <- apply(zdruzeno, 1, function(x){any(is.na(x))})
zdruzeno <- zdruzeno[!row.has.na,]