#!/usr/bin/python3
# This script imports reddidt API data
""" A function that reads data from the reddit API and returns the number
of subscribers for a given subreddit.
    Args:
        subreddit (str)
        example: "programming"
        passed to command line
"""
import json
import requests


def number_of_subscribers(subreddit):
    """ Queries the Reddit API and returns the number of subscribers
    for a given subreddit, such as programming
        Args:
            subreddit (str)
            example: "programming"
    """
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
