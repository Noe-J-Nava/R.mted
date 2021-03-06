% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/edd.calculation.R
\name{edd.calculation}
\alias{edd.calculation}
\title{Extreme Degree Days (GDD) calculation.}
\usage{
edd.calculation(tmin, tmax)
}
\arguments{
\item{tmin}{Minimum temperature}

\item{tmax}{Maximum temperature}
}
\value{
EDD
}
\description{
edd.calculation() calculates crop specific GDD using as daily average the formula 0.5*(tmin + tmax). tmin and tmax must be vectors and have the same dimensions.
}
