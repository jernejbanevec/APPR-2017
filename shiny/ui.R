library(shiny)
library(DT)

shinyUI(fluidPage(
  
  titlePanel("Prikaz podatkov za posamezno državo"),
  
  selectInput(inputId = "DRZAVA",
              label = "Država",
              choices = unique(zdruzen$DRZAVA),
              selected = "Slovenia",
              multiple = FALSE),
  
  selectInput(inputId = "VRSTA",
              label = "Vrsta podatka",
              choices = unique(zdruzen$VRSTA),
              selected = "Realna plača (v 10000 dolarjih)",
              multiple = TRUE),
  
  plotOutput(outputId = "graf")
  
  
  
    
  ))
