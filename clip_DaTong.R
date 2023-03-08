library(dplyr)

d2 = df[stcd == "60115000"] %>% select(-(1:2)) %>% unique() %>%
  select(tm, Q = ql, Z = zl, wrz) %>%
  mutate(tm = as.POSIXct(tm))

df1 = fread("Z:/DATA/China/ChinaRunoff_latest/ChinaWater_latest/ChinaWater_river_(20190513Z09-20221115Z08).csv")
d1 = df1[site == 60115000] %>%
  select(tm, Q, Z, wrz) %>%
  mutate(tm = as.POSIXct(tm))

d = rbind(d1, d2) %>%
  .[Q > 0]
fwrite(d, "大通.csv")

{
  library(patchwork)
  library(ggplot2)
  library(Ipaper)

  p1 = ggplot(d, aes(tm, Z)) + geom_line()
  p2 = ggplot(d, aes(tm, Q)) + geom_line()
  p = p1 + p2
  write_fig(p, "a.pdf", 10, 5)
}
