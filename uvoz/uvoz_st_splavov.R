library(rvest)
xml <- file("stevilo_splavov_1.xml") %>% read_xml()
records <- xml %>% xml_nodes(xpath="//record")
fields <- records[[1]] %>% xml_nodes(xpath="./field") %>% xml_attr("name")
data <- sapply(fields[-length(fields)], function(x) {
  +     sapply(records, . %>% xml_nodes(xpath=sprintf("./field[@name='%s']", x)) %>%
                 +                xml_contents() %>% as.character())
  + }) %>% data.frame()
names(data) <- c("DRŽAVA", "LETO", "i1", "i2", "i3", "i4", "ŠTEVILO SPLAVOV")
data$i1 <- NULL
data$i2 <- NULL
data$i3 <- NULL
data$i4 <- NULL
data$LETO <- as.numeric(data$LETO)
data$`ŠTEVILO SPLAVOV`<- as.numeric(data$`ŠTEVILO SPLAVOV`)
View(data)
