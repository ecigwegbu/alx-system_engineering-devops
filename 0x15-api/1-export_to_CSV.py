#!/usr/bin/python3
""" Gather data from an API"""
import json
import requests
import sys

if __name__ == "__main__":

    user_id = sys.argv[1]

    # fetch user details
    url = "https://jsonplaceholder.typicode.com/users/{}".format(
        str(user_id))
    response = requests.get(url)
    response_json = json.loads(response.text)
    employee_name = response_json['name']
    user_name = response_json['username']

    # fetch tasks completed
    url = "https://jsonplaceholder.typicode.com/users/{}/todos".format(
        str(user_id))
    response = requests.get(url)
    response_json = json.loads(response.text)  # list of tasks (task = dict)

    # build csv string
    csv_str = ""
    for task in response_json:
        #  if task['completed'] is True:
        csv_str += '"{}","{}","{}","{}"\n'.format(
            str(user_id), user_name, task["completed"], task["title"])

    # write string to disk
    filename = "{}.csv".format(str(user_id))
    with open(filename, "w") as file:
        file.write(csv_str)
