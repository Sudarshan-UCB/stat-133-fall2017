Lab 7: Simple Loops
================
Sudarshan Srirangapatanam

Setup
-----

``` r
library("knitr")
library("dplyr")
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library("ggplot2")
library("readr")

knitr::opts_chunk$set(fig.path = "../images/")
```

-   `knitr` is used for knitting the document as well as other fucntions to cleanup the output
-   `readr` is used for reading data into R
-   `dplyr` is used for data wrangling
-   `ggplot2` is used to generate any necessary plots

``` r
vec <- c(3, 1, 4)
for (i in 1:length(vec)){
  print(vec[i] * 3)
}
```

    ## [1] 9
    ## [1] 3
    ## [1] 12

``` r
vec2 <- NULL
for (i in 1:length(vec)){
  vec2[i] <- vec[i] * 3
  print(vec2[i])
}
```

    ## [1] 9
    ## [1] 3
    ## [1] 12

``` r
getsum <- function(x, n){
  total <- 0
    for (i in 0:n){
        total <- total + (1 / x^i)
    }
  return(total)
}

vec_getsum <- function(x, a){
  vec <- NULL
  for (i in 1:length(a)){
    vec [i] <- getsum(x, a[i])
  }
  return(vec)
}

vec_getsum(2, 0:5)
```

    ## [1] 1.00000 1.50000 1.75000 1.87500 1.93750 1.96875

$$\\sum\_{k=0}^{n} \\frac{1}{2^k} = 1 + \\frac{1}{2} + \\frac{1}{4} + \\frac{1}{8} + \\dots + \\frac{1}{2^n}$$

|    n|       sum|
|----:|---------:|
|    0|  1.000000|
|    1|  1.500000|
|    2|  1.750000|
|    3|  1.875000|
|    4|  1.937500|
|    5|  1.968750|
|    6|  1.984375|
|    7|  1.992188|
|    8|  1.996094|
|    9|  1.998047|
|   10|  1.999023|

$$\\sum\_{k=0}^{n} \\frac{1}{9^k} =1 + \\frac{1}{9} + \\frac{1}{81} + \\dots + \\frac{1}{9^n}$$

|    n|       sum|
|----:|---------:|
|    0|  1.000000|
|    1|  1.111111|
|    2|  1.123457|
|    3|  1.124829|
|    4|  1.124981|
|    5|  1.124998|
|    6|  1.125000|
|    7|  1.125000|
|    8|  1.125000|
|    9|  1.125000|
|   10|  1.125000|

``` r
arith <- function(n = 1, a1 = 3, d = 3){
  a <- NULL
  for (i in 1:n){
    a[i] <- a1 + ((i - 1) * d)
  }
  return(a)
}

geom_sum <- function(n = 1, a1 = 3, r = 2){
  a <- NULL
  for (i in 1:n){
    a[i] <- a1 * (r^(i - 1))
  }
  return(sum(a))
}

vec_geom_sum <- function(a, a1 = 3, r = 2){
  vec <- NULL
  for (i in 1:length(a)){
    vec [i] <- geom_sum(n = a[i], a1, r)
  }
  return(vec)
}
```

3, 6, 9, 12, 15, 18, 21, 24, 27, 30...<br> The series doesn't converge.

|    n|   sum|
|----:|-----:|
|    1|     3|
|    2|     9|
|    3|    21|
|    4|    45|
|    5|    93|
|    6|   189|
|    7|   381|
|    8|   765|
|    9|  1533|
|   10|  3069|

``` r
sin_x <- function(x, terms = 1){
  sign <- rep(c(1, -1), times = terms / 2)
  if (terms %% 2 == 1){
    sign <- c(sign, 1)
  }
  div <- seq(from = 1, by = 2, length.out = terms)
  
  total <- 0
  for (i in 1:terms){
  total <- total + ((sign[i] * x^(div[i])) / factorial(div[i]))
  }
  return(total)
}
```

using 50 terms:<br>

|         x|      sin\_x|         sin|
|---------:|-----------:|-----------:|
|  3.141593|   0.0000000|   0.0000000|
|  3.769911|  -0.5877853|  -0.5877853|
|  4.398230|  -0.9510565|  -0.9510565|
|  5.026548|  -0.9510565|  -0.9510565|
|  5.654867|  -0.5877853|  -0.5877853|
|  6.283185|   0.0000000|   0.0000000|

using 10 terms:<br>

