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



#/*
knitr::spin("labo09.R", knit = FALSE, )
rmarkdown::render("lab09.R", output_format = "github_document")
#*/