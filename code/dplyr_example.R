# Intro  to dplyr
library(dplyr)

# If you want to use a function from another package that is masked by one you loaded, 
# can use :: to call that function (like stats :: function)

# 2 ways to prevent strings from being pulled in as a factor
# 1. add stringsAsFactors = F

gapminder <- read.csv("data/gapminder_data.csv", stringsAsFactors = F)

# converts string text to factor
gapminder$continent <- as.factor(gapminder$continent)

# to test if factor
is.factor(gapminder$continent)

# to test if characters
is.character(gapminder$continent)

# using mean in baseR
mean(gapminder[gapminder$continent == "Africa", "gdpPercap"])

# dplyr can use pipe = %>%
# Functions we will learn today from dplyr:
# 1. select()
# 2. filter()
# 3. group_by()
# 4. summarize()
# 5. mutate()

# what attributes in gapminder:

colnames(gapminder)

# select three attributes from gapminder:

subset_1 <- gapminder %>%
  select(country, continent, lifeExp)

# select every attribute except 2:
subset_2 <- gapminder %>% 
  select(-lifeExp, -pop)
str(subset_2)

# select some attributes but rename a few of them for clarity:
subset_3 <- gapminder %>% 
  select(country, population = pop, lifeExp, gdp = gdpPercap)
str(subset_3)

# using filter() with pipe
africa <- gapminder %>% 
  filter(continent == "Africa") %>% 
  select(country, population = pop, lifeExp)
table(africa$country)

# using filter without pipe
africa <- filter(gapminder, continent == "Africa")
africa <- select(africa, country, population = pop, lifeExp)
table(africa$country)
# note that filter retains all factors, can convert to string text if needed (see above)

# select year, population, country, for Europe
europe <- gapminder %>% 
  filter(continent == "Europe") %>% 
  select(year, population = pop, country)
europe_table <- table(europe$country)
View(europe_table)

# working with group_by() and summarize()

str(gapminder %>% group_by(continent))


# summarize mean gdp per continent
gdp_continent <- gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdp = mean(gdpPercap), mean_lifeExp = mean(lifeExp))
View(gdp_continent)

# birdwalk with ggplot2
library(ggplot2)
summary_plot <- gdp_continent %>% ggplot(aes(x = mean_gdp, y = mean_lifeExp)) + 
  geom_point(stat = "identity") +
  theme_bw()
summary_plot

# exercise: calculate mean population for all the continents

mean_cont <- gapminder %>% group_by(continent) %>% 
  summarize(mean_pop = mean(pop))

# count() and n()

gapminder %>% 
  filter(year == 2002) %>% 
  count(continent, sort = TRUE)

# n() will find how many observations are in each factor.
# n() saves time in completing a count

gapminder %>% 
  group_by(continent) %>% 
  summarize(se = sd(lifeExp)/sqrt(n()))

# mutate() is my friend

xy <- data.frame(x = rnorm(100),
                 y =rnorm (100))
head(xy)

xyz <- xy %>%
  mutate(z = x*y)
head(xyz)

# add a column that give full gdp per continent

total_gdp_country <- gapminder %>% 
  group_by(continent) %>% 
  mutate(total_gdp = gdpPercap *
         pop) 

gdp_per_cont <- gapminder %>% 
  mutate(total_gdp = pop*gdpPercap) %>% 
  group_by(continent) %>% 
  summarize(cont_gdp = sum(total_gdp))
gdp_per_cont
