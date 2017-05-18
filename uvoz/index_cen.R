library(readr)
library(reshape2)
library(dplyr)

consumer.price.index <- read_csv("podatki/consumer_price_index.csv", col_names = c("i", "p", "i2", "DRZAVA", "i3", "i4", "i5", "i6", "LETO", "i7", "i8", "STA", "i9", "i10", "i11", "i12", "INDEX.CEN", "i13", "i14"), 
                                 skip = 1, na = '-', 
                                 locale = locale(encoding = "UTF-8")) %>%
  filter(p == "Consumer prices - all items", STA == "Index") %>%
  select(DRZAVA, LETO, INDEX.CEN)

