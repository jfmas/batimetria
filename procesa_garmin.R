### Proyecto Azolvamiento y eutroficación en presas periurbanas de zonas templadas de México: contribuciones
# para su evaluación y prospección
# Programa de Apoyo a Proyectos de Investigación e Innovación Tecnológica (PAPIIT), Clave IN112823

##### Lee datos batimetria de sonar GRAMIN EchoMap y genera tabla que se salva en formato csv


# Load necessary libraries
library(XML)
#library(dplyr)
setwd("/home/jf/pCloudDrive/proyectos/PAPIIT2023/sonar")
# Load the XML file
xml_file <- xmlParse("/home/jf/pCloudDrive/proyectos/PAPIIT2023/sonar/2.GPX")

# Get the root node
root_node <- xmlRoot(xml_file)

# Define namespaces
ns <- c(
  d1 = "http://www.topografix.com/GPX/1/1", 
  gpxtpx = "http://www.garmin.com/xmlschemas/TrackPointExtension/v1"
)

# Initialize empty lists to store the extracted data
time_list <- c()
date_list <- c()
lat_list <- c()
lon_list <- c()
wtemp_list <- c()
depth_list <- c()

# Loop through each <trkpt> node, considering the namespace
for (trkpt in getNodeSet(root_node, "//d1:trkpt", namespaces = ns)) {
  
  # Extract latitude and longitude attributes
  lat <- as.numeric(xmlGetAttr(trkpt, "lat"))
  lon <- as.numeric(xmlGetAttr(trkpt, "lon"))
  
  # Extract the <time> element value
  time_full <- xmlValue(getNodeSet(trkpt, "d1:time", namespaces = ns)[[1]])
  
  # Split the time into date and time components
  date <- substr(time_full, 1, 10)  # Extract date (YYYY-MM-DD)
  time <- substr(time_full, 12, 19)  # Extract time (HH:MM:SS)
  
  # Initialize temperature and depth with NA
  wtemp <- NA
  depth <- NA
  
  # Check if <extensions> exist and extract temperature and depth
  extensions <- getNodeSet(trkpt, "d1:extensions/gpxtpx:TrackPointExtension", namespaces = ns)
  if (length(extensions) > 0) {
    track_ext <- extensions[[1]]
    wtemp_node <- getNodeSet(track_ext, "gpxtpx:wtemp", namespaces = ns)
    depth_node <- getNodeSet(track_ext, "gpxtpx:depth", namespaces = ns)
    
    if (length(wtemp_node) > 0) {
      wtemp <- as.numeric(xmlValue(wtemp_node[[1]]))
    }
    if (length(depth_node) > 0) {
      depth <- as.numeric(xmlValue(depth_node[[1]]))
    }
  }
  
  # Append extracted data to the lists
  lat_list <- c(lat_list, lat)
  lon_list <- c(lon_list, lon)
  date_list <- c(date_list, date)
  time_list <- c(time_list, time)
  wtemp_list <- c(wtemp_list, wtemp)
  depth_list <- c(depth_list, depth)
}

# Combine the lists into a dataframe
data <- data.frame(
  date = date_list,
  time = time_list,
  lat = lat_list,
  lon = lon_list,
  wtemp = wtemp_list,
  depth = depth_list,
  stringsAsFactors = FALSE
)

# Print the dataframe
print(data)
write.csv(data,"data.csv")
