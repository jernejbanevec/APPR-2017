library(shiny)
library(DT)

shinyUI(fluidPage(
  
  titlePanel("Prikaz podatkov za posamezno državo"),
  
  selectInput(inputId = "DRZAVA",
              label = "Država",
              choices = unique(zdruzen$DRZAVA),
              selected = "Slovenia",
              multiple = FALSE),
  
  checkboxInput(inputId = "NATALITETA",
                label = strong("Nataliteta"),
                value = FALSE),
  
  checkboxInput(inputId = "NOM.STEVILO.SPLAVOV",
                label = strong("Nominalno število splavov"),
                value = FALSE)
  
  
  
    
  ))
