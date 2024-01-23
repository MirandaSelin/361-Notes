## viz.ev.market.share.data.r
library(tidyverse)

df = data.frame(year = 2015:2023,
                ev = c(0.3, 0.4, 0.5, 1.2, 1.3, 1.6, 2.6, 5.2, 6.9),
                hev = c(1.8, 2, 2.1, 2.5, 3.5, 4, 5, 5.5, 8.3))

df$other = 100 - df$ev - df$hev
df

##stacked bar chart
dg = df %>%
  pivot_longer(cols = c(ev, hev, other))
dg

ggplot(dg, 
       aes(x = value, y = year, fill = name)) +
  geom_col(position = "stack") +
  scale_fill_manual(values = c("blue", "red", "grey")) +
  labs(x = "Year", y = "Market Share (%)", fill = "Vehicle Type") +
  theme_bw() +
  theme(legend.position = "bottom")                
