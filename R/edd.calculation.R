#' @title Extreme Degree Days (GDD) calculation.
#'
#' @param tmin Minimum temperature
#' @param tmax Maximum temperature
#'
#' @description edd.calculation() calculates crop specific GDD using as daily average the formula 0.5*(tmin + tmax). tmin and tmax must be vectors and have the same dimensions.
#'
#'
#' @return EDD
#' @export
#'
#' @examples
edd.calculation <- function(tmin, tmax) {

  # Robustness checks
  if( !all(is.vector(tmin), is.vector(tmax), length(tmin) == length(tmax)) ) {
    stop("Either tmin or tmax are not vectors, or they do not have the same length!")
  }

  taverage <- .5*(tmax + tmin)
  # EDD occur at higher than 30
  taverage <- ifelse(taverage > 30, taverage, 30)
  edd <- taverage - 30

  return(edd)

}
