#!/usr/bin/python3
""" Read data from the reddit API. """
import json
import requests


def count_words(subreddit, word_list):
    """ Queries the Reddit API and returns the count of given words
    based on a givenn subreddit and word list:
        Args:
            subreddit (str):
            word_list (list): word list
    """
    # Build the query string
    if after == "":
        AFTER = ""
    else:
        AFTER = "?after={}".format(after)

    # build page list
    headers = {"User-Agent": "alx2-web-app"}
    url = "https://www.reddit.com/r/{}/hot.json{}".format(subreddit, AFTER)
    res = requests.get(url, headers=headers, allow_redirects=False)
    page_list = []
    if res.status_code != 200:
        return None
    if "children" in res.json()["data"]:
        for child in res.json()["data"]["children"]:
            page_list.append(child["data"]["title"])

    hot_list += page_list
    if "after" not in res.json()["data"]:
        return hot_list
    after = res.json()["data"]["after"]
    if after is None:
        return hot_list

    return recurse(subreddit, hot_list, after)


if __name__ == "__main__":
    import sys
    if len(sys.argv) < 3:
        print("Search argument required")
        exit()
    print(len(count_words(sys.argv[1]), sys.argv[2]))
