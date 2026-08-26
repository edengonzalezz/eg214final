library(tidyverse)


source("R/moving-average.R")


# load the data

prm <- read_csv("data/knb-lter-luq/RioMameyesPuenteRoto.csv")
bq1 <- read_csv("data/knb-lter-luq/QuebradaCuenca1-Bisley.csv")
bq2 <- read_csv("data/knb-lter-luq/QuebradaCuenca2-Bisley.csv")
bq3 <- read_csv("data/knb-lter-luq/QuebradaCuenca3-Bisley.csv")


# clean the data ---------------------------------------------------------


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

glimpse(prm_sub)



# use moving average function --------------------------------------------


prm_ma <- moving_average(prm_sub)
prm_ma

bq1_ma <- moving_average(bq1_sub)
bq1_ma

bq2_ma <- moving_average(bq2_sub)
bq2_ma

bq3_ma <- moving_average(bq3_sub)
bq3_ma





# pivot  --------------------------------------------------------------------



prm_pivot <- prm_ma |>
  pivot_longer(
    cols = c(k_mgl, mg_mgl, no3_mgl, ca_mgl, nh4_ugl),
    names_to = "ion",
    values_to = "mean_concentration"
  )

bq1_pivot <- bq1_ma |>
  pivot_longer(
    cols = c(k_mgl, mg_mgl, no3_mgl, ca_mgl, nh4_ugl),
    names_to = "ion",
    values_to = "mean_concentration"
  )

bq2_pivot <- bq2_ma |>
  pivot_longer(
    cols = c(k_mgl, mg_mgl, no3_mgl, ca_mgl, nh4_ugl),
    names_to = "ion",
    values_to = "mean_concentration"
  )

bq3_pivot <- bq3_ma |>
  pivot_longer(
    cols = c(k_mgl, mg_mgl, no3_mgl, ca_mgl, nh4_ugl),
    names_to = "ion",
    values_to = "mean_concentration"
  )








# plot -------------------------------------------------------------------



ggplot(prm_pivot, mapping = 
  aes(x = window_start, y = mean_concentration, color = ion) ) +
  geom_line() +
  facet_wrap(~ion, scales = "free", ncol = 1) +
  labs(x = "Date",
    y = "ion concentration",
    title = " PRM") +
  theme_bw()


ggplot(bq1_pivot, mapping = 
  aes(x = window_start, y = mean_concentration, color = ion) ) +
  geom_line() +
  facet_wrap(~ion, scales = "free", ncol = 1) + 
  labs(x = "Date",
    y = "ion concentration",
    title = " BQ1") +
  theme_bw()



ggplot(bq2_pivot, mapping = 
  aes(x = window_start, y = mean_concentration, color = ion) ) +
  geom_line() +
  facet_wrap(~ion, scales = "free", ncol = 1) +
  labs(x = "Date",
    y = "ion concentration",
    title = " BQ2") +
  theme_bw()


ggplot(bq3_pivot, mapping = 
  aes(x = window_start, y = mean_concentration, color = ion) ) +
  geom_line() +
  facet_wrap(~ion, scales = "free", ncol = 1) +
  labs(x = "Date",
    y = "ion concentration",
    title = " BQ3") +
  theme_bw()


