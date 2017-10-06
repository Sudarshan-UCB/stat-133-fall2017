# ---
# Title: Short title (one sentence)
# Description: what the script is about (one paragraph or two)
# Input(s): ../data/nba2017-players.csv
# Output(s): ../output/*
# Author: Sudarshan Srirangapatanam
# Date: 10/06/17
# ---

require("readr")
require("dplyr")
require("ggplot2")

# Reading data
dat <- read_csv("../data/nba2017-players.csv", col_names = TRUE, col_types = "ccciiiicdiiiiii")

# Selecting desired subset of data
warriors <- dat %>% filter(team == "GSW") %>% arrange(salary)
lakers <- dat %>% filter(team == "LAL") %>% arrange(desc(experience))

# Export subsets
write.csv(warriors, file = "../data/warriors.csv", row.names = FALSE)
write.csv(lakers, file = "../data/lakers.csv", row.names = FALSE)

# Outputs
sink(file = "../output/summary-height-weight.txt")
summary((dat %>% select(height, weight)))
sink()

sink(file = "../output/data-structure.txt")
str(dat)
sink()

sink(file = "../output/summary-lakers.txt")
summary(lakers)
sink()

# Plots
png(filename = "../images/scatterplot-height-weight.png")
plot(dat$height, dat$weight, xlab = "Height", ylab = "Weight", main = "Scatterplot of Weight vs. Height")
dev.off()

png(filename = "../images/scatterplot-height-weight-res100.png", res = 100)
plot(dat$height, dat$weight, xlab = "Height", ylab = "Weight", main = "Scatterplot of Weight vs. Height")
dev.off()

jpeg(filename = "../images/histogram-age.jpeg", width = 600, height = 400)
hist(dat$age, xlab = "Age", main = "Histogram of Age")
dev.off()

pdf(file = "../images/histogram-age.pdf", width = 7, height = 5)
hist(dat$age, xlab = "Age", main = "Histogram of Age")
dev.off()

# ggplots
gg_pts_salary <- ggplot(dat, aes(x = points, y = salary))+
  geom_point()+
  labs(x = "Points", y = "Salary", title = "Scatterplot of Salary vs. Points")

gg_ht_wt_positions <- ggplot(dat, aes(x = height, y = weight))+
  geom_point()+
  labs(x = "Height", y = "Weight", title = "Scatterplot of Weight vs. Height")+
  facet_wrap(~ position)

ggsave(filename = "../images/points_salary.pdf", plot = gg_pts_salary, width = 7, height = 5, units = "in")
ggsave(filename = "../images/height_weight_by_position.pdf", plot = gg_ht_wt_positions, width = 6, height = 4, units = "in")

# Using the piper operator

lakers %>% select(player)

warriors %>% filter(position == "PG") %>% select(player, salary)

dat %>% filter(experience >= 10 & salary <= (10*10^6)) %>% select(player, age, team)

dat %>% filter(experience == 0 & age == 20) %>% slice(1:5) %>% select(player, team, height, weight)

gsw_mpg <- dat %>% mutate(min_per_game = minutes / games) %>% select(player, experience, min_per_game) %>% arrange(desc(min_per_game))

group_by(dat, team) %>% summarise(avg3pt = mean(points3)) %>% arrange(avg3pt) %>% slice(1:5)

dat %>% filter(position == "PF" & experience %in% (5:10)) %>% summarise(mean = mean(age), std_error = sd(age))

