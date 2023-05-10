#!/usr/bin/python3
"""Write a function that queries the Reddit API and prints the titles of the
first 10 hot posts listed for a given subreddit.
Requirements:
Prototype: def top_ten(subreddit)
If not a valid subreddit, print None.
NOTE: Invalid subreddits may return a redirect to search results. Ensure that
you are not following redirects
"""
import requests
import json


def number_of_subscribers(subreddit):
    """Read data from the reddit API"""
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
                       'query=' + subreddit, headers=headers).json()
    res_dict = res['subreddits']
    total = 0
    for subreddit in res_dict:
        total += subreddit['numSubscribers']
    return total


if __name__ == '__main__':
    res = number_of_subscribers('programming')
