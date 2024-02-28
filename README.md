# Blueprint for Animated Travel Maps with QGIS

Creating animated travel maps can be a fascinating and informative way to share your travel stories or plan future adventures. This process involves several steps, from conceptualization to the final animation. As a result full ownership of the map and the data is achieved.

Here is my workflow for creating animated travel maps using QGIS, a powerful open-source geographic information system.

## Requirements

### Software

- QGIS: An open-source GIS software that provides powerful tools for spatial analysis, data visualization, and map creation. Download and install the latest version of QGIS from the official website. This guide is based on QGIS 3.36.x.

- DaVinci Resolve: A professional video editing software that offers advanced color grading, visual effects, and audio post-production capabilities. Download and install the latest version of DaVinci Resolve from the official website. This guide is based on DaVinci Resolve 17.

- (optional) Python: A programming language that is widely used in the GIS community. I do NOT use the QGIS-provided a Python console and a Python API for custom scripting and automation. Rather I tend to use quick Python scripts to manipulate the GPX data.

### Data

- Natural Earth Data: A public domain resource providing high-quality vector and raster data for mapping and spatial analysis. Download the desired datasets from the Natural Earth website and store them in a dedicated folder on your computer.

- GPX Track: A GPS Exchange Format file containing the track of your travel route. In the planning phase for my bicycle tour I used the powerful routing tool brouter-web to create a GPX track. brouter is bike routing software which aims "to calculate more or less the routes that match your experience in the regions you are familiar with". After the tour I used the GPX track I recorded each day to create the as-is animated travel map.

## Resources

- [QGIS](https://qgis.org/en/site/)

- [NaturalEarthData.com](https://www.naturalearthdata.com/) or on GitHub [nvkelso/natural-earth-vector](https://github.com/nvkelso/natural-earth-vector)

- [brouter](https://brouter.de/brouter-web/)

## Folder Structure:

Data:
NaturalEarth: Store Natural Earth shapefiles (.shp) for places, rivers, admin boundaries, and countries.
GPX: Store GPX track files (.gpx).
ClippedData: Store the output shapefiles of clipped populated cities.

Projects: Save your QGIS project files (.qgz or .qgs) here.

Output: Use this folder for exported maps or data that results from your analysis.

Documentation: Store project documentation, metadata, and notes here.

# Collaboration

- Fork this repo and clone to your local computer to use as a template for your own animated travel maps.

- Do not hesitate to open an [issue](https://github.com/cprima/GIS-stuff/issues) or otherwise get in contact with me.

# License

@see: [LICENCE](LICENCE.md) and [AUTHORS](AUTHORS.md).
