#!/usr/bin/python3
""" Gather data from an API"""
import json
import requests
import sys

if __name__ == "__main__":

    user_id = sys.argv[1]

    # fetch user name
    url = "https://jsonplaceholder.typicode.com/users/{}".format(
        str(user_id))
    response = requests.get(url)
    response_json = json.loads(response.text)
    user_name = response_json['name']
    # print("Employee Name: {}".format(user_name))

    # fetch tasks completed
    url = "https://jsonplaceholder.typicode.com/users/{}/todos".format(
        str(user_id))
    response = requests.get(url)
    response_json = json.loads(response.text)
    total_tasks = len(response_json)
    # print("Response_json: \n", response_json)

    completed = 0
    compl_tasks = []
    for task in range(len(response_json)):
        if response_json[task]['completed'] is True:
            compl_tasks.append(response_json[task]["title"])
            completed += 1

    print("Employee {} is done with tasks({}/{}):". format(
          user_name, str(completed), str(total_tasks)))
    for item in compl_tasks:
        print("\t {}".format(item))

    csv_str = ""
    for task in response_json:
        print('"{}","{}","{}","{}"'.format(
             str(user_id), user_name, status, title))
