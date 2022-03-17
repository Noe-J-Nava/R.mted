
# R.mted

<!-- badges: start -->
<!-- badges: end -->

Collection of curated R functions for MTED economists. Functions are
  createad by MTED economists or modified from other packages. 

## Installation

You can install the development version of R.mted like so:

``` r
devtools::install_github("Noe-J-Nava/R.mted")
```

## Example of how to use tools to calculate county's gdd when tbase = 10

Note: request the data and shapefiles from me.

``` r
rm(list = ls())
devtools::install_github("Noe-J-Nava/R.mted") # Rmted collection of tools
library(rgdal)
library(R.mted)    # our package
library(tidyverse)

# Options --
dayStart <- "2017/08/12"     #must be in format %Y/%m/%d.
dayEnd   <- "2017/08/19"     #must be in format %Y/%m/%d.
data_dir <- "data/example1/" #relative path

names <- seq(as.Date(dayStart), as.Date(dayEnd), by = "days")

# Openning US county polygons shape file
USmap_county <- readOGR(dsn = 'assets/3109_county',
                        layer = 'USmap_county')
fips <- as.numeric(USmap_county@data$ANSI_ST_CO)
fips <- as.character(fips) # List of US cnty fips

# Collect means
tmin <- average.polygonsPRISM(varName  = 'tmin',
                              dayStart = dayStart,
                              dayEnd   = dayEnd,
                              data_dir = data_dir,
                              shpFile  = USmap_county)
names(tmin) <- names
tmin <- cbind(fips, tmin)
tmin <- gather(tmin, date, tmin, 2:length(tmin))

tmax <- average.polygonsPRISM(varName  = 'tmax',
                              dayStart = dayStart,
                              dayEnd   = dayEnd,
                              data_dir = data_dir,
                              shpFile  = USmap_county)
names(tmax) <- names
tmax <- cbind(fips, tmax)
tmax <- gather(tmax, date, tmax, 2:length(tmax))

# Calculating gdd
gdd <- left_join(tmin, tmax, by = c("fips", "date"))

gdd$gdd <- gdd.calculation(tmin = gdd$tmin,
                           tmax = gdd$tmax,
                           tbase = 10)

```

