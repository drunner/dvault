#!/usr/bin/python

import os
import sys
import json
import hvac

client = hvac.Client(url=os.environ['VAULT_ADDR'], token=os.environ['VAULT_TOKEN'])

with open('/import/config.json') as data_file:    
    data = json.load(data_file)
    
for secret in data["secrets"]:
   filename = os.path.basename(secret)
   f = open('/output/'+filename, 'w')
   s = client.read('secret/'+secret)
   f.write(s["data"]["value"])
   f.close()
