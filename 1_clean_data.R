library(tidyverse)
source("R/moving-average.R")


# load  ----------------------------------------------------------

prm <- read_csv("data/RioMameyesPuenteRoto.csv")
bq1 <- read_csv("data/QuebradaCuenca1-Bisley.csv")
bq2 <- read_csv("data/QuebradaCuenca2-Bisley.csv")
bq3 <- read_csv("data/QuebradaCuenca3-Bisley.csv")


# clean  ---------------------------------------------------------

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
bq1_ma <- moving_average(bq1_sub)
bq2_ma <- moving_average(bq2_sub)
bq3_ma <- moving_average(bq3_sub)


# combine the dataframes -------------------------------------------------

<<<<<<< HEAD
streams <- rbind(prm_ma, bq1_ma, bq2_ma, bq3_ma) 
=======
streams <- rbind(prm_ma, bq1_ma, bq2_ma, bq3_ma) |>
  filter(window_start >= ymd("1988-01-01") & window_start < ymd("1994-12-31"))

>>>>>>> 5796ead76d955a89c8dd9d4e32cbde4702b9f365

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


# write_csv() ------------------------------------------------------------

write_csv(streams_pivot, "output/output.csv")
