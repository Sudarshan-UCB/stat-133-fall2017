#' ---
#' title: "Lab10"
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

knitr::opts_chunk$set(fig.path = "../images/")

#' + `knitr` is used for knitting the document as well as other fucntions to cleanup the output
#' + `readr` is used for reading data into R
#' + `dplyr` is used for data wrangling
#' + `ggplot2` is used to generate any necessary plots
#' + `shiny` is used for shiny apps

#' ## Reading `USArrests`
states <- rownames(USArrests)

head(USArrests)
head(states)

#' *`nchar()` on states:*
#' `r kable(head(data.frame(states, "nchar()" = nchar(states))))`

#' ### Case folding on states:
casefold <- data.frame(states,
                       "tolower" = tolower(states),
                       "toupper" = toupper(states),
                       "(upper = TRUE)" = casefold(states, upper = TRUE),
                       "(upper = FALSE)" = casefold(states, upper = FALSE))
head(casefold)

#' ### Frequency table on chars
num_chars <- nchar(states)
char_freq <- table(num_chars)
barplot(char_freq)

#' ### Pasting strings
paste(states[1:5], num_chars[1:5], sep = " = ")
paste(states[1:5], collapse = "")

#' ### Substrings
first <- substr(states, 1, 3)
last <- substr(states, num_chars-2, num_chars)
first_last <- paste0(substr(first, 1, 1), last)
#' First 3 letters: `r kable(head(first))`<br>
#' Last 3 letters: `r kable(head(last))`<br>
#' First 1 and last 3 letters: `r kable(head(first_last))`

#' ### Challenge
state_list <- function(x, char_count) {
  result <- list()
  for (i in min(char_count):max(char_count)) {
    if (i %% 2 == 0) {
      result[[paste0(i, "-chars", collapse = "")]] <- substr(toupper(x[char_count == i]), 1, i)
    } else {
      result[[paste0(i, "-chars", collapse = "")]] <- substr(tolower(x[char_count == i]), 1, i)
    }
  }

  return(result)
}

state_list(states, num_chars)

#' ## Converting from Fahrenheit Degrees
#' ### Original function
to_celsius <- function(x = 1) {
  (x - 32) * (5/9)
}

to_kelvin <- function(x = 1) {
  (x + 459.67) * (5/9)
}

to_reaumur <- function(x = 1) {
  (x - 32) * (4/9)
}

to_rankine <- function(x = 1) {
  x + 459.67
}

temp_convert <- function(x = 1, to = "celsius") {
  switch(to,
         "celsius" = to_celsius(x),
         "kelvin" = to_kelvin(x),
         "reaumur" = to_reaumur(x),
         "rankine" = to_rankine(x))
}
#' ### Fucntion updates
#' When cases other than low are used to specify arguments the function fails to return a value. We can fix it by:
temp_convert <- function(x = 1, to = "celsius") {
  to <- tolower(to)
  switch(to,
         "celsius" = to_celsius(x),
         "kelvin" = to_kelvin(x),
         "reaumur" = to_reaumur(x),
         "rankine" = to_rankine(x))
}
# Testing
temp_convert(30, 'celsius')
temp_convert(30, 'Celsius')
temp_convert(30, 'CELSIUS')

#' ## Names of files
# file names and dataset names
method1 <- paste0("file", 1:10, ".csv")
method2 <- paste("file", 1:10, ".csv", sep = "")
method3 <- {
  x <- c(rep("file", 10), 1:10, rep(".csv", 10))
  z <- NULL
  for(i in 1:10) {
    z[i] <- paste0(x[i], x[i + 10], x[i + 20])
  }
  z
}

dataset <- gsub("file", "dataset", method1)

#' ## Using function `cat()`

# name of output file
outfile <- "output.txt"

# modification
cat('---\ntitle: "lab10 cat()"\nauthor: "Sudarshan Srirangapatanam"\ndate: "11/3/17"\noutput: html_document\n---\n\n', file = outfile)
# writing to 'outfile.txt'
cat("This is the first line", file = outfile, append = TRUE)
# insert new line
cat("\n", file = outfile, append = TRUE)
cat("A 2nd line", file = "output.txt", append = TRUE)
# insert 2 new lines
cat("\n\n", file = outfile, append = TRUE)
cat("\nThe quick brown fox jumps over the lazy dog\n",
    file = outfile, append = TRUE)

#'see [`./output.txt`](./output.txt) for output

#'
#' ## Valid Color Names
is_color <- function(x) {
  colors <- colors()
  sum <- sum(colors == x)
  if(sum == 0) {
    return(FALSE)
  } else {
    return(TRUE)
  }
}
# testing
is_color('yellow')  # TRUE
is_color('blu')     # FALSE
is_color('turkuoise') # FALSE

#' ### Plot with a valid color
colplot <- function(col="") {
  if(is_color(col)) {
    return(plot(x = 1:100, y = runif(100), main = paste("Testing color", col)))
  } else{
    #stop(paste("invalid color", col))
  }
}

# testing
# this stops with error message
colplot('tomate')
# this should plot
colplot('tomato')

#' ## Counting number of vowels
set.seed(1)
letrs <- sample(letters, size = 100, replace = TRUE)

prep.letters <- function(x) {
  x <- tolower(x)
  x <- unlist(strsplit(x, ""))
  return(x)
}

count.letters <- function(x, count_by = "abcd") {
  x <- prep.letters(x)
  count_by <- prep.letters(count_by)
  count <- NULL
  for (i in 1:length(count_by)) {
    count[i] <- sum(x == count_by[i])
  }
  names(count) <- count_by
  return(count)
}

format.counts <- function(x) {
  return(paste(names(x), ":", x))
}



count.letters(letrs, count_by = c("aeiou"))

count.letters(letrs, count_by = c("bcdfghjklmnpqrstvwxyz"))

#' ### Number of letters, vowels, and consonants
count_letters <- function(x) {
  x <- prep.letters(x)

  letters <- paste("letters :", length(x))
  vowels <- paste("vowels :", sum(count.letters(x, count_by = c("aeiou"))))
  consonants <- paste("consonants :", sum(count.letters(x, count_by = c("bcdfghjklmnpqrstvwxyz"))))

  return(paste(letters, vowels, consonants, sep = ', '))
}

count_letters("abcd")

#/*
knitr::spin("./lab10.R", knit = FALSE)
rmarkdown::render("./lab10.R", output_format = "github_document", output_options = list(toc = TRUE))
file.rename("./lab10.Rmd", "../report/lab10.Rmd")
file.rename("./lab10.md", "../report/lab10.md")
file.rename("./lab10.html", "../html/lab10.html")
#*/
