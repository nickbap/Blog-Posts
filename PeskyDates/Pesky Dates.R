library(tidyverse)
library(lubridate)


data <- read_csv("Date Format Data.csv")

head(data)

data$`Cleaned Date` <- dmy_hm(data$Created)

head(data)

data$`Cleaned Date`<- as_date(data$`Cleaned Date`)

head(data)
