library(tidyverse)


data <- read_csv("Excel Python or R Data.csv")
countries <- read_csv("Country Lookup.csv")

head(data, n=10)
head(countries)

# Pivot - Spend and Installs by Country Code
data %>%
  group_by(`Country Code`) %>%
  summarise(Spend = sum(Spend), Downloads = sum(Downloads))

# Pivot - Spend and Installs by Country Code filter for US
data %>%
  filter(`Country Code` == "US") %>%
  group_by(`Country Code`) %>%
  summarise(Spend = sum(Spend), Downloads = sum(Downloads))

# Join to get full Country name
data <- left_join(data, countries, by = "Country Code")

print(data)

# Replace NA with "Missing Country Name"
data$Country[is.na(data$Country)] <- "Missing Country Name"

print(data)

# Pivot- Spend, Installs, CPD (Cost per Download) by full Country Name and Date
data %>%
  group_by(Country) %>%
  summarise(NumofCountry = n(),
            Spend = sum(Spend),
            Downloads = sum(Downloads),
            CPD = (Spend/Downloads)) %>%
  drop_na()

# help
?dplyr
?group_by
?summarise