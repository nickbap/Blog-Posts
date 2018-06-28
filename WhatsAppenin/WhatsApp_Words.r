library(tidyverse)
library(tidytext)
library(stringr)
library(reshape2)
library(lubridate)
library(gridExtra)

'%!in%' <- function(x, y)
  ! ('%in%'(x, y))

data <-
  read_csv("message v2.csv")

notABro <- c("No Person", "not", "Africa")

data <- filter(data, Sender %!in% notABro)

# Tidy Text
text <- data %>%
  unnest_tokens(word, Message) %>%
  anti_join(stop_words)

text %>%
  count(word, sort = TRUE)

# haha
text %>%
  filter(str_detect(word, "haha")) %>%
  count(word, sort = TRUE)

text %>%
  filter(str_detect(word, "haha")) %>%
  count(word, Sender, sort = TRUE) %>%
  mutate(len = nchar(word)) %>%
  arrange(desc(len)) 

# bros ----
bros <- c((unique(data$Sender)), str_to_lower(unique(data$Sender)))
bros <- as.character(bros)

bro <- text %>%
  filter(word %in% bros) %>%
  group_by(Sender) %>%
  count(word, sort = TRUE)

broTable <- dcast(bro, Sender ~ word)

broTable[is.na(broTable)] <- 0

broTable$sum <- rowSums(broTable[, -1])

broTable <- arrange(broTable, desc(broTable$sum))

ggplot(bro, aes(Sender, word)) +
  geom_tile(aes(fill = n), colour = "white") +
  scale_fill_gradient(low = "white", high = "red") +
  ylab("Bro")

# Wes haha lol
data %>%
  filter(Sender == "Wes") %>%
  filter(str_detect(Message, "haha lol|lol haha")) %>%
  mutate(length = nchar(Message)) %>%
  arrange(length) %>%
  select(Sender, Message) %>%
  head()

# my stopwords -------
bros <- c((unique(data$Sender)), str_to_lower(unique(data$Sender)))
bros <- as.character(bros)

bruh <- filter(text, str_detect(text$word, "bruh"))
bruh <- as.character(unique(bruh$word))

ha <- filter(text, str_detect(text$word, "haha"))
ha <- as.character(unique(ha$word))

yea <- text %>%
  filter(str_detect(word, "yea")) %>%
  filter(!str_detect(word, "year")) %>%
  count(word, sort = TRUE)

yea <- unique(yea$word)

nums <- as.character(seq(1, 10))

fuck <- filter(text, str_detect(word, "fuck"))
fuck <- as.character(unique(fuck$word))

shit <- filter(text, str_detect(word, "shit"))
shit <- as.character(unique(shit$word))

randomWords <-
  c(
    "lol",
    "hill",
    "omitted",
    "image",
    "gif",
    "bros",
    "dude",
    "guy",
    "gonna",
    "gotta",
    "da",
    "bro",
    "im",
    "ya",
    "ass"
  )

myStopWords <- c(bros, bruh, ha, yea, nums, fuck, shit, randomWords)

# Text Cleaned -------

textCleaned <- data %>%
  unnest_tokens(word, Message) %>%
  anti_join(stop_words) %>%
  filter(word %!in% myStopWords)

textCleaned %>%
  count(word, sort = T)

textCleaned %>%
  count(word, sort = TRUE) %>%
  filter(n > 1500) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()

textCleaned$Date <- strptime(textCleaned$Date, "%m/%d/%y")
textCleaned$Time <- strptime(textCleaned$Time, "%I:%M:%S %p")
textCleaned$Time <- strftime(textCleaned$Time, format = "%H:%M:%S")
textCleaned$Month <- month(textCleaned$Date)

# Ferburary and March

textCleanedMarch <- textCleaned %>%
  select(Month, Sender, word) %>%
  filter(Month %in% c(2, 3))

marchViz <- textCleanedMarch %>%
  count(word, sort = TRUE) %>%
  filter(n > 225) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col(fill = "royalblue4") +
  xlab(NULL) +
  coord_flip() +
  ggtitle("February & March")

# September

textCleanedSept <- textCleaned %>%
  select(Month, Sender, word) %>%
  filter(Month == 9)

septViz <- textCleanedSept %>%
  count(word, sort = TRUE) %>%
  filter(n > 150) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col(fill = 'green4') +
  xlab(NULL) +
  coord_flip() +
  ggtitle("September")

grid.arrange(marchViz, septViz, ncol = 2)
