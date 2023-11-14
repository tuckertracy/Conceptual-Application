library(shiny)
library(dplyr)
library(ggplot2)

# Define UI
ui <- fluidPage(
  
  theme = shinythemes::shinytheme("cerulean"),
  
  titlePanel("Bar Plot"),
  
  
  # Menu 
  selectInput("att", 
                  label = "Attribute", 
                  choices = c("grid",
                              "constructor_name",
                              "constructor_nationality",
                              "driverRef",
                              "driver_nationality")),
  # Check Boxes
  checkboxInput("descbox", label = "Descending Sort", value = FALSE),
  
  checkboxInput("ascbox", label = "Ascending Sort", value = FALSE),
  
  # Plot
  plotOutput("plot")
  )  

# Define server function
server <- function(input, output) {
  data<-read.csv("data.csv", stringsAsFactors = TRUE)
 output$plot <- renderPlot({
   
   # Make input column a factor
   data[,input$att] <- as.factor(data[,input$att])
   
   # Group data by selected attribute
   groups <- data%>%
     group_by(attribute = data[,input$att]) %>% 
     summarise(sum_points = sum(points)) %>% 
     arrange(desc(sum_points)) %>% 
     top_n(10)
  
   # Make bar chart depending on check box input
   if (input$descbox == TRUE) {
     groups$attribute <- factor(groups$attribute, levels = groups$attribute[order(groups$sum_points,decreasing = TRUE)])
     ggplot(data = groups, aes( x = attribute, y = sum_points)) + 
       geom_bar(stat = "identity", aes(fill = attribute)) + 
       theme_bw() + scale_fill_brewer(palette="Spectral")
   } else if (input$ascbox == TRUE) {
     groups$attribute <- factor(groups$attribute, levels = groups$attribute[order(groups$sum_points,decreasing = FALSE)])
     ggplot(data = groups, aes( x = attribute, y = sum_points)) + 
       geom_bar(stat = "identity", aes(fill = attribute)) + 
       theme_bw() + scale_fill_brewer(palette="Spectral")
   } else {
   ggplot(data = groups, aes( x = attribute, y = sum_points)) + 
       geom_bar(stat = "identity", aes(fill = attribute)) + 
       theme_bw() + scale_fill_brewer(palette="Spectral")
   }
 })
}

  # Create Shiny object
  shinyApp(ui = ui, server = server)
  