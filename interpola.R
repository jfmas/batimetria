### Proyecto Azolvamiento y eutroficación en presas periurbanas de zonas templadas de México: 
### contribuciones para su evaluación y prospección
### Programa de Apoyo a Proyectos de Investigación e Innovación Tecnológica (PAPIIT), Clave IN112823

## Script para interpolar los datos de profundidad generados por el sonar EchoMap y preprocesados
# con el script procesa_garmin.R

# Load required libraries
if (!require(akima)) install.packages("akima")
if (!require(raster)) install.packages("raster")

library(akima)
library(raster)

# Assume df is your dataframe containing lon, lat, and depth columns
# df <- data.frame(lon = ..., lat = ..., depth = ...)

# corriendo primero el script procesa_garmin
df <- data
head(df)

df <- na.omit(df)

# Create a grid for interpolation
lon_range <- seq(min(df$lon), max(df$lon), length.out = 100)
lat_range <- seq(min(df$lat), max(df$lat), length.out = 100)

# Perform interpolation using akima's interp function
interp_result <- with(df, interp(x = lon, y = lat, z = depth, 
                                 xo = lon_range, yo = lat_range, 
                                 linear = TRUE))

# Convert the result to a raster
raster_result <- raster(interp_result)

# Plot the raster
plot(raster_result)

# Optionally, save the raster to a file
writeRaster(raster_result, "interpolated_depth.tif", format="GTiff", overwrite=TRUE)
