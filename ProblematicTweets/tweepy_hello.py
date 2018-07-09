import tweepy

from tweepy.auth import OAuthHandler
from tweepy_creds import consumer_key, consumer_secret, access_token, access_token_secret

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)

public_tweets = api.home_timeline()  # Twitter's Home timeline
for tweet in public_tweets:
    print(tweet.text)

my_tweets = api.user_timeline(screen_name='katyperry')  # Katy Perry's timeline
for tweet in my_tweets:
    print(tweet.text)

print(my_tweets)  # print full response
