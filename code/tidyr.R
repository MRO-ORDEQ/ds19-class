# Practice with TidyR

library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)

bikenet <- read_csv("data/bikenet-change.csv")
summary(factor(bikenet$facility2013))

# how have some of these facilities changed over time?

# gather facility columns into single year variable

colnames(bikenet)

bikenet_long <- bikenet %>% 
  gather(key = "year", value = "facility",
         facility2008: facility2013, na.rm = TRUE) %>% 
  mutate(year = stringr::str_sub(year, start = -4))

head(bikenet_long)  

# -----------------------
# Danger below! fname can have multiple words!
# collapse (or unite) street and suffix into one value

bikenet_long <- bikenet_long %>% 
  unite(col = "street", c("fname", "ftype"), sep = " ")

head(bikenet_long)

# separate street and suffix back to two values

bikenet_long <- bikenet_long %>% 
  separate(col = street, c("name", "suffix"))

head(bikenet_long)

# ------------------------

bikenet_long %>% filter(bikeid == 139730)

fac_lengths <- bikenet_long %>% 
  filter(facility %in% c("BKE-LANE", "BKE-BLVD", "BKE-BUFF", 
                         "BKE-TRAK", "PTH-REMU")) %>% 
  group_by(year, facility) %>% 
  summarise(meters = sum(length_m)) %>% 
  mutate(miles = meters / 1609)

# ggplot2 examples

# aes sets aesthetics of the plot

plot <- ggplot(fac_lengths, aes(year, miles, group = facility, color = facility))

# now you can plot different types using the same aesthetics

plot + geom_line()

plot + geom_point()

plot + geom_line() + scale_y_log10()

plot + geom_line() + labs(title = "Change in facilities in Portland",
                          subtitle = "2008 - 2013", caption = "Source: Portland METRO") + 
  xlab("Year") +
  ylab("Total Miles")

# new plot! with facet_wrap function

plot_2 <- ggplot(fac_lengths, aes(x = year, y = miles, group = facility))

plot_2 + geom_line(size = 1, color = "blue") + 
  facet_wrap( ~ facility) + scale_y_log10()

