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
  select(Sample_ID, Sample_Date, K, `NO3-N`, `NH4-N`, Mg, Ca)

bq1_sub <- bq1 |>
  filter(Sample_Date >= ymd("1988-01-01") & Sample_Date <= ymd("1994-12-31")) |>
  select(Sample_ID, Sample_Date, K, `NO3-N`, `NH4-N`, Mg, Ca)

bq2_sub <- bq2 |>
  filter(Sample_Date >= ymd("1988-01-01") & Sample_Date <= ymd("1994-12-31")) |>
  select(Sample_ID, Sample_Date, K, `NO3-N`, `NH4-N`, Mg, Ca)

bq3_sub <- bq3 |>
  filter(Sample_Date >= ymd("1988-01-01") & Sample_Date <= ymd("1994-12-31")) |>
  select(Sample_ID, Sample_Date, K, `NO3-N`, `NH4-N`, Mg, Ca)


# use moving average function --------------------------------------------

prm_ma <- moving_average(prm_sub)
prm_ma

bq1_ma <- moving_average(bq1_sub)
bq1_ma

bq2_ma <- moving_average(bq2_sub)
bq2_ma

bq3_ma <- moving_average(bq3_sub)
bq3_ma


# combine the dataframes -------------------------------------------------

streams <- rbind(prm_ma, bq1_ma, bq2_ma, bq3_ma)


# pivot all streams ------------------------------------------------------

streams_pivot <- streams |>
  pivot_longer(
    cols = c(K, Mg, NO3, Ca, NH4),
    names_to = "ion",
    values_to = "mean_concentration"
  )


# order the ions
streams_pivot$ion <- factor(
  streams_pivot$ion,
  levels = c("K", "NO3", "Mg", "Ca", "NH4")
)


# graph ------------------------------------------------------------------

ggplot(
  streams_pivot,
  mapping = aes(
    x = window_start,
    y = mean_concentration,
    color = stream,
    linetype = stream
  )
) +
  geom_line() +
  facet_wrap(~ion, scales = "free", ncol = 1, ) +
  labs(
    x = "Date",
    y = "ion concentration",
    title = " Concentrations in PR Streams"
  ) +
  geom_vline(xintercept = ymd("1989-09-17"), color = "darkgrey") +
  theme_bw()