|         x|      sin\_x|         sin|
|---------:|-----------:|-----------:|
|  3.141593|   0.0000000|   0.0000000|
|  3.769911|  -0.5877853|  -0.5877853|
|  4.398230|  -0.9510571|  -0.9510565|
|  5.026548|  -0.9510664|  -0.9510565|
|  5.654867|  -0.5879016|  -0.5877853|
|  6.283185|  -0.0010482|   0.0000000|

using 5 terms:<br>

|         x|      sin\_x|         sin|
|---------:|-----------:|-----------:|
|  3.141593|   0.0069253|   0.0000000|
|  3.769911|  -0.5376907|  -0.5877853|
|  4.398230|  -0.6864173|  -0.9510565|
|  5.026548|   0.1586424|  -0.9510565|
|  5.654867|   3.3100743|  -0.5877853|
|  6.283185|  11.8995665|   0.0000000|

``` r
mod_matrix <- function(A){
    for (i in 1:nrow(A)){
    for (j in 1:ncol(A)){
      if (A[i,j] < 0){
        A[i,j] <- A[i,j]^2
      } else {
        A[i,j] <- sqrt(A[i,j])
      }
    }
    }
  return(A)
}
```

|           |           |           |
|----------:|----------:|----------:|
|  1.0369596|  2.7690158|  0.9390430|
|  0.8180322|  0.4548099|  0.4760373|
|  0.8649091|  0.5340145|  0.8841027|
|  0.2898359|  0.7421622|  0.6780865|

``` r
reduce <- function(x){
  while (x %% 2 == 0){
    x <- x / 2
    print(x)
  }
}
reduce(898128000)
```

    ## [1] 449064000
    ## [1] 224532000
    ## [1] 112266000
    ## [1] 56133000
    ## [1] 28066500
    ## [1] 14033250
    ## [1] 7016625

``` r
avg_for <- function(x){
  total <- 0
  for (i in 1:length(x)){
    total <- total + x[i]
  }
  return(total / length(x))
}

avg_while <- function(x){
  total <- 0
  i <- 1
  while (i <= length(x)){
    total <- total + x[i]
    i <- i + 1
  }
  return(total / length(x))
}


avg_repeat <- function(x){
  total <- 0
  i <- 1
  repeat {
    total <- total + x[i]
    i <- i + 1
    if (i > length(x)){
      break()
    }
  }
  return(total / length(x))
}
```

$$ \\bar{x} = \\frac{1}{n} \\sum\_{i=1}^{n} x\_i = \\frac{x\_1 + x\_2 + \\dots + x\_n}{n} $$

using `for` loop: 50.5<br> using `while` loop: 50.5<br> using `repeat` loop: 50.5

``` r
sd_for <- function(x){
  total <- 0
  for (i in 1:length(x)){
    total <- total + (x[i] - mean(x))^2
  }
  return(sqrt(total / (length(x) - 1)))
}

sd_while <- function(x){
  total <- 0
  i <- 1
  while (i <= length(x)){
    total <- total + (x[i] - mean(x))^2
    i <- i + 1
  }
  return(sqrt(total / (length(x) - 1)))
}


sd_repeat <- function(x){
  total <- 0
  i <- 1
  repeat {
    total <- total + (x[i] - mean(x))^2
    i <- i + 1
    if (i > length(x)){
      break()
    }
  }
  return(sqrt(total / (length(x) - 1)))
}
```

$$ SD = \\sqrt{ \\frac{1}{n-1} \\sum\_{i=1}^{n} (x\_i - \\bar{x})^2 } $$

using `for` loop: 29.011492<br> using `while` loop: 29.011492<br> using `repeat` loop: 29.011492

``` r
geom_for <- function(x){
  prod <- 1
  for (i in 1:length(x)){
    prod <- prod * x[i]
  }
  return(prod^(1/length(x)))
}

geom_while <- function(x){
  prod <- 1
  i <- 1
  while (i <= length(x)){
    prod <- prod * x[i]
    i <- i + 1
  }
  return(prod^(1/length(x)))
}


geom_repeat <- function(x){
  prod <- 1
  i <- 1
  repeat {
    prod <- prod * x[i]
    i <- i + 1
    if (i > length(x)){
      break()
    }
  }
  return(prod^(1/length(x)))
}
```

$$ \\bar{x} = \\left ( \\prod\_{i=1}^{n} x\_i \\right )^{1/n} $$

using `for` loop: 19.4832542<br> using `while` loop: 19.4832542<br> using `repeat` loop: 19.4832542
