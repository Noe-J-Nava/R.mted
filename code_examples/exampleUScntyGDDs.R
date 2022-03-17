# Noé J Nava
# Noe.Nava@usda.gov
# ERS - MTED - APM

# Note:

# Example of how to calculate daily gdd for all U.S. counties across 8 days
# in the Summer of 2017

# Known issues:
# None

rm(list = ls())
devtools::install_github("Noe-J-Nava/R.mted") # Rmted collection of tools
library(rgdal)

# Options --
dayStart <- "2017/08/12"     #must be in format %Y/%m/%d.
dayEnd   <- "2017/08/19"     #must be in format %Y/%m/%d.
data_dir <- "data/example1/" #relative path

# Openning US county polygons shape file
USmap_county <- readOGR(dsn = 'assets/3109_county',
                        layer = 'USmap_county')
fips <- as.numeric(USmap_county@data$ANSI_ST_CO)
fips <- as.character(fips) # List of US cnty fips

# Collect means
tmin <- averge.polygonsPRISM(varName  = 'tmin',
                             dayStart = dayStart,
                             dayEnd   = dayEnd,
                             data_dir = data_dir,
                             shpFile  = USmap_county)

dim(tmin)
