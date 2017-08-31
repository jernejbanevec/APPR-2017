library(shiny)
library(DT)
shinyUI(fluidPage(
  
  titlePanel("Prikaz podatkov za posamezno državo"),
  
  selectInput(inputId = "DRZAVA",
              label = "Država",
              choices = unique(zdruzen$DRZAVA),
              selected = "Slovenia",
              multiple = FALSE),
  
  selectInput(inputId = "Vrsta",
              label = "Vrsta podatka",
              choices = unique(zdruzen$Vrsta),
              selected = "Nataliteta",
              multiple = TRUE),
  
  
  tabPanel("grafa",
           fluidRow(
             column(width = 6, plotOutput("g"), h4("Nataliteta in nominalno število splavov")),
             column(width = 6, plotOutput("g2"), h4("Povprečna realna letna plača"))
           ))
  
  
  
    
  ))
