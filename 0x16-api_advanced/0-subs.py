#!/usr/bin/python3
""" Read data from the reddit API. """
import json
import requests


def number_of_subscribers(subreddit):
    """ Queries the Reddit API and returns the number of subscribers """
    headers = {"User-Agent": "alx2-web-app"}

    url = f"https://www.reddit.com/r/{subreddit}/about.json"
    res = requests.get(url, headers=headers, allow_redirects=False)
    if res.status_code != 200:  # search item not found?
        return 0

    res_json = res.json()  # get json output
    res_data = res_json["data"]  # the required dictionary is in "data" key
    if "subscribers" in res_data:
        num_subscribers = res_data["subscribers"]  # .. in "subscribers" field
    else:
        num_subscribers = 0  # no subscribers
    return num_subscribers


if __name__ == "__main__":
    import sys
    if len(sys.argv) < 2:
        print("Search argument required")
        exit()
    print(number_of_subscribers(sys.argv[1]))
