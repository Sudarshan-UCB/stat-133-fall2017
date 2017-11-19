#' ---
#' title: "Lab11"
#' author: Sudarshan Srirangapatanam
#' ---

#'
#' ## Setup

#+ setup
library(knitr)
library(dplyr)
library(ggplot2)
library(readr)
library(shiny)
library(stringr)
library(RgoogleMaps)
library(ggmap)

knitr::opts_chunk$set(fig.path = "../images/")

#' + `knitr` is used for knitting the document as well as other fucntions to cleanup the output
#' + `readr` is used for reading data into R
#' + `dplyr` is used for data wrangling
#' + `ggplot2` is used to generate any necessary plots
#' + `shiny` is used for shiny apps

dat <- read.csv('../data/mobile-food-sf.csv', stringsAsFactors = FALSE)

#' ## Changing Times

#' ### str_sub()
time1 <- '10AM'
str_sub(time1, start = 1, end = 2)
str_sub(time1, start = 3, end = 4)

times <- c('12PM', '10AM', '9AM', '8AM')
# subset time
str_sub(times, 1, nchar(times) - 2)
# subset period
str_sub(times, nchar(times) - 1, nchar(times))


#' ### str_replace()
hours <- as.numeric(str_replace(times, pattern = 'AM|PM', replacement = ''))
periods <- str_sub(times, start = -2)

to24 <- function(x) {
  period <- str_sub(x, start = -2)
  hour <- as.numeric(str_replace(x, pattern = 'AM|PM', replacement = ''))
  result <- NULL
  for (i in 1:length(x)) {
    if (period[i] == "PM" & hour[i] != 12) {
      result[i] <- hour[i] + 12
    } else if ((period[i] == "AM" & hour[i] != 12) | (period[i] == "PM" & hour[i] == 12)) {
      result[i] <- hour[i]
    } else {
      result[i] <- 0
    }
  }
  return(result)
}
start24 <- to24(times)
start24

str(dat)
dat <- dat %>% mutate(start = to24(starttime), end = to24(endtime), duration = end - start)
str(dat)

#' ## Latitude and Longitude Coordinates

loc1 <- "(37.7651967350509,-122.416451692902)"
lat_lon <- str_replace_all(loc1, pattern = '\\(|\\)', replacement = '')

str_split(lat_lon, pattern = ',')

#' ### Manipulating more location values
locs <- c(
  "(37.7651967350509,-122.416451692902)",
  "(37.7907890558203,-122.402273431333)",
  "(37.7111991003088,-122.394693339395)",
  "(37.7773000262759,-122.394812784799)",
  NA
)
lat_lon <- {
  x <- str_replace_all(locs, pattern = '\\(|\\)', replacement = '')
  str_split(x, pattern = ',')
}

lat <- lapply(lat_lon, function(x) x[1])
lon <- lapply(lat_lon, function(x) x[2])

latitude <- as.numeric(unlist(lat))
longitude <- as.numeric(unlist(lon))

get_lat <- function(x) {
  y <- str_replace_all(x, pattern = '\\(|\\)', replacement = '')
  z <- str_split(y, pattern = ',')

  lats <- lapply(z, function(x) x[1])
  return(as.numeric(unlist(lats)))
}
get_long <- function(x) {
  y <- str_replace_all(x, pattern = '\\(|\\)', replacement = '')
  z <- str_split(y, pattern = ',')

  longs <- lapply(z, function(x) x[2])
  return(as.numeric(unlist(longs)))
}


str(dat)
dat <- dat %>% mutate(lat = get_lat(Location), lon = get_long(Location))
str(dat)

#' ## Plotting locations on a map
plot(dat$lon, dat$lat, pch = 19, col = "#77777744")

center <- c(mean(dat$lat, na.rm = TRUE), mean(dat$lon, na.rm = TRUE))
zoom <- min(MaxZoom(range(dat$lat, na.rm = TRUE), 
  range(dat$lon, na.rm = TRUE)))

map1 <- GetMap(center=center, zoom=zoom, destfile = "../images/san-francisco.png")
PlotOnStaticMap(map1, dat$lat, dat$lon, col = "#ed4964", pch=20)

#' ## ggmap

dat <- na.omit(dat)
sbbox <- make_bbox(lon = dat$lon, lat = dat$lat, f = .1)
sbbox
sf_map <- get_map(location = sbbox, maptype = "terrain", source = "google")
ggmap(sf_map) + 
  geom_point(data = dat, 
    mapping = aes(x = lon, y = lat), 
    color = "red", alpha = 0.2, size = 1)

#' ## Let's look for specific types of food

dat$optionaltext[1:3]
foods <- dat$optionaltext[1:10]
burros <- str_detect(foods, "B|burritos")
burros

foods <- dat$optionaltext
burros <- str_detect(foods, "B|burritos")
tacos <- str_detect(foods, "T|tacos")
quesadillas <- str_detect(foods, "Q|quesadillas")

burritos <- dat[burros,]
lon <- dat[burros, lon]
lat <- dat[burros, lat]

ggmap(sf_map) +
  geom_point(burritos, mapping = aes(x = lon, y = lat), col = "blue", alpha = 0.2, size = 1)

#' ## Practice more Regex patterns

animals <- c('dog', 'cat', 'bird', 'dolphin', 'lion',
  'zebra', 'tiger', 'wolf', 'whale', 'eagle',
  'pig', 'osprey', 'kangaroo', 'koala')

grep('dog', animals)
grep('dog', animals, value = TRUE)

str_detect(animals, 'dog')
str_extract(animals, 'dog')

animals[str_detect(animals, 'dog')]

#' **Your Turn**
display <- function(x) {
  animals[str_detect(animals, x)]
}

display("o*")
display("o{0,1}")
display("o{1,}")
display("o{2}")
display("o{1}(?!o|\\b)")
display("[aeiou][aeiou]")
display("[^aeiou]{2}")
display("[^aeiou]{3}")
display("^[a-z]{3}$")
display("^[a-z]{4}$")

#' **File Names**
files <- c('sales1.csv', 'orders.csv', 'sales2.csv',
  'sales3.csv', 'europe.csv', 'usa.csv', 'mex.csv',
  'CA.csv', 'FL.csv', 'NY.csv', 'TX.csv',
  'sales-europe.csv', 'sales-usa.csv', 'sales-mex.csv')

display <- function(x, invert = FALSE) {
  if (invert) {
    result <- files[!str_detect(files, x)]
  } else {
    result <- files[str_detect(files, x)]
  }
  return(result)
}

display("\\d")
display("\\D")
display("^(?![A-Z])")
display("[A-Z]")
display("-")
display("[\\-]", TRUE)
str_replace_all(files, "\\.csv", "\\.txt")
str_split(files, "\\.", simplify = TRUE)[,1]

#' String handling functions
split_chars <- function(x) {
  str_split(x, "")[[1]]
}

split_chars('Go Bears!')
split_chars('Expecto Patronum')

reverse_chars <- function(x) {
  split <- split_chars(x)
  rev <- NULL
  for (i in 1:length(split)) {
    rev[i] <- split[length(split) - i + 1]
  }
  
  return(paste0(rev, collapse = ""))
}
reverse_chars("gattaca")
reverse_chars("Lumox Maxima")

#/*
knitr::spin("./lab10.R", knit = FALSE)
rmarkdown::render("./lab10.R", output_format = "github_document", output_options = list(toc = TRUE))
file.rename("./lab10.Rmd", "../report/lab10.Rmd")
file.rename("./lab10.md", "../report/lab10.md")
file.rename("./lab10.html", "../html/lab10.html")
#*/
