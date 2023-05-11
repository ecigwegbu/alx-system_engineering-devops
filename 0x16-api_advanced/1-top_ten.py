#!/usr/bin/python3
""" Read data from the reddit API. """
import json
import requests


def top_ten(subreddit):
    """ Queries the Reddit API and returns the number of subscribers """
    headers = {"User-Agent": "alx2-web-app"}

    #  GET [/r/subreddit]/hot
    url = "https://www.reddit.com/r/{}/hot.json?limit=10".format(subreddit)
    res = requests.get(url, headers=headers, allow_redirects=False)
    if res.status_code != 200:  # search item not found?
        #  print(res.status_code)  # debug
        print(None)
        return

    #  res.json()["data"]["children"][0]["data"]["title"]
    if "children" not in res.json()["data"]:
        print(None)
        return

    count = 0
    for child in res.json()["data"]["children"]:
        if count < 10:
            print(child["data"]["title"])
            count += 1
        else:
            break
    return


if __name__ == "__main__":
    import sys
    if len(sys.argv) < 2:
        print("Search argument required")
        exit()
    top_ten(sys.argv[1])
