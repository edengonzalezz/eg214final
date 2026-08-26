library(tidyverse)
source("R/moving-average.R")

# load the data

prm <- read_csv("data/knb-lter-luq/RioMameyesPuenteRoto.csv")
bq1 <- read_csv("data/knb-lter-luq/QuebradaCuenca1-Bisley.csv")
bq2 <- read_csv("data/knb-lter-luq/QuebradaCuenca2-Bisley.csv")
bq3 <- read_csv("data/knb-lter-luq/QuebradaCuenca3-Bisley.csv")

#  raw observations
glimpse(prm)
glimpse(bq1)
glimpse(bq2)
glimpse(bq3)



#  attempt to clean data 

# keep the columns we wil actually be plotting 
# potassium, nitrate, magnesium, calcium, ammonium 
prm_sub <- prm |> 
  filter(Sample_Date >= ymd("1988-01-01") & Sample_Date <= ymd("1994-12-31")) |> 
  select(Sample_ID, Sample_Date, K, `NO3-N`,`NH4-N`, Mg, Ca)

bq1_sub <- bq1 |> 
  filter(Sample_Date >= ymd("1988-01-01") & Sample_Date <= ymd("1994-12-31")) |> 
  select(Sample_ID, Sample_Date, K, `NO3-N`,`NH4-N`, Mg, Ca)

bq2_sub <- bq2 |> 
  filter(Sample_Date >= ymd("1988-01-01") & Sample_Date <= ymd("1994-12-31")) |> 
  select(Sample_ID, Sample_Date, K, `NO3-N`,`NH4-N`, Mg, Ca)

bq3_sub <- bq3 |> 
  filter(Sample_Date >= ymd("1988-01-01") & Sample_Date <= ymd("1994-12-31")) |> 
  select(Sample_ID, Sample_Date, K, `NO3-N`,`NH4-N`, Mg, Ca)





# individual plots 

prm_longer <- pivot_longer(prm_sub, 
cols = K:Ca, 
names_to = "ions",
values_to = "concentration")

prm_graph <- ggplot(prm_longer, mapping = 
  aes(x = Sample_Date, y = concentration, color = ions) ) +
  geom_line() +
  facet_wrap(~ions, scales = "free", ncol = 1) +
  theme_bw()
prm_graph

bq1_longer <- pivot_longer(bq1_sub, 
cols = K:Ca, 
names_to = "ions",
values_to = "concentration")

ggplot(bq1_longer, mapping = 
  aes(x = Sample_Date, y = concentration, color = ions) ) +
  geom_line() +
  facet_wrap(~ions, scales = "free", ncol = 1) +
  theme_bw() +
  theme(legend.position = "none")


bq2_longer <- pivot_longer(bq2_sub, 
cols = K:Ca, 
names_to = "ions",
values_to = "concentration")

ggplot(bq2_longer, mapping = 
  aes(x = Sample_Date, y = concentration, color = ions) ) +
  geom_line() +
  facet_wrap(~ions, scales = "free", ncol = 1) +
  theme_bw()



bq3_longer <- pivot_longer(bq3_sub, 
cols = K:Ca, 
names_to = "ions",
values_to = "concentration")

ggplot(bq3_longer, mapping = 
  aes(x = Sample_Date, y = concentration, color = ions) ) +
  geom_line() +
  facet_wrap(~ions, scales = "free", ncol = 1) +
  theme_bw()





# try to do moving average -----------------------------------------------


# 9 week average  

window_start <- seq(ymd("1988-01-01"), ymd("1994-12-31"), by = "9 weeks")
window_end <- window_start + weeks(9)


prm_ma <- moving_average(prm_sub)
prm_ma

bq1_ma <- moving_average(bq1_sub)
bq1_ma

bq2_ma <- moving_average(bq2_sub)
bq2_ma

bq3_ma <- moving_average(bq3_sub)
bq3_ma





# try to graph moving average --------------------------------------------


prm_pivot <- prm_ma |>
  pivot_longer(
    cols = c(k_mgl, mg_mgl, no3_mgl, ca_mgl, nh4_ugl),
    names_to = "ion",
    values_to = "mean_concentration"
  )
tail(prm_pivot)

ggplot(prm_pivot, mapping = 
  aes(x = window_start, y = mean_concentration, color = ion) ) +
  geom_line() +
  facet_wrap(~ion, scales = "free", ncol = 1) +
  theme_bw()

















# safety blanket code ----------------------------------------------------



qs_pivot <- qs_smoothed |>
  pivot_longer(
    cols = c(mean_k, mean_mg),
    names_to = "ion",
    values_to = "mean_concentration"
  )


ggplot(
  data = qs_pivot,
  mapping = aes(x = window_start, y = mean_concentration, color = ion)
) +
  geom_point() +
  labs(
    x = "Date",
    y = " Mean Concentration",
    title = "Moving average of K and Mg"
  ) +
  theme_bw()
