import pandas as pd
import datetime as dt


df = pd.read_csv('Date Format Data.csv')

print(df.head())

df['Cleaned Date'] = pd.to_datetime(df['Created'],format="%d/%m/%Y %H:%M").dt.date

print(df.head())
