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