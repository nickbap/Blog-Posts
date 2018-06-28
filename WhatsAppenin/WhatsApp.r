library(tidyverse)

'%!in%' <- function(x,y)!('%in%'(x,y))

data <- read_csv("message v2.csv")

nrow(data) # 357120

unique(data$Sender)

notABro <- c("No Person", "not", "Africa")

data <- filter(data, Sender %!in% notABro)

nrow(data) # 351525

1 - (351525 / 357120) # 0.015667

str(data)

data$Date <- strptime(data$Date, "%m/%d/%y")
data$Time <- strptime(data$Time, "%I:%M:%S %p")
data$Time <- strftime(data$Time, format="%H:%M:%S")

write_csv(data, "Whatsapp Cleaned.csv")
