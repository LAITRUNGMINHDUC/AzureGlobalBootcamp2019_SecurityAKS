import csv
import requests
import time

# URL = 'https://ducltm-azurebootcamp.southeastasia.cloudapp.azure.com'
URL = 'http://23.98.74.41'

def send_attack_request(attack_name, attack_url): 
    attack_url = URL + attack_url
    response = requests.get(str(attack_url))
    print (attack_name, ' | Status code: ', str(response.status_code))
    # time.sleep(3)

with open('DSWV-Queries.csv') as csvfile:
    reader = csv.reader(csvfile)
    attack_list = list(reader)
    while True:
        for row in attack_list:
            send_attack_request(row[0], row[1])                
        # requests.get(URL + row[1])
