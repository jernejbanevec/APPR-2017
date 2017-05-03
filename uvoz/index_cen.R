consumer.price.index <- read_csv("consumer_price_index.csv", 
                                 +                              col_names = c("i", "p", "i2", "DRŽAVA", "i3", "i4", "i5", "i6", "LETO", "i7", "i8", "ŠTA", "i9", "i10", "i11", "i12", "INDEX CEN", "i13", "i14"), 
                                 +                              skip = 1, na = '-', 
                                 +                              locale = locale(encoding = "Windows-1250"))

consumer.price.index$i1 <- NULL
consumer.price.index$i2 <- NULL
consumer.price.index$i3 <- NULL
consumer.price.index$i4 <- NULL
consumer.price.index$i5 <- NULL
consumer.price.index$i6 <- NULL
consumer.price.index$i7 <- NULL
consumer.price.index$i8 <- NULL
consumer.price.index$i9 <- NULL
consumer.price.index$i10 <- NULL
consumer.price.index$i11 <- NULL
consumer.price.index$i12 <- NULL
consumer.price.index$i13 <- NULL
consumer.price.index$i14 <- NULL
consumer.price.index$i <- NULL
consumer.price.index <- consumer.price.index %>% filter(consumer.price.index$p == "Consumer prices - all items")
consumer.price.index <- consumer.price.index %>% filter(consumer.price.index$ŠTA == "Index")
consumer.price.index$p <- NULL
consumer.price.index$ŠTA <- NULL

