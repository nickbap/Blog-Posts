import pandas as pd
import tweepy

from tweepy.auth import OAuthHandler
from tweepy_creds import consumer_key, consumer_secret, access_token, access_token_secret


screen_name = 'nick_bap'
keyword = 'python'

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)

tweet_time = []
my_tweet = []
tweet_url = []

for status in tweepy.Cursor(api.user_timeline, screen_name=screen_name).items():
    time = status.created_at
    tweet = status.text
    tweetId = str(status.id)

    url = f'https://twitter.com/{screen_name}/status/{tweetId}'

    tweet_time.append(time)
    my_tweet.append(tweet)
    tweet_url.append(url)

pd.set_option('display.max_colwidth', -1)

df = pd.DataFrame(list(zip(tweet_time, my_tweet, tweet_url)),
                  columns=['Time of Tweet', 'Tweet', 'URL to Tweet'])

print(df.head())

df.to_csv('My Tweets - All.csv', index=False)

df_filtered = df[df['Tweet'].str.contains(keyword, case=False)]

print(df_filtered)

df_filtered.to_csv(f'My Tweets - Filtered for {keyword}.csv', index=False)
