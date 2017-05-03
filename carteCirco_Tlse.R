library(rgdal)
library(leaflet)
library(sp)
library(htmlwidgets)
library(GISTools)

circo <- rgdal::readOGR("circonscriptions-electorales-haute-garonne.geojson", "OGRGeoJSON")

# mydata = circo@data
# m <- leaflet(mydata) %>%
#   addTiles() %>%
#   addCircleMarkers(~geo_point_2d2, ~geo_point_2d1)
# m

# Define the mapping between circonsription and colors
pal = colorFactor(
  palette = "Set3",
  domain  = circo@data$circonscription
)

m = leaflet()
#m = addProviderTiles(m, "Esri.WorldStreetMap")
#m = addProviderTiles(m, "OpenStreetMap.BlackAndWhite")
# To chose the map style:
# http://leaflet-extras.github.io/leaflet-providers/preview/index.html
m = addTiles(m)
m = addPolygons(m, 
                data = circo,
                color = "#444444", 
                weight = 1,
                smoothFactor = 0.2,
                opacity = 1,
                fillOpacity = 0.5,
                fillColor = ~pal(circo@data$circonscription)
)
m = addLegend(m, "bottomright", pal = pal, values = circo@data$circonscription,
              title = "Circonscriptions",
              labFormat = labelFormat(prefix = " "),
              opacity = 0.75
)
m


## %>% setView(lng = 1.4333, lat = 43.6, zoom = 11)

# Export de la carte en html
library(htmlwidgets)
saveWidget(m, 'circo_Tlse.html', selfcontained = TRUE)



# library(ggmap)
# tlse <- 'Toulouse'
# qmap(tlse,zoom = 11)+
#   geom_polygon(aes(x = geo_point_2d1, y = geo_point_2d2), data = circo,
#                colour = 'black', fill = 'black')


#library(RColorBrewer)
#display.brewer.all()