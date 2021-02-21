import os
import json
import requests

# disable insecure ssl warnings
requests.packages.urllib3.disable_warnings()

URL = "https://10.195.225.136"
USERNAME = "admin"
# get password from envrionment var ACI_PASSWORD
PASSWORD = os.getenv('ACI_PASSWORD')


def login(username, password):
    uri = "/api/aaaLogin.json"
    payload = {
        "aaaUser": {
            "attributes": {
                "name": USERNAME,
                "pwd":  PASSWORD
            }
        }
    }

    headers = {
        "Content-Type": "application/json"
    }

    try:
        res = requests.post(URL+uri, 
                            data=json.dumps(payload),
                            headers=headers,
                            verify=False)
    except requests.exceptions.HTTPError as e:
        print(e)
        return None
    # get token that will be used for rest of API
    return res.json()["imdata"][0]["aaaLogin"]["attributes"]["token"]


def post_payload(uri, payload, token):
    headers = {
        "Cookie": "APIC-Cookie="+token, 
    }

    print("URL:\n"+URL+uri)
    print("payload:\n"+json.dumps(payload, indent=2))
    try:
        res = requests.post(URL+uri,
                            data=json.dumps(payload),
                            headers=headers,
                            verify=False)
    except requests.exceptions.HTTPError as e:
        print(e)
        return False
    print("response:\n"+json.dumps(res.json(), indent=2))
    return True


if __name__ == "__main__":
    # URI of requests
    uri = ""
    # payload copy from API tool
    payload = {}
    token = login(USERNAME, PASSWORD)
    post_payload(uri, payload, token)
