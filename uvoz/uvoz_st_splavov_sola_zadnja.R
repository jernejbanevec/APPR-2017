library(rvest)
library(readr)
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
data$`STEVILO SPLAVOV`<- parse_number(data$`STEVILO.SPLAVOV`)
