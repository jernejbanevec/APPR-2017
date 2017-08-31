library(shiny)
library(ggplot2)
library(dplyr)
shinyServer(function(input, output) {
  
  output$g <- renderPlot({
    
    podatki.prvi.graf <- zdruzen %>% filter(DRZAVA == input$DRZAVA,
                                  Vrsta == input$Vrsta)
    
    
    
    qplot(x = LETO, y = KOLICINA, color = Vrsta, data = podatki.prvi.graf, geom = "line") + xlab("Leto") + ylab("Število oseb")
  })
  
  output$g2 <- renderPlot({
    
    podatki.drugi.graf <- zdruzen %>% filter(DRZAVA == input$DRZAVA)
    
    qplot(x = LETO, y = REALNA.PLACA, data = podatki.drugi.graf, geom = "line") + xlab("Leto") + ylab("Realna plača (v dolarjih)")
  })
  
  
})
