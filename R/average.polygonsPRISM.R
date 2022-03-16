#' @title Calculate polygons average weather variable from PRISM raster
#'
#' @param varName Variable name is either 'ppt', 'tmax', or 'tmin'.
#' @param day Day must be in format yyyymmdd (e.g., 199910113, for yyyy = 1991, mm = 10, and dd = 13).
#' @param data_dir Directory where prism data is
#' @param shpFile Polygons shapefile in "SpatialPolygonsDataFrame".
#'
#' @return Average mean of squared grid within the polygon for either variable.
#' @import prism
#' @importFrom exactextractr exact_extract
#'
#' @export
#'
#' @examples
averge.polygonsPRISM <- function(varName, day, data_dir, shpFile) {

  # Robustness checks
  varNames <- c("ppt", "tmax", "tmin")
  if( !varName %in% varNames) {
    stop("varName must be 'ppt', 'tmax', or 'tmin'.")
  }
  if( !all(length(day) == 8) ) {
    stop("day must be in yyyymmdd.")
  }

  prism_fileName <- paste("PRISM", varName, "stable", "4kmD2", day, "bil", sep = "_")
  prism::prism_set_dl_dir(path = dir)
  if( !prism_fileName %in% prism::prism_archive_ls() ) {
    stop("Raster does not exist in data_dir.")
  }

  rast <- prism::pd_stack(prism_fileName)

  polygonMeans <- exactextractr::exact_extract(rast,
                                               shpFile,
                                               fun = 'mean')

  return(polygonMeans)

}
