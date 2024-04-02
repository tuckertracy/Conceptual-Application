#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(ggplot2)
library(tidyverse)
library(maps)
library(tigris)
library(tidycensus)
library(leaflet)
library(sf)

options(tigris_use_cache = TRUE)

census_api_key("9adfae9081c03f765d13d79f05a3f22646af0cdb")
readRenviron("~/.Renviron")

palette <- colorNumeric(palette = 'Blues',domain=NULL)

get_lat_lng <- function(dataframe) {
  dataframe$lng <- 0
  dataframe$lat <- 0
  
  for(i in 1:nrow(dataframe)) {
    dataframe[i,'lng'] <- (mean(st_coordinates(dataframe[i,])[,1]))
    dataframe[i,'lat'] <- (mean(st_coordinates(dataframe[i,])[,2]))
  }
  return(dataframe)
}

grad_or_prof <- get_acs(
  geography = "state",
  variables = "B06009_006", # Total graduate or professional degrees
  year = 2022,
  geometry = TRUE
) %>%
  st_transform('+proj=longlat +datum=WGS84')

grad_or_prof <- get_lat_lng(grad_or_prof)

median_age <- get_acs(
  geography = "state",
  variables = "B01002_001", # Median Age
  year = 2022,
  geometry = TRUE
) %>%
  st_transform('+proj=longlat +datum=WGS84')

median_age <- get_lat_lng(median_age)


monthly_ho_costs <- get_acs(
  geography = "state",
  variables = "B25105_001", # Monthly Home Owner costs
  year = 2022,
  geometry = TRUE
)%>%
  st_transform('+proj=longlat +datum=WGS84')

monthly_ho_costs <- get_lat_lng(monthly_ho_costs)


med_hh_income <- get_acs(
  geography = "state",
  variables = "B19013_001", # Median Household income
  year = 2022,
  geometry = TRUE
)%>%
  st_transform('+proj=longlat +datum=WGS84')

med_hh_income <- get_lat_lng(med_hh_income)


population <- get_acs(
  geography = "state",
  variables = "B01003_001", # total population
  year = 2022,
  geometry = TRUE
)%>%
  st_transform('+proj=longlat +datum=WGS84')

population <- get_lat_lng(population)


public_coverage <- get_acs(
  geography = "state",
  variables = "B27003_001", # Total Public Health Coverage
  year = 2022,
  geometry = TRUE
)%>%
  st_transform('+proj=longlat +datum=WGS84')

public_coverage <- get_lat_lng(public_coverage)


coverage_pct <- st_join(population, public_coverage, join = st_equals,left=T)
coverage_pct <- coverage_pct %>%
  mutate(estimate = round((estimate.y/estimate.x)*100,digits=2)) %>%
  rename(lat=lat.x,
         lng=lng.x,
         NAME = NAME.x)

degree_pct <- st_join(population, grad_or_prof, join = st_equals,left=T)
degree_pct <- degree_pct %>%
  mutate(estimate = round((estimate.y/estimate.x)*100,digits=2))%>%
  rename(lat=lat.x,
         lng=lng.x,
         NAME = NAME.x)



# # Define UI for application that draws a histogram
# ui <- fluidPage(
#
#     # Application title
#     titlePanel("Economic Indicator by State"),
#
#     # Sidebar with a slider input for number of bins
#     sidebarPanel(
#         selectInput("econ_ind",
#                   "Select Economic Indicator",
#                   choices = c("Median Age","Graduate or Professional Degree",
#                               "Homeowner Monthly Cost","Median Household Income",
#                               "Health Insurance Coverage (Public)",
#                               "Health Insurance Coverage (Private)")
#                   )
#         ),
#     # Show a plot of the generated distribution
#     mainPanel(
#       leafletOutput("indicator_plot")
#       )
#     )

ui <- fluidPage(
  
  navbarPage(
    "Berry College",
    id = 'var',
    navbarMenu("Indicator",
               tabPanel('Median Age'),
               tabPanel('Graduate or Professional Degree (%)'),
               tabPanel('Homeowner Monthly Cost ($)'),
               tabPanel('Median Household Income ($)'),
               tabPanel('Health Insurance Coverage (%)'),
               tabPanel('Population')
    )
  ),
  #leafletOutput("indicator_plot")
  mainPanel(leafletOutput('indicator_plot',height=600,width=850))
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
   # output$data <- renderText({
   #   paste("You have selected", input$var)
   # })
  
  
  data <- reactive({
    if(input$var=='Median Age') {
      median_age
    } else if (input$var=='Graduate or Professional Degree (%)') {
      degree_pct
    } else if(input$var=='Homeowner Monthly Cost ($)') {
      monthly_ho_costs
    } else if (input$var=='Median Household Income ($)') {
      med_hh_income
    } else if (input$var=='Health Insurance Coverage (%)') {
      coverage_pct
    } else if (input$var=='Population') {
      population
    }
  })
    
  
  output$indicator_plot <- renderLeaflet({
    leaflet(data()) |>
      addProviderTiles("CartoDB.Voyager") |>
      addPolygons(
        fillColor = ~ palette(estimate),
        fillOpacity = 0.75,
        weight = 2,
        color = 'black'
      ) |>
      addLegend(
        pal = palette,
        value = ~ estimate,
        title = 'Estimate'
      ) |>
      addMiniMap(toggleDisplay = TRUE) |>
      addCircleMarkers(data = data(), lat = ~lat, lng = ~lng,
                       fillOpacity = 0.8,
                       popup = paste(input$var,"in",data()$NAME,":",data()$estimate)) |>
      setView(lng=-95.706838, lat=40.358615, zoom=3.5)

  })
  }
  
  # Run the application 
  shinyApp(ui = ui, server = server)

###### ADD Navigation Bar WITH selectInput Feature ###### 
###### ADD other tabs to make the app more complete  ###### 
