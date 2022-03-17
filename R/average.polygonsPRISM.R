#' @title Calculate polygons average weather variable from PRISM raster
#'
#' @param varName Variable name is either 'ppt', 'tmax', or 'tmin'.
#' @param dayStart Initial day must be in format 'Y/m/d'
#' @param dayEnd Last day must be in format 'Y/m/d'
#' @param data_dir Directory where prism data is
#' @param shpFile Polygons shapefile in "SpatialPolygonsDataFrame".
#'
#' @description TBD
#'
#' @return Average mean of squared grid within the polygon for either variable.
#' @import prism
#' @import lubridate
#' @importFrom stringr str_pad
#' @importFrom exactextractr exact_extract
#'
#' @export
#'
#' @examples
average.polygonsPRISM <- function(varName, dayStart, dayEnd, data_dir, shpFile) {

  varNames <- c("ppt", "tmax", "tmin")
  if( !varName %in% varNames) {
    stop("varName must be 'ppt', 'tmax', or 'tmin'.")
  }
  if( dayStart > dayEnd ) {
    stop("dayStart is after dayEnd")
  }

  # Loop over the range of dates to
  # 1) Parse date into year, month and day
  # 2) Create prism file name
  fileNames <- character()
  seqDates  <- seq(as.Date(dayStart), as.Date(dayEnd), by = "days")
  for(day in seq_along(seqDates)) {
    day <- seqDates[day]
    #1)
    yyyy <- lubridate::year(day)
    mm   <- lubridate::month(day)
    mm   <- stringr::str_pad(mm, 2, "0", side = "left")
    dd   <- lubridate::day(day)
    dd   <- stringr::str_pad(dd, 2, "0", side = "left")
    dayN <- paste0(yyyy, mm, dd)
    #2)
    fileName  <- paste("PRISM", varName, "stable", "4kmD2", dayN, "bil", sep = "_")
    fileNames <- c(fileNames, fileName)
  }

  # Check if the files exist in PRISM directory
  prism::prism_set_dl_dir(path = data_dir)
  if( !all(fileNames %in% prism::prism_archive_ls()) ) {
    cat("\n")
    cat("The following list of rasters do not exist in PRISM directory:")
    cat("\n")
    indices <- !(fileNames %in% prism::prism_archive_ls())
    print(fileNames[indices])
    stop("Raster does not exist in data_dir. Check above the list.")
  }

  raster_stack <- prism::pd_stack(fileNames)

  polygonMeans <- exactextractr::exact_extract(raster_stack,
                                               shpFile,
                                               fun = 'mean')

  return(polygonMeans)

}
