Lab 4: Basics of dplyr
================
Sudarshan Srirangapatanam
September 13, 2017

Data
----

``` r
require("dplyr") #used for data wrangling
```

    ## Loading required package: dplyr

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
require("knitr") #used for kable() function
```

    ## Loading required package: knitr

``` r
dat <- read.csv('data/nba2017-players.csv', stringsAsFactors = FALSE)
```

**The data used in this lab is taken from [nba2017-players](https://github.com/Sudarshan-UCB/stat-133-fall2017/blob/master/labs/Lab04/data/nba2017-players.csv)**

It is a good practice to use `stringsAsFactors = FALSE` because it specifically tells R to not convert characters as factors which is precisely what we need, since not all character vectors are factors. In case we do have some variables that needed to be read as factors we can easily convert them using `as.factor` later.

-   `dim()`:<br> 441, 15

-   `head()`:<br>

| player            | team | position |  height|  weight|  age|  experience| college                       |    salary|  games|  minutes|  points|  points3|  points2|  points1|
|:------------------|:-----|:---------|-------:|-------:|----:|-----------:|:------------------------------|---------:|------:|--------:|-------:|--------:|--------:|--------:|
| Al Horford        | BOS  | C        |      82|     245|   30|           9| University of Florida         |  26540100|     68|     2193|     952|       86|      293|      108|
| Amir Johnson      | BOS  | PF       |      81|     240|   29|          11|                               |  12000000|     80|     1608|     520|       27|      186|       67|
| Avery Bradley     | BOS  | SG       |      74|     180|   26|           6| University of Texas at Austin |   8269663|     55|     1835|     894|      108|      251|       68|
| Demetrius Jackson | BOS  | PG       |      73|     201|   22|           0| University of Notre Dame      |   1450000|      5|       17|      10|        1|        2|        3|
| Gerald Green      | BOS  | SF       |      79|     205|   31|           9|                               |   1410598|     47|      538|     262|       39|       56|       33|
| Isaiah Thomas     | BOS  | PG       |      69|     185|   27|           5| University of Washington      |   6587132|     76|     2569|    2199|      245|      437|      590|

-   `tail()`:<br>

| player          | team | position |  height|  weight|  age|  experience| college                         |    salary|  games|  minutes|  points|  points3|  points2|  points1|
|:----------------|:-----|:---------|-------:|-------:|----:|-----------:|:--------------------------------|---------:|------:|--------:|-------:|--------:|--------:|--------:|
| Leandro Barbosa | PHO  | SG       |      75|     194|   34|          13|                                 |   4000000|     67|      963|     419|       35|      137|       40|
| Marquese Chriss | PHO  | PF       |      82|     233|   19|           0| University of Washington        |   2941440|     82|     1743|     753|       72|      212|      113|
| Ronnie Price    | PHO  | PG       |      74|     190|   33|          11| Utah Valley State College       |    282595|     14|      134|      14|        3|        1|        3|
| T.J. Warren     | PHO  | SF       |      80|     230|   23|           2| North Carolina State University |   2128920|     66|     2048|     951|       26|      377|      119|
| Tyler Ulis      | PHO  | PG       |      70|     150|   21|           0| University of Kentucky          |    918369|     61|     1123|     444|       21|      163|       55|
| Tyson Chandler  | PHO  | C        |      85|     240|   34|          15|                                 |  12415000|     47|     1298|     397|        0|      153|       91|

-   `summary()`:<br>

|      player      |       team       |     position     |     height    |     weight    |      age      |   experience   |      college     |      salary      |     games     |    minutes   |     points     |     points3    |    points2    |     points1    |
|:----------------:|:----------------:|:----------------:|:-------------:|:-------------:|:-------------:|:--------------:|:----------------:|:----------------:|:-------------:|:------------:|:--------------:|:--------------:|:-------------:|:--------------:|
|    Length:441    |    Length:441    |    Length:441    |  Min. :69.00  |  Min. :150.0  |  Min. :19.00  |  Min. : 0.000  |    Length:441    |    Min. : 5145   |  Min. : 1.00  |   Min. : 8   |   Min. : 0.0   |   Min. : 0.00  |   Min. : 0.0  |   Min. : 0.00  |
| Class :character | Class :character | Class :character | 1st Qu.:77.00 | 1st Qu.:200.0 | 1st Qu.:23.00 | 1st Qu.: 1.000 | Class :character | 1st Qu.: 1286160 | 1st Qu.:32.00 | 1st Qu.: 475 | 1st Qu.: 156.0 |  1st Qu.: 3.00 | 1st Qu.: 39.0 | 1st Qu.: 21.00 |
|  Mode :character |  Mode :character |  Mode :character | Median :79.00 | Median :220.0 | Median :26.00 | Median : 4.000 |  Mode :character | Median : 3500000 | Median :62.00 | Median :1193 | Median : 432.0 | Median : 32.00 | Median :111.0 | Median : 58.00 |
|        NA        |        NA        |        NA        |  Mean :79.15  |  Mean :220.2  |  Mean :26.29  |  Mean : 4.676  |        NA        |  Mean : 6187014  |  Mean :53.71  |  Mean :1244  |  Mean : 546.6  |  Mean : 49.71  |  Mean :152.5  |  Mean : 92.47  |
|        NA        |        NA        |        NA        | 3rd Qu.:82.00 | 3rd Qu.:240.0 | 3rd Qu.:29.00 | 3rd Qu.: 7.000 |        NA        | 3rd Qu.: 9250000 | 3rd Qu.:75.00 | 3rd Qu.:1955 | 3rd Qu.: 780.0 | 3rd Qu.: 78.00 | 3rd Qu.:213.0 | 3rd Qu.:120.00 |
|        NA        |        NA        |        NA        |  Max. :87.00  |  Max. :290.0  |  Max. :40.00  |  Max. :18.000  |        NA        |  Max. :30963450  |  Max. :82.00  |  Max. :3048  |  Max. :2558.0  |  Max. :324.00  |  Max. :730.0  |  Max. :746.00  |

Using `dplyr`
-------------

``` r
last_5 <- slice(dat, (length(dat)-5+1):length(dat))

