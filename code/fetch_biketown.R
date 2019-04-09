# Functions to fetch public Biketown trip data
# https://biketownpdx.com/system-data

# pacman allows checking for and installing missing packages

if(!require("pacman")) {install.packages("pacman")}; library(pacman)
pacman::p_load("lubridate")
pacman::p_load("dplyr")
pacman::p_load("stringr")
pacman::p_load("readr")

# another way to do the same thing using base R

# pkgs <- c("lubridate", "dplyr", "stringr", "readr")
# install.packages(pkgs)

get_data <- function(start = "07/2016", end = NULL, 
                     base_url = "https://s3.amazonaws.com/biketown-tripdata-public/",
                     outdir = "C:/Users/morman/plants/ds19-class/data/biketown/") {
  # takes start and end in mm/yyyy format, and tries to download resaulting files
  # if no end date given, set to now (NULL)
  end <- ifelse(is.null(end), format (now(), "%m/%y"), end)
  
  # make url function that is only available within get_data
  
  make_url <- function(date, base_url) {
    url <- paste0(base_url, format(date, "%Y_%m"), ".csv")
    return(url)
  }
  # parse date range 
  start_date <- lubridate::myd(start, truncated = 2)
  end_date <- lubridate::myd(end, truncated = 2)
  date_range <- seq(start_date, end_date, by = "months")
 
  ## 3 ways to the same end
  
  # apply allows for much faster -for loops
  # lapply(a, b) just applies function b to sequence a and returns a new list of 
  # modifited sequence
  
  # urls <- lapply(date_range, make_url, base_url = base_url)
  
  ## 1) using for loops
  
  # for loops can be easier for early development of code
  # for loop can be easier to read
  
  # for(u in urls) {
  #   destfile = paste0(outdir, str_sub(u, -11))
  #   download.file(u, destfile = destfile)
  # }
  
  ## 2) as an apply with an in-line function
  
  # result <- lapply(urls, function(u) {
  #   download.file(u, destfile = paste0(outdir, str_sub(u, -11)))
  # })
  
  ## 3) tidy piped version that combines url generation & download
  
 lapply(date_range, make_url, base_url = base_url) %>% 
    lapply(function(u) { download.file(u, destfile = paste0(outdir, str_sub(u, -11)))
    })
 }

### Manual Run ###
# parameters

# start = "11/2018"
# end = "08/2018"

# get_data(start)

