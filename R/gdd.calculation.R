#' @title Growing Degree Days (GDD) calculation.
#'
#' @param tmin Minimum temperature
#' @param tmax Maximum temperature
#' @param tbase Crop specific base temperature
#'
#' @description gdd.calculation() calculates crop specific GDD using as daily average the formula 0.5*(tmin + tmax). tmin and tmax must be vectors and have the same dimensions. tbase must be a scalar.
#'
#' @return GDD
#' @export
#'
#' @examples
gdd.calculation <- function(tmin, tmax, tbase) {

  # Robustness checks
  if( !all(is.vector(tmin), is.vector(tmax), length(tmin) == length(tmax)) ) {
    stop("Either tmin or tmax are not vectors, or they do not have the same length!")
  }
  if( !(length(tbase) == 1) ) {
    stop("tbase is not a scalar")
  }

  taverage <- .5*(tmax + tmin)
  # GDD is capped at 30C, and GDD cannot be less than zero (e.g., negative)
  taverage <- ifelse(taverage <= 30, taverage, 30)
  taverage <- ifelse(taverage > tbase, taverage, tbase)
  gdd <- taverage - tbase

  return(gdd)

}
