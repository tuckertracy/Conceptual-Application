install.packages("tidycensus")
library(tidycensus)

install.packages("crimedata")
library(crimedata)

library(maps)
library(ggplot2)

library(tidyverse)
library(tigris)

install.packages('leaflet')
library(leaflet)

library(viridis)

library(sf)


us_geo_data <- map_data('state')


census_api_key("9adfae9081c03f765d13d79f05a3f22646af0cdb", install = TRUE)
readRenviron("~/.Renviron")

options(tigris_use_cache = TRUE)

grad_or_prof <- get_acs(
  geography = "state", 
  variables = "B06009_006", # Total graduate or professional degrees
  year = 2022,
  geometry = TRUE
)

median_age <- get_acs(
  geography = "state", 
  variables = "B01002_001", # Median Age
  year = 2022,
  geometry = TRUE
) %>%
  st_transform('+proj=longlat +datum=WGS84')

monthly_ho_costs <- get_acs(
  geography = "state", 
  variables = "B25094_001", # Monthly Home Owner costs
  year = 2022,
  geometry = TRUE
)

med_hh_income <- get_acs(
  geography = "state", 
  variables = "B19013_001", # Median Household income
  year = 2022,
  geometry = TRUE
)

public_coverage <- get_acs(
  geography = "state", 
  variables = "B27003_001", # Total Public Health Coverage
  year = 2022,
  geometry = TRUE
)

private_coverage <- get_acs(
  geography = "state", 
  variables = "B27002_001", # Total Private Health Coverage
  year = 2022,
  geometry = TRUE
)

ggplot(data = median_age, aes(fill = estimate)) + 
  geom_sf()

palette <- colorNumeric(palette = 'Blues',domain=NULL)

leaflet(median_age) |>
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
    title = 'title'
  ) |>
  addMiniMap(toggleDisplay = TRUE)
