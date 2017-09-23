Lab 4: Data Frame Basics
================
Sudarshan Srirangapatanam

Creating data frames
--------------------

``` r
require("knitr")
```

    ## Loading required package: knitr

``` r
player_name <- c("Thompson", "Curry", "Green", "Durant", "Pachulia")
pos <- c("SG", "PG", "PF", "SF", "C")
sal <- c(16663575, 12112359, 15330435, 26540100, 2898000)
point <- c(1742, 1999, 776, 1555, 426)
PPG <- c(22.3, 25.3, 10.2, 25.1, 6.1)
rookie <- c(FALSE, FALSE, FALSE, FALSE, FALSE)

lineup_GSW <- data.frame(
  Player = player_name,
  Position = pos,
  Salary = sal,
  Points = point,
  PPG = PPG,
  Rookie = rookie
)

gsw_list <- list(
  Player = player_name,
  Position = pos,
  Salary = sal,
  Points = point,
  PPG = PPG,
  Rookie = rookie
)

lineup_GSW_list <- data.frame(gsw_list)

lineup_cbind <- cbind(
    Player = player_name,
  Position = pos,
  Salary = sal,
  Points = point,
  PPG = PPG,
  Rookie = rookie
)
```

-   Use the vectors to create a first data frame with `data.frame()`.<br>

| Player   | Position |    Salary|  Points|   PPG| Rookie |
|:---------|:---------|---------:|-------:|-----:|:-------|
| Thompson | SG       |  16663575|    1742|  22.3| FALSE  |
| Curry    | PG       |  12112359|    1999|  25.3| FALSE  |
| Green    | PF       |  15330435|     776|  10.2| FALSE  |
| Durant   | SF       |  26540100|    1555|  25.1| FALSE  |
| Pachulia | C        |   2898000|     426|   6.1| FALSE  |

-   Create another data frame by first starting with a `list()`, and then passing the list to `data.frame()`.<br>

| Player   | Position |    Salary|  Points|   PPG| Rookie |
|:---------|:---------|---------:|-------:|-----:|:-------|
| Thompson | SG       |  16663575|    1742|  22.3| FALSE  |
| Curry    | PG       |  12112359|    1999|  25.3| FALSE  |
| Green    | PF       |  15330435|     776|  10.2| FALSE  |
| Durant   | SF       |  26540100|    1555|  25.1| FALSE  |
| Pachulia | C        |   2898000|     426|   6.1| FALSE  |

-   What would you do to obtain a data frame such that when you check its structure `str()` the variables are:
    -   Player as character: enclose our vector when we pass them with `as.character`.
    -   Position as factor: enclose our vector when we pass them with `as.factor`.
    -   Salary as numeric or real (ignore the commas): enclose our vector when we pass them with `as.numeric`, or `as.real`.
    -   Points as integer: enclose our vector when we pass them with `as.integer`.
    -   PPG as numeric or real: enclose our vector when we pass them with `as.numeric`, or `as.real`.
    -   Rookie as logical: enclose our vector when we pass them with `as.logical`.
-   Find out how to use the column binding function `cbind()` to create a tabular object with the vectors created in step 1.<br>

| Player   | Position | Salary   | Points | PPG  | Rookie |
|:---------|:---------|:---------|:-------|:-----|:-------|
| Thompson | SG       | 16663575 | 1742   | 22.3 | FALSE  |
| Curry    | PG       | 12112359 | 1999   | 25.3 | FALSE  |
| Green    | PF       | 15330435 | 776    | 10.2 | FALSE  |
| Durant   | SF       | 26540100 | 1555   | 25.1 | FALSE  |
| Pachulia | C        | 2898000  | 426    | 6.1  | FALSE  |

    + inspect what class of object is obtained with `cbind()`: matrix

-   How could you convert the object in the previous step into a data frame?<br> We could coerce it using `as.data.frame()` function.

Data
----

