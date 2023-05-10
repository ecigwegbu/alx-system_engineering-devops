#!/usr/bin/python3
"""
Read data from the reddit API. The programme will check
for the presence of the keyword programming
"""

import json
import requests


def number_of_subscribers(subreddit):
    """
    Write a function that queries the Reddit API and returns the number of
    subscribers (not active users, total subscribers) for a given subreddit.
    If an invalid subreddit is given, the function should return 0
    """
    myID = 'ajjYdzvjEiJSfunPCWQ6kg'
    myKey = '8iKEr-e6aowo2Dl8gJmvntRDPwIflw'
    auth = requests.auth.HTTPBasicAuth(myID, myKey)
    data = {
            'grant_type': 'password',
            'username': 'igwegbu',
            'password': 'FJS-m932S-BWu.8'
           }
    headers = {'User-Agent': 'alx-api-rdt'}

    res = requests.post('https://www.reddit.com/api/v1/access_token',
                        auth=auth, data=data, headers=headers)
    token = res.json()['access_token']
    headers['authorization'] = f'bearer {token}'

    res = requests.get('https://oauth.reddit.com/api/subreddit_autocomplete?' +
                       'query=' + subreddit, headers=headers)
    # print(res.status_code, res.status_code == 200)
    if res.status_code == 404:
        return 0
    res2 = res.json()
    res_dict = res2['subreddits']
    total = 0
    for subreddit in res_dict:
        total += subreddit['numSubscribers']
    return total
