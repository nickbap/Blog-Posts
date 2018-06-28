import pandas as pd
import re


msgDate = []
msgTime = []
msgSender = []
msg = []

with open('_chat.txt', 'r', encoding='utf-8') as f:

    test = f.readlines()

    start = 1
    numItems = len(test)

    want = range(start, numItems)

    for row in want:

        datePattern = '(\d+/\d+/\d+)'

        try:
            date = re.search(datePattern, test[row]).group(0)
        except AttributeError:
            date = "No Date"

        msgDate.append(date)

        timePattern = '\d+:\d+:\d+ \w\w'

        try:
            time = re.search(timePattern, test[row]).group(0)
        except AttributeError:
            time = "No Time"

        msgTime.append(time)

        personPattern = '[\]]\s\w+'

        try:
            person = re.search(personPattern, test[row]).group(0).replace("] ", "")
        except AttributeError:
            person = "No Person"

        msgSender.append(person)

        messagePattern = '(:\s).*'

        try:
            message = re.search(messagePattern, test[row]).group(0).replace(": ", "")
        except AttributeError:
            message = "No message"

        msg.append(message)

# print(msgDate)
# print(msgTime)
# print(msgSender)
# print(msg)

df = pd.DataFrame(list(zip(msgDate, msgTime, msgSender, msg)),
                  columns=['Date', 'Time', 'Sender', 'Message'])

df.to_csv("message v2.csv", index=False)