``` r
dat <- read.csv('data/nba2017-players.csv', stringsAsFactors = FALSE)

durant <- dat[dat$player == "Kevin Durant",]

ucla <- dat[dat$college == "University of California, Los Angeles",]

rookies <- dat[dat$experience == 0,]
rookie_centers <- rookies[rookies$position == "C",]

top_players <- dat[dat$games > 50 & dat$minutes > 100,]

gsw <- dat[dat$team == "GSW", c("player", "height", "weight")]
```

**The data used in this lab is taken from [nba2017-players](https://github.com/Sudarshan-UCB/stat-133-fall2017/blob/master/labs/Lab04/data/nba2017-players.csv)**

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

Use bracket notation, the dollar operator, as well as concepts of logical subsetting and indexing to:

-   Display the last 5 rows of the data.<br>

| player        | team | position |  height|  weight|  age|  experience| college                      |   salary|  games|  minutes|  points|  points3|  points2|  points1|
|:--------------|:-----|:---------|-------:|-------:|----:|-----------:|:-----------------------------|--------:|------:|--------:|-------:|--------:|--------:|--------:|
| Jordan Mickey | BOS  | PF       |      80|     235|   22|           1| Louisiana State University   |  1223653|     25|      141|      38|        0|       15|        8|
| Kelly Olynyk  | BOS  | C        |      84|     238|   25|           3| Gonzaga University           |  3094014|     75|     1538|     678|       68|      192|       90|
| Marcus Smart  | BOS  | SG       |      76|     220|   22|           2| Oklahoma State University    |  3578880|     79|     2399|     835|       94|      175|      203|
| Terry Rozier  | BOS  | PG       |      74|     190|   22|           1| University of Louisville     |  1906440|     74|     1263|     410|       57|       94|       51|
| Tyler Zeller  | BOS  | C        |      84|     253|   27|           4| University of North Carolina |  8000000|     51|      525|     178|        0|       78|       22|

-   Display those rows associated to players having height less than 70 inches tall.<br>

| player        | team | position |  height|  weight|  age|  experience| college                  |   salary|  games|  minutes|  points|  points3|  points2|  points1|
|:--------------|:-----|:---------|-------:|-------:|----:|-----------:|:-------------------------|--------:|------:|--------:|-------:|--------:|--------:|--------:|
| Isaiah Thomas | BOS  | PG       |      69|     185|   27|           5| University of Washington |  6587132|     76|     2569|    2199|      245|      437|      590|
| Kay Felder    | CLE  | PG       |      69|     176|   21|           0| Oakland University       |   543471|     42|      386|     166|        7|       55|       35|

-   Of those players that are centers (position C), display their names and salaries.\*<br>

| player           |    salary|
|:-----------------|---------:|
| Al Horford       |  26540100|
| Kelly Olynyk     |   3094014|
| Tyler Zeller     |   8000000|
| Channing Frye    |   7806971|
| Edy Tavares      |      5145|
| Tristan Thompson |  15330435|

-   Create a data frame durant with Kevin Durant's information (i.e. row).<br>

| player       | team | position |  height|  weight|  age|  experience| college                       |    salary|  games|  minutes|  points|  points3|  points2|  points1|
|:-------------|:-----|:---------|-------:|-------:|----:|-----------:|:------------------------------|---------:|------:|--------:|-------:|--------:|--------:|--------:|
| Kevin Durant | GSW  | SF       |      81|     240|   28|           9| University of Texas at Austin |  26540100|     62|     2070|    1555|      117|      434|      336|

-   Create a data frame ucla with the data of players from college UCLA ("University of California, Los Angeles").\*<br>

| player        | team | position |  height|  weight|  age|  experience| college                               |    salary|  games|  minutes|  points|  points3|  points2|  points1|
|:--------------|:-----|:---------|-------:|-------:|----:|-----------:|:--------------------------------------|---------:|------:|--------:|-------:|--------:|--------:|--------:|
| Kevin Love    | CLE  | PF       |      82|     251|   28|           8| University of California, Los Angeles |  21165675|     60|     1885|    1142|      145|      225|      257|
| Norman Powell | TOR  | SG       |      76|     215|   23|           1| University of California, Los Angeles |    874636|     76|     1368|     636|       56|      171|      126|
| Kevon Looney  | GSW  | C        |      81|     220|   20|           1| University of California, Los Angeles |   1182840|     53|      447|     135|        2|       54|       21|
| Matt Barnes   | GSW  | SF       |      79|     226|   36|          13| University of California, Los Angeles |    383351|     20|      410|     114|       18|       20|       20|
| Kyle Anderson | SAS  | SG       |      81|     230|   23|           2| University of California, Los Angeles |   1192080|     72|     1020|     246|       15|       78|       45|
| Trevor Ariza  | HOU  | SF       |      80|     215|   31|          12| University of California, Los Angeles |   7806971|     80|     2773|     936|      191|      135|       93|

-   Create a data frame rookies with those players with 0 years of experience.\*<br>

| player            | team | position |  height|  weight|  age|  experience| college                     |   salary|  games|  minutes|  points|  points3|  points2|  points1|
|:------------------|:-----|:---------|-------:|-------:|----:|-----------:|:----------------------------|--------:|------:|--------:|-------:|--------:|--------:|--------:|
| Demetrius Jackson | BOS  | PG       |      73|     201|   22|           0| University of Notre Dame    |  1450000|      5|       17|      10|        1|        2|        3|
| Jaylen Brown      | BOS  | SF       |      79|     225|   20|           0| University of California    |  4743000|     78|     1341|     515|       46|      146|       85|
| Kay Felder        | CLE  | PG       |      69|     176|   21|           0| Oakland University          |   543471|     42|      386|     166|        7|       55|       35|
| Fred VanVleet     | TOR  | PG       |      72|     195|   22|           0| Wichita State University    |   543471|     37|      294|     107|       11|       28|       18|
| Jakob Poeltl      | TOR  | C        |      84|     248|   21|           0| University of Utah          |  2703960|     54|      626|     165|        0|       67|       31|
| Pascal Siakam     | TOR  | PF       |      81|     230|   22|           0| New Mexico State University |  1196040|     55|      859|     229|        1|      102|       22|

-   Create a data frame rookie\_centers with the data of Center rookie players.\*<br>

| player            | team | position |  height|  weight|  age|  experience| college                         |   salary|  games|  minutes|  points|  points3|  points2|  points1|
|:------------------|:-----|:---------|-------:|-------:|----:|-----------:|:--------------------------------|--------:|------:|--------:|-------:|--------:|--------:|--------:|
| Jakob Poeltl      | TOR  | C        |      84|     248|   21|           0| University of Utah              |  2703960|     54|      626|     165|        0|       67|       31|
| Daniel Ochefu     | WAS  | C        |      83|     245|   23|           0| Villanova University            |   543471|     19|       75|      24|        0|       12|        0|
| Thon Maker        | MIL  | C        |      85|     216|   19|           0|                                 |  2568600|     57|      562|     226|       28|       55|       32|
| Marshall Plumlee  | NYK  | C        |      84|     250|   24|           0| Duke University                 |   543471|     21|      170|      40|        0|       16|        8|
| Willy Hernangomez | NYK  | C        |      83|     240|   22|           0|                                 |  1375000|     72|     1324|     587|        4|      242|       91|
| Stephen Zimmerman | ORL  | C        |      84|     240|   20|           0| University of Nevada, Las Vegas |   950000|     19|      108|      23|        0|       10|        3|

-   Create a data frame top\_players for players with more than 50 games and more than 100 minutes played.\*<br>

| player        | team | position |  height|  weight|  age|  experience| college                       |    salary|  games|  minutes|  points|  points3|  points2|  points1|
|:--------------|:-----|:---------|-------:|-------:|----:|-----------:|:------------------------------|---------:|------:|--------:|-------:|--------:|--------:|--------:|
| Al Horford    | BOS  | C        |      82|     245|   30|           9| University of Florida         |  26540100|     68|     2193|     952|       86|      293|      108|
| Amir Johnson  | BOS  | PF       |      81|     240|   29|          11|                               |  12000000|     80|     1608|     520|       27|      186|       67|
| Avery Bradley | BOS  | SG       |      74|     180|   26|           6| University of Texas at Austin |   8269663|     55|     1835|     894|      108|      251|       68|
| Isaiah Thomas | BOS  | PG       |      69|     185|   27|           5| University of Washington      |   6587132|     76|     2569|    2199|      245|      437|      590|
| Jae Crowder   | BOS  | SF       |      78|     235|   26|           4| Marquette University          |   6286408|     72|     2335|     999|      157|      176|      176|
| Jaylen Brown  | BOS  | SF       |      79|     225|   20|           0| University of California      |   4743000|     78|     1341|     515|       46|      146|       85|

-   What's the largest height value?<br> 87

-   What's the minimum height value?<br> 69

-   What's the overall average height?<br> 79.154195

-   Who is the tallest player?<br> Edy Tavares, Boban Marjanovic, Kristaps Porzingis

-   Who is the shortest player?<br> Isaiah Thomas, Kay Felder

-   Which are the unique teams?<br> BOS, CLE, TOR, WAS, ATL, MIL, IND, CHI, MIA, DET, CHO, NYK, ORL, PHI, BRK, GSW, SAS, HOU, LAC, UTA, OKC, MEM, POR, DEN, NOP, DAL, SAC, MIN, LAL, PHO

-   How many different teams?<br> 30

-   Who is the oldest player?<br> Vince Carter

-   What is the median salary of all players?<br> 3.510^{6}

-   What is the median salary of the players with 10 years of experience or more?<br> 5.64403410^{6}

-   What is the median salary of Shooting Guards (SG) and Point Guards (PG)?<br> 3.230689510^{6}

-   What is the median salary of Power Forwards (PF), 29 years or older, and 74 inches tall or less?<br> NA

-   How many players scored 4 points or less?<br> 7

-   Who are those players who scored 4 points or less?<br> Chris McCullough, Michael Gbinije, Patricio Garino, Isaiah Taylor, Brice Johnson, Roy Hibbert, Elijah Millsap

-   Who is the player with 0 points?<br> Patricio Garino

-   How many players are from "University of California, Berkeley"?<br> 0

-   Are there any players from "University of Notre Dame"? If so how many and who are they?<br> There are 3 players from University of Notre Dame. They are Demetrius Jackson, Jerian Grant, Pat Connaughton.

-   Are there any players with weight greater than 260 pounds? If so how many and who are they?<br> There are 21 players with weight greater than 260 pounds.

-   How many players did not attend a college in the US?<br> 85

-   Who is the player with the maximum rate of points per minute?<br> Russell Westbrook

-   Who is the player with the maximum rate of three-points per minute?<br> Stephen Curry

-   Who is the player with the maximum rate of two-points per minute?<br> JaVale McGee

-   Who is the player with the maximum rate of one-points (free-throws) per minute?<br> Russell Westbrook

-   Create a data frame gsw with the name, height, weight of Golden State Warriors (GSW)\*<br>

| player               |  height|  weight|
|:---------------------|-------:|-------:|
| Andre Iguodala       |      78|     215|
| Damian Jones         |      84|     245|
| David West           |      81|     250|
| Draymond Green       |      79|     230|
| Ian Clark            |      75|     175|
| James Michael McAdoo |      81|     230|

-   Display the data in gsw sorted by height in increasing order (hint: see ?sort and ?order)\*<br>

| player         |  height|  weight|
|:---------------|-------:|-------:|
| Ian Clark      |      75|     175|
| Stephen Curry  |      75|     190|
| Andre Iguodala |      78|     215|
| Draymond Green |      79|     230|
| Klay Thompson  |      79|     215|
| Matt Barnes    |      79|     226|

-   Display the data in gsw by weight in decreasing order (hint: see ?sort and ?order)\*<br>

| player         |  height|  weight|
|:---------------|-------:|-------:|
| JaVale McGee   |      84|     270|
| Zaza Pachulia  |      83|     270|
| David West     |      81|     250|
| Damian Jones   |      84|     245|
| Kevin Durant   |      81|     240|
| Draymond Green |      79|     230|

-   Display the player name, team, and salary, of the top 5 highest-paid players (hint: see ?sort and ?order)<br>

| player        | team |    salary|
|:--------------|:-----|---------:|
| LeBron James  | CLE  |  30963450|
| Al Horford    | BOS  |  26540100|
| DeMar DeRozan | TOR  |  26540100|
| Kevin Durant  | GSW  |  26540100|
| James Harden  | HOU  |  26540100|

-   Display the player name, team, and points3, of the top 10 three-point players (hint: see ?sort and ?order)<br>

| player         | team |  points3|
|:---------------|:-----|--------:|
| Stephen Curry  | GSW  |      324|
| Klay Thompson  | GSW  |      268|
| James Harden   | HOU  |      262|
| Eric Gordon    | HOU  |      246|
| Isaiah Thomas  | BOS  |      245|
| Kemba Walker   | CHO  |      240|
| Bradley Beal   | WAS  |      223|
| Damian Lillard | POR  |      214|
| Ryan Anderson  | HOU  |      204|
| J.J. Redick    | LAC  |      201|

*\* only a small suset is shown using the `head()` function to reduce report length*

Group by
--------

``` r
pos_group <- aggregate(. ~ position, data = dat[ ,c('position', 'height', 'weight', 'age')], FUN = mean)

team_group <- aggregate(. ~ team, data = dat[ ,c('team', 'height', 'weight', 'age')], FUN = mean)

team_pos_group <- aggregate(. ~ team + position, data = dat[ ,c('team', 'position', 'height', 'weight', 'age')], FUN = mean)

fun_group <- aggregate(. ~ team + position, data = dat[ ,c('team', 'position', 'salary')], FUN = function(x) c(minimum = min(x), median = median(x), mean = mean(x), maximum = max(x)))
```

-   Create a data frame with the average height, average weight, and average age, grouped by position\*<br>

| position |    height|    weight|       age|
|:---------|---------:|---------:|---------:|
| C        |  83.25843|  250.7978|  25.93258|
| PF       |  81.50562|  235.8539|  25.93258|
| PG       |  74.30588|  188.5765|  26.38824|
| SF       |  79.63855|  220.4699|  27.07229|
| SG       |  77.02105|  204.7684|  26.20000|

-   Create a data frame with the average height, average weight, and average age, grouped by team\*<br>

| team |    height|    weight|       age|
|:-----|---------:|---------:|---------:|
| ATL  |  79.14286|  219.9286|  28.42857|
| BOS  |  78.20000|  219.8667|  25.26667|
| BRK  |  78.66667|  222.4000|  25.46667|
| CHI  |  78.53333|  215.6000|  25.80000|
| CHO  |  78.80000|  212.8000|  25.86667|
| CLE  |  78.86667|  226.4000|  29.60000|

-   Create a data frame with the average height, average weight, and average age, grouped by team and position.\*<br>

| team | position |    height|    weight|       age|
|:-----|:---------|---------:|---------:|---------:|
| ATL  | C        |  83.00000|  252.5000|  28.00000|
| BOS  | C        |  83.33333|  245.3333|  27.33333|
| BRK  | C        |  84.00000|  267.5000|  27.00000|
| CHI  | C        |  83.00000|  250.0000|  25.66667|
| CHO  | C        |  83.50000|  245.5000|  25.50000|
| CLE  | C        |  83.66667|  251.0000|  27.33333|

-   Difficult: Create a data frame with the minimum salary, median salary, mean salary, and maximum salary, grouped by team and position.\*<br>

``` r
head(fun_group)
```

    ##   team position salary.minimum salary.median salary.mean salary.maximum
    ## 1  ATL        C        1015696      12097986    12097986       23180275
    ## 2  BOS        C        3094014       8000000    12544705       26540100
    ## 3  BRK        C        3000000      12082838    12082838       21165675
    ## 4  CHI        C         874636       1709720     5267869       13219250
    ## 5  CHO        C        2730000       7615000     7615000       12500000
    ## 6  CLE        C           5145       7806971     7714184       15330435

*\* only a small suset is shown using the `head()` function to reduce report length*