height_l70 <- filter(dat, height < 70)

names_sal_of_centers <- dat %>% filter(position == "C") %>% select(player, salary)

lal_players <- dat %>% filter(team == "LAL") %>% select(player)

#Both fucntions checks if there are any players and returns answer
players_college <- function(data, college_name){
  college_data <- filter(data, college == college_name)
  length_data <- length((college_data %>% select(college))[[1]])
  if(length_data == 0){
    return(paste("There are no players from", college_name))
  }
  return(paste("There are ", length_data, "players from ", college_name))
}

players_weight <- function(data, weight_cat){
  weight_data <-  filter(data, eval(parse(text = weight_cat)))
  length_data <- length((weight_data %>% select(weight))[[1]])
  if(length_data == 0){
    return(paste("There are no players in the catergory", weight_cat))
  }
  return(paste("There are ", length_data, "players in the catergory ", weight_cat))
}

#All other answers use inline code chunks and cane be viewed in .Rmd file
```

-   subset the data by selecting the last 5 rows.<br>

| player        | team | position |  height|  weight|  age|  experience| college                      |   salary|  games|  minutes|  points|  points3|  points2|  points1|
|:--------------|:-----|:---------|-------:|-------:|----:|-----------:|:-----------------------------|--------:|------:|--------:|-------:|--------:|--------:|--------:|
| Jordan Mickey | BOS  | PF       |      80|     235|   22|           1| Louisiana State University   |  1223653|     25|      141|      38|        0|       15|        8|
| Kelly Olynyk  | BOS  | C        |      84|     238|   25|           3| Gonzaga University           |  3094014|     75|     1538|     678|       68|      192|       90|
| Marcus Smart  | BOS  | SG       |      76|     220|   22|           2| Oklahoma State University    |  3578880|     79|     2399|     835|       94|      175|      203|
| Terry Rozier  | BOS  | PG       |      74|     190|   22|           1| University of Louisville     |  1906440|     74|     1263|     410|       57|       94|       51|
| Tyler Zeller  | BOS  | C        |      84|     253|   27|           4| University of North Carolina |  8000000|     51|      525|     178|        0|       78|       22|

-   select those players with height less than 70 inches tall.<br>

| player        | team | position |  height|  weight|  age|  experience| college                  |   salary|  games|  minutes|  points|  points3|  points2|  points1|
|:--------------|:-----|:---------|-------:|-------:|----:|-----------:|:-------------------------|--------:|------:|--------:|-------:|--------:|--------:|--------:|
| Isaiah Thomas | BOS  | PG       |      69|     185|   27|           5| University of Washington |  6587132|     76|     2569|    2199|      245|      437|      590|
| Kay Felder    | CLE  | PG       |      69|     176|   21|           0| Oakland University       |   543471|     42|      386|     166|        7|       55|       35|

-   of those players that are centers (position `C`), select their names and salaries.\*<br>

| player           |    salary|
|:-----------------|---------:|
| Al Horford       |  26540100|
| Kelly Olynyk     |   3094014|
| Tyler Zeller     |   8000000|
| Channing Frye    |   7806971|
| Edy Tavares      |      5145|
| Tristan Thompson |  15330435|

-   display the player names of the lakers (`'LAL'`).<br> Brandon Ingram, Corey Brewer, D'Angelo Russell, David Nwaba, Ivica Zubac, Jordan Clarkson, Julius Randle, Larry Nance Jr., Luol Deng, Metta World Peace, Nick Young, Tarik Black, Thomas Robinson, Timofey Mozgov, Tyler Ennis

-   What's the largest height value?<br> 87

-   What's the minimum height value?<br> 69

-   What's the overall average height?<br> 79.154195

-   Who is the tallest player?<br> Edy Tavares, Boban Marjanovic, Kristaps Porzingis

-   Who is the shortest player?<br> Isaiah Thomas, Kay Felder

-   Which are the unique teams?<br> BOS, CLE, TOR, WAS, ATL, MIL, IND, CHI, MIA, DET, CHO, NYK, ORL, PHI, BRK, GSW, SAS, HOU, LAC, UTA, OKC, MEM, POR, DEN, NOP, DAL, SAC, MIN, LAL, PHO

-   How many different teams?<br> 30

-   Who is the oldest player?<br> Vince Carter

-   What is the median salary?<br> 3.510^{6}

-   Are there any players from "University of California, Berkeley"? If so how many and who are they?<br> There are no players from University of California, Berkeley

-   Are there any players from "University of California, Los Angeles"? If so how many and who are they?<br> There are 13 players from University of California, Los Angeles

-   Are there any players with weight greater than 260 pounds? If so how many and who are they?<br> There are 21 players in the catergory weight &gt; 260

*\* only a small suset is shown using the `head()` function to reduce report length*

Sorting
-------

-   Obtain height values in increasing order\*<br> 69, 69, 70, 71, 72, 72...

-   Obtain weight values in decreasing order\*<br> 87, 87, 87, 86, 86, 85...

-   Sort data by height in increasing order\*<br>

| player        | team | position |  height|  weight|  age|  experience| college                      |    salary|  games|  minutes|  points|  points3|  points2|  points1|
|:--------------|:-----|:---------|-------:|-------:|----:|-----------:|:-----------------------------|---------:|------:|--------:|-------:|--------:|--------:|--------:|
| Isaiah Thomas | BOS  | PG       |      69|     185|   27|           5| University of Washington     |   6587132|     76|     2569|    2199|      245|      437|      590|
| Kay Felder    | CLE  | PG       |      69|     176|   21|           0| Oakland University           |    543471|     42|      386|     166|        7|       55|       35|
| Tyler Ulis    | PHO  | PG       |      70|     150|   21|           0| University of Kentucky       |    918369|     61|     1123|     444|       21|      163|       55|
| Ty Lawson     | SAC  | PG       |      71|     195|   29|           7| University of North Carolina |   1315448|     69|     1732|     681|       34|      203|      173|
| Fred VanVleet | TOR  | PG       |      72|     195|   22|           0| Wichita State University     |    543471|     37|      294|     107|       11|       28|       18|
| Kyle Lowry    | TOR  | PG       |      72|     205|   30|          10| Villanova University         |  12000000|     60|     2244|    1344|      193|      233|      299|

-   Sort data by weight in decreasing order\*<br>

| player            | team | position |  height|  weight|  age|  experience| college                   |    salary|  games|  minutes|  points|  points3|  points2|  points1|
|:------------------|:-----|:---------|-------:|-------:|----:|-----------:|:--------------------------|---------:|------:|--------:|-------:|--------:|--------:|--------:|
| Boban Marjanovic  | DET  | C        |      87|     290|   28|           1|                           |   7000000|     35|      293|     191|        0|       72|       47|
| Al Jefferson      | IND  | C        |      82|     289|   32|          12|                           |  10230179|     66|      931|     535|        0|      235|       65|
| Kevin Seraphin    | IND  | PF       |      81|     285|   27|           6|                           |   1800000|     49|      559|     232|        0|      109|       14|
| Jusuf Nurkic      | POR  | C        |      84|     280|   22|           2|                           |   1921320|     20|      584|     304|        0|      120|       64|
| Andre Drummond    | DET  | C        |      83|     279|   23|           4| University of Connecticut |  22116750|     81|     2409|    1105|        2|      481|      137|
| Cristiano Felicio | CHI  | C        |      82|     275|   24|           1|                           |    874636|     66|     1040|     316|        0|      128|       60|

*\* only a small suset is shown using the `head()` function to reduce report length*

Subsetting Operations
---------------------

``` r
durant <- filter(dat, player == "Kevin Durant")
ucla <- filter(dat, college == "University of California, Los Angeles")
rookies <- filter(dat, experience == 0)
rookie_centers <- filter(dat, experience == 0 & position == "C")
players_50_100 <- filter(dat, games > 50 & minutes > 100)
```

-   create a data frame `durant` with Kevin Durant's information (i.e. row)<br>

| player       | team | position |  height|  weight|  age|  experience| college                       |    salary|  games|  minutes|  points|  points3|  points2|  points1|
|:-------------|:-----|:---------|-------:|-------:|----:|-----------:|:------------------------------|---------:|------:|--------:|-------:|--------:|--------:|--------:|
| Kevin Durant | GSW  | SF       |      81|     240|   28|           9| University of Texas at Austin |  26540100|     62|     2070|    1555|      117|      434|      336|

-   create a data frame `ucla` with the data of players from college UCLA\*<br>

| player        | team | position |  height|  weight|  age|  experience| college                               |    salary|  games|  minutes|  points|  points3|  points2|  points1|
|:--------------|:-----|:---------|-------:|-------:|----:|-----------:|:--------------------------------------|---------:|------:|--------:|-------:|--------:|--------:|--------:|
| Kevin Love    | CLE  | PF       |      82|     251|   28|           8| University of California, Los Angeles |  21165675|     60|     1885|    1142|      145|      225|      257|
| Norman Powell | TOR  | SG       |      76|     215|   23|           1| University of California, Los Angeles |    874636|     76|     1368|     636|       56|      171|      126|
| Kevon Looney  | GSW  | C        |      81|     220|   20|           1| University of California, Los Angeles |   1182840|     53|      447|     135|        2|       54|       21|
| Matt Barnes   | GSW  | SF       |      79|     226|   36|          13| University of California, Los Angeles |    383351|     20|      410|     114|       18|       20|       20|
| Kyle Anderson | SAS  | SG       |      81|     230|   23|           2| University of California, Los Angeles |   1192080|     72|     1020|     246|       15|       78|       45|
| Trevor Ariza  | HOU  | SF       |      80|     215|   31|          12| University of California, Los Angeles |   7806971|     80|     2773|     936|      191|      135|       93|

-   create a data frame `rookies` with those players with 0 years of experience\*<br>

| player            | team | position |  height|  weight|  age|  experience| college                     |   salary|  games|  minutes|  points|  points3|  points2|  points1|
|:------------------|:-----|:---------|-------:|-------:|----:|-----------:|:----------------------------|--------:|------:|--------:|-------:|--------:|--------:|--------:|
| Demetrius Jackson | BOS  | PG       |      73|     201|   22|           0| University of Notre Dame    |  1450000|      5|       17|      10|        1|        2|        3|
| Jaylen Brown      | BOS  | SF       |      79|     225|   20|           0| University of California    |  4743000|     78|     1341|     515|       46|      146|       85|
| Kay Felder        | CLE  | PG       |      69|     176|   21|           0| Oakland University          |   543471|     42|      386|     166|        7|       55|       35|
| Fred VanVleet     | TOR  | PG       |      72|     195|   22|           0| Wichita State University    |   543471|     37|      294|     107|       11|       28|       18|
| Jakob Poeltl      | TOR  | C        |      84|     248|   21|           0| University of Utah          |  2703960|     54|      626|     165|        0|       67|       31|
| Pascal Siakam     | TOR  | PF       |      81|     230|   22|           0| New Mexico State University |  1196040|     55|      859|     229|        1|      102|       22|

-   create a data frame `rookie_centers` with the data of Center rookie players\*<br>

| player            | team | position |  height|  weight|  age|  experience| college                         |   salary|  games|  minutes|  points|  points3|  points2|  points1|
|:------------------|:-----|:---------|-------:|-------:|----:|-----------:|:--------------------------------|--------:|------:|--------:|-------:|--------:|--------:|--------:|
| Jakob Poeltl      | TOR  | C        |      84|     248|   21|           0| University of Utah              |  2703960|     54|      626|     165|        0|       67|       31|
| Daniel Ochefu     | WAS  | C        |      83|     245|   23|           0| Villanova University            |   543471|     19|       75|      24|        0|       12|        0|
| Thon Maker        | MIL  | C        |      85|     216|   19|           0|                                 |  2568600|     57|      562|     226|       28|       55|       32|
| Marshall Plumlee  | NYK  | C        |      84|     250|   24|           0| Duke University                 |   543471|     21|      170|      40|        0|       16|        8|
| Willy Hernangomez | NYK  | C        |      83|     240|   22|           0|                                 |  1375000|     72|     1324|     587|        4|      242|       91|
| Stephen Zimmerman | ORL  | C        |      84|     240|   20|           0| University of Nevada, Las Vegas |   950000|     19|      108|      23|        0|       10|        3|

-   create a data frame for players with more than 50 games and more than 100 minutes\*<br>

| player        | team | position |  height|  weight|  age|  experience| college                       |    salary|  games|  minutes|  points|  points3|  points2|  points1|
|:--------------|:-----|:---------|-------:|-------:|----:|-----------:|:------------------------------|---------:|------:|--------:|-------:|--------:|--------:|--------:|
| Al Horford    | BOS  | C        |      82|     245|   30|           9| University of Florida         |  26540100|     68|     2193|     952|       86|      293|      108|
| Amir Johnson  | BOS  | PF       |      81|     240|   29|          11|                               |  12000000|     80|     1608|     520|       27|      186|       67|
| Avery Bradley | BOS  | SG       |      74|     180|   26|           6| University of Texas at Austin |   8269663|     55|     1835|     894|      108|      251|       68|
| Isaiah Thomas | BOS  | PG       |      69|     185|   27|           5| University of Washington      |   6587132|     76|     2569|    2199|      245|      437|      590|
| Jae Crowder   | BOS  | SF       |      78|     235|   26|           4| Marquette University          |   6286408|     72|     2335|     999|      157|      176|      176|
| Jaylen Brown  | BOS  | SF       |      79|     225|   20|           0| University of California      |   4743000|     78|     1341|     515|       46|      146|       85|

*\* only a small suset is shown using the `head()` function to reduce report length*

More Wrangling
--------------

Answers for question below uses inline code chunks which can be viewed in .Rmd file

-   get the data of those above the average weight?\*<br>

| player        | team | position |  height|  weight|  age|  experience| college                    |    salary|  games|  minutes|  points|  points3|  points2|  points1|
|:--------------|:-----|:---------|-------:|-------:|----:|-----------:|:---------------------------|---------:|------:|--------:|-------:|--------:|--------:|--------:|
| Al Horford    | BOS  | C        |      82|     245|   30|           9| University of Florida      |  26540100|     68|     2193|     952|       86|      293|      108|
| Amir Johnson  | BOS  | PF       |      81|     240|   29|          11|                            |  12000000|     80|     1608|     520|       27|      186|       67|
| Jae Crowder   | BOS  | SF       |      78|     235|   26|           4| Marquette University       |   6286408|     72|     2335|     999|      157|      176|      176|
| Jaylen Brown  | BOS  | SF       |      79|     225|   20|           0| University of California   |   4743000|     78|     1341|     515|       46|      146|       85|
| Jonas Jerebko | BOS  | PF       |      82|     231|   29|           6|                            |   5000000|     78|     1232|     299|       45|       69|       26|
| Jordan Mickey | BOS  | PF       |      80|     235|   22|           1| Louisiana State University |   1223653|     25|      141|      38|        0|       15|        8|

-   add a column 'weight\_kgm' for weight to kilograms\*<br>

| player            | team | position |  height|  weight|  age|  experience| college                       |    salary|  games|  minutes|  points|  points3|  points2|  points1|  weight\_kgm|
|:------------------|:-----|:---------|-------:|-------:|----:|-----------:|:------------------------------|---------:|------:|--------:|-------:|--------:|--------:|--------:|------------:|
| Al Horford        | BOS  | C        |      82|     245|   30|           9| University of Florida         |  26540100|     68|     2193|     952|       86|      293|      108|    111.13004|
| Amir Johnson      | BOS  | PF       |      81|     240|   29|          11|                               |  12000000|     80|     1608|     520|       27|      186|       67|    108.86208|
| Avery Bradley     | BOS  | SG       |      74|     180|   26|           6| University of Texas at Austin |   8269663|     55|     1835|     894|      108|      251|       68|     81.64656|
| Demetrius Jackson | BOS  | PG       |      73|     201|   22|           0| University of Notre Dame      |   1450000|      5|       17|      10|        1|        2|        3|     91.17199|
| Gerald Green      | BOS  | SF       |      79|     205|   31|           9|                               |   1410598|     47|      538|     262|       39|       56|       33|     92.98636|
| Isaiah Thomas     | BOS  | PG       |      69|     185|   27|           5| University of Washington      |   6587132|     76|     2569|    2199|      245|      437|      590|     83.91452|

get the log of height for players with age less than or equal to 25 years\*<br> 4.2904594, 4.3567088, 4.3694479, 4.3820266, 4.4308168, 4.3307333...

*\* only a small suset is shown using the `head()` function to reduce report length*
