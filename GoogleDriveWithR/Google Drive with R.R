#install.packages("googledrive")

library(tidyverse)
library(googledrive)

# See Files in Google Drive
drive_find(n=5)

# Download Files
drive_download(
  "Excel Python or R Data",
  path = file.path(getwd(), "Data", "Excel Python or R Data.csv"),
  overwrite = TRUE)

# Read File into R
data <- read_csv(file.path(getwd(), "Data", "Excel Python or R Data.csv"))

data$CPD <- data$Spend / data$Downloads

# Return File to Google Drive
write_csv(data, file.path(getwd(), "Data", "Excel Python or R Data v2.csv"))

drive_upload(file.path(getwd(), "Data", "Excel Python or R Data v2.csv"),
             path = "Blog/Excel Python or R Data v2.csv",
             type = "spreadsheet")

# Deletes Files - will delete in all file with this name
drive_rm("Excel Python or R Data v2.csv")

# Deletes Files in Blog Folder
drive_rm("Blog/Excel Python or R Data v2.csv")
