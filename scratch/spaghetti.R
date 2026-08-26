library(tidyverse)

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

prm_smoothed <- tibble(
  window_start,
  window_end,
  mean_k = NA,
  mean_mg = NA,
  mean_no3 = NA,
  mean_ca = NA,
  mean_nh4 = NA
)
prm_smoothed



for (i in 1:nrow(prm_smoothed)) {
  # i is our iterator
  # 1:nrow(qs_smoothed) is our sequence
  # i will take on those values, one at a time


  start_date <- window_start[i]
  end_date <- window_end[i]

  # what potassium values are inside that window?
  sample_k <- prm_sub$K[
    start_date <= prm_sub$Sample_Date &
      end_date > prm_sub$Sample_Date
  ]
  # what's the mean?
  mean_k <- mean(sample_k, na.rm = TRUE)


  # magnesium values
  mean_mg <- mean(
    prm_sub$Mg[
      start_date <= prm_sub$Sample_Date &
        end_date > prm_sub$Sample_Date
    ],
    na.rm = TRUE
  )

  # calcium
  mean_ca <- mean(
    prm_sub$Ca[
      start_date <= prm_sub$Sample_Date &
        end_date > prm_sub$Sample_Date
    ],
    na.rm = TRUE
  )

  # nitrate
  mean_no3 <- mean(
   prm_sub$`NO3-N`[
     start_date <= prm_sub$Sample_Date &
       end_date > prm_sub$Sample_Date
    ],
    na.rm = TRUE
  )

  # ammonium
  mean_nh4 <- mean(
   prm_sub$`NH4-N`[
     start_date <= prm_sub$Sample_Date &
       end_date > prm_sub$Sample_Date
    ],
    na.rm = TRUE
  )


  # how do you put it in the result?


  prm_smoothed$mean_k[i] <- mean_k
  prm_smoothed$mean_mg[i] <- mean_mg
  prm_smoothed$mean_ca[i] <- mean_ca
  prm_smoothed$mean_no3[i] <- mean_no3
  prm_smoothed$mean_nh4[i] <- mean_nh4


}

tail(prm_smoothed)





# try to graph moving average --------------------------------------------


prm_pivot <- prm_smoothed |>
  pivot_longer(
    cols = c(mean_k, mean_mg, mean_no3, mean_ca, mean_nh4),
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