## viz.ev.market.share.data.r
library(tidyverse)
library(pubtheme)

df = data.frame(year = 2015:2023,
                ev = c(0.3, 0.4, 0.5, 1.2, 1.3, 1.6, 2.6, 5.2, 6.9),
                hev = c(1.8, 2, 2.1, 2.5, 3.5, 4, 5, 5.5, 8.3))

df$other = 100 - df$ev - df$hev
df

##stacked bar chart
dg = df %>%
  pivot_longer(cols = c(ev, hev, other)) %>%
  mutate(year = as.character(year))

pivot_longer(df, cols = c(ev, hev, other))
dg %>%
  pivot_longer(cols = c(ev, hev, other))

dg

ggplot(dg, 
       aes(x = value, y = year, fill = name)) +
  geom_col()

title = "EV, HEV, and Other Market Share" 
g = ggplot(dg, 
           aes(x = value, 
               y = year, 
               label = round(value,1),
               fill = name)) +
  geom_col(width = 0.8) + 
  #geom_text(hjust = -0.1) + ## optional numbers with reasonable number of digits
  labs(title    = title,
       x        = 'Market Share', ## Optional. 
       y        = 'Year')  ## Optional. Upper Lower.

g %>%
  pub(type = 'bar')

## Stacked bar chart w/out other
title = "EV, HEV, and Other Market Share" 
g = ggplot(dg %>% filter(name != 'other'), 
           aes(x = value, 
               y = year, 
               label = round(value,1),
               fill = name)) +
  geom_col(width = 0.8) + 
  #geom_text(hjust = -0.1) + ## optional numbers with reasonable number of digits
  labs(title    = title,
       x        = 'Market Share', ## Optional. 
       y        = 'Year')  ## Optional. Upper Lower.

g %>%
  pub(type = 'bar')

g + coord_flip()

## Dodged bar chart w/out other
title = "EV, HEV, and Other Market Share" 
g = ggplot(dg %>% filter(name != 'other'), 
           aes(x = value, 
               y = year, 
               label = round(value,1),
               fill = name)) +
  geom_col(width = 0.8,
           position = position_dodge(0.8)) + 
  geom_text(hjust = -0.1,
            position = position_dodge(0.8)) + ## optional numbers with reasonable number of digits
  labs(title    = title,
       x        = 'Market Share', ## Optional. 
       y        = 'Year')  ## Optional. Upper Lower.

g %>%
  pub(type = 'bar')

##flip the coords
##changing hjust to vjust and x and y
g = ggplot(dg %>% filter(name != 'other'), 
           aes(x = year, 
               y = value, 
               label = round(value,1),
               fill = name)) +
  geom_col(width = 0.8,
           position = position_dodge(0.8)) + 
  geom_text(vjust = -0.2,
            position = position_dodge(0.8)) + ## optional numbers with reasonable number of digits
  labs(title    = title,
       x        = 'Market Share', ## Optional. 
       y        = 'Year')  ## Optional. Upper Lower.

g

df = data.frame(date = c('2022-04-01', '2022-08-01', '2022-10-01', '2022-12-01', '2023-03-01', '2023-07-01'),
                price = c(39974, 46974, 51974, 55974, 59974, 49995))

df$date = as.Date(df$date)

g = ggplot(df, 
           aes(x = date, 
               y = price,
               label = dollar(price))) +
  geom_line() +
  geom_point() +
  geom_text(hjust = -0.1) +
  scale_x_date(limits = c(as.Date('2022-03-01'), as.Date('2023-09-20'))) +
  scale_y_continuous(labels = dollar)
g


g %>%
  pub(type = 'line')
