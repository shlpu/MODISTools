% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/batch_subset.R
\name{batch_subset}
\alias{batch_subset}
\title{Batch download MODIS Land Products subsets}
\usage{
batch_subset(df = NULL, product = NULL, band = NULL,
  start = "2000-01-01", end = format(Sys.time(), "\%Y-\%m-\%d"),
  km_lr = 0, km_ab = 0, out_dir = tempdir(), internal = TRUE,
  ncores = "auto")
}
\arguments{
\item{df}{a file holding locations and their sitenames to batch process}

\item{product}{a valid MODIS product name}

\item{band}{band to download (default = \code{NULL}, all bands)}

\item{start}{start date}

\item{end}{end date}

\item{km_lr}{km left-right to sample}

\item{km_ab}{km above-below to sample}

\item{out_dir}{location where to store all data}

\item{internal}{should the data be returned as an internal data structure
\code{TRUE} or \code{FALSE} (default = \code{TRUE})}

\item{ncores}{number of cores to use while downloading in parallel
(auto will select the all cpu cores - 1)}
}
\value{
A nested list containing the downloaded data and a descriptive
header with meta-data.
}
\description{
Lists all available dates for a MODIS Land Products Subset product
at a particular location.
}
\examples{

\donttest{
# create data frame with a site_name, lat and lon column
# holding the respective names of sites and their location
df <- data.frame("site_name" = paste("test",1:2))
df$lat <- 40
df$lon <- -110

print(df)

# test batch download
subsets <- batch_subset(df = df,
                        product = "MOD11A2",
                        band = "LST_Day_1km",
                        internal = TRUE,
                        start = "2004-01-01",
                        end = "2004-03-31",
                        out_dir = "~")

print(str(subsets))

}
}
\keyword{Land}
\keyword{MODIS}
\keyword{Products}
\keyword{Subsets,}
\keyword{meta-data}
\keyword{products,}
