# Proyecto Azolvamiento y eutroficación en presas periurbanas de zonas templadas de México: contribuciones para su evaluación y prospección
# Programa de Apoyo a Proyectos de Investigación e Innovación Tecnológica (PAPIIT), Clave IN112823
# https://lae.ciga.unam.mx/proyectos/agua/

Conjunto de scripts de R que permiten importar y procesar datos de las sondas Echomap (sonar) de GARMIN

El script procesa_garmin.R lee los archivos GPX producidos por la ecosonda, recupera los datos de fecha (date), 
hora (time), latitud (lat), longitud (lon), temperatura (temp) y profundidad (depth), crea una tabla dataframe
y la salva en formato CSV.

El script interpola.R interpola el valor de profundidad para generar un raster del modelo batimétrico.
