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
