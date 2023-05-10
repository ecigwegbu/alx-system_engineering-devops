#!/usr/bin/python3
''' Read data from the reddit API. '''
import json
import requests


def recurse(subreddit, hot_list=[], after=''):
    ''' Queries the Reddit API and returns the number of subscribers '''

    # Build the query string
    if after == '':
        AFTER = ''
    else:
        AFTER = '?after={}'.format(after)

    # build page list
    headers = {'User-Agent': 'alx2-web-app'}
    url = f'https://www.reddit.com/r/{subreddit}/hot.json{AFTER}'
    res = requests.get(url, headers=headers, allow_redirects=False)
    page_list = []
    if res.status_code != 200:
        return None
    if 'children' in res.json()['data']:
        for child in res.json()['data']['children']:
            page_list.append(child['data']['title'])

    hot_list += page_list
    if 'after' not in res.json()['data']:
        return hot_list
    after = res.json()['data']['after']
    if after is None:
        return hot_list

    return recurse(subreddit, hot_list, after)
