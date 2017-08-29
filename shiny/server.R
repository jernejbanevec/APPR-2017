library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  
  output$graf <- renderPlot({
    podatki <- filter(zdruzen, 
                      zdruzen$DRZAVA == input$DRZAVA,
                      zdruzen$VRSTA == input$VRSTA)
    
    graf.koncen <- qplot(x = LETO, y = KOLICINA, color = VRSTA, data = podatki, geom = "line")
    graf.koncen + xlab("Leto") + ylab("Količina")
  })
  
  
  
  
})
