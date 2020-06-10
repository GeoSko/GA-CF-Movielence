#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
from scipy import stats


# In[2]:


# Opening and Comverting the dataset

df = pd.read_csv('u.data', sep = '\t')

# users-movies array
df.columns = ['user','movie','rate','timestamp']
df = df.drop(['timestamp'], axis = 1)
df = df.pivot(index='user', columns='movie', values='rate')
df.fillna(0,inplace = True)

# Selecting the first user, to predict his ratings
my_user = df[:1]

#List of all the other users, except my_user
other_users = df.iloc[1:, :]


# In[3]:


correlation = other_users.corrwith(my_user.iloc[0], axis=1)
df['relation'] = correlation
neighbors = df.nlargest(10,'relation')
population = df.nlargest(50,'relation')
neighbors = neighbors.drop('relation', 1)
population = population.drop('relation', 1)
neighbors.to_csv('10neighbors.csv', index=False,header=False, sep = ",")
my_user.to_csv('my_user.csv', index=False,header=False , sep = ",")

