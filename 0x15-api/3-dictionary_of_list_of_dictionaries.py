#!/usr/bin/python3
""" Gather data from an API"""
import json
import requests

if __name__ == "__main__":

    # fetch user details
    url = "https://jsonplaceholder.typicode.com/users/"
    response = requests.get(url)
    users = json.loads(response.text)  # resp_json ie lst of dicts;dict=user

    # fetch tasks
    url = "https://jsonplaceholder.typicode.com/todos"
    response = requests.get(url)
    tasks = json.loads(response.text)  # resp_json=list of tasks (task = dict)

    # build json dictionary
    all_tasks_json = {
        str(user["id"]): [{"task": task["title"],
                           "completed": task["completed"],
                           "username": user["username"]}
                          for task in [task for task in tasks
                          if task["userId"] == user["id"]]]

        for user in users
    }
    # write string to disk
    filename = "todo_all_employees.json"
    with open(filename, "w") as file:
        json.dump(all_tasks_json, file)
