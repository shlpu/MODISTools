#' Download all available dates
#'
#' Lists all available dates for a MODIS Land Products Subset product
#' at a particular location.
#'
#' @param product a valid MODIS product name
#' @param lat latitude in decimal degrees
#' @param lon longitude in decimal degrees
#' @param site_id site id (overides lat / lon)
#' @return A data frame of all available dates for a MODIS Land
#' Products Subsets products at the given location.
#' @keywords MODIS Land Products Subsets, products, meta-data
#' @export
#' @examples
#'
#' \donttest{
#' # list all available MODIS Land Products Subsets products
#' bands <- list_dates(product = "MOD11A2", lat = 40, lon = -110)
#' print(bands)
#'}

list_dates <- function(product = NULL,
                       lat = NULL,
                       lon = NULL,
                       site_id = NULL){

  # load all products
  products <- MODISTools::list_products()$product

  # error trap
  if (is.null(product) | !(product %in% products) ){
    stop("please specify a product, or check your product name...")
  }

  # error trap
  if (is.null(site_id) & (is.null(lat) | is.null(lon)) ){
    stop("please specify coordinates...")
  }

  # define server settings (main server should become global
  # as in not specified in every function)
  server <- "https://modis.ornl.gov/rst/"

  # switch url in case of siteid
  if (is.null(site_id)){
    url <- paste0(server,"api/v1/",product,"/dates")

    # construct the query to be served to the server
    query <- list("latitude" = lat,
                  "longitude" = lon)

  } else {
    url <- paste0(server,"api/v1/",product,"/",site_id,"/dates")
    query <- NULL
  }

  # try to download the data
  resp = try(httr::GET(url = url,
                        query = query,
                        httr::write_memory()))

  # trap errors on download, return a general error statement
  # with the most common causes
  if (httr::http_error(resp) | inherits(resp, "try-error")){
    stop("Your requested timed out or the server is unreachable")
  }

  # check the content of the response
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  # grab content
  dates <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"),
                              simplifyVector = TRUE)$dates

  # return a data frame with all dates
  return(dates)
}
