#!/usr/bin/python

import os
import sys
import json
import hvac
import subprocess

with open('/load') as data_file:
   try:
      data = json.load(data_file)
   except ValueError, e:
      sys.stderr.write('Invalid input format:\n', e)
      sys.exit(1)

client = hvac.Client(url=os.environ['VAULT_ADDR'], token=os.environ['VAULT_TOKEN'])
PROJECT = data["project"]

for environment in data["secrets"]:
   for secret in data["secrets"][environment]:
      filename = os.path.basename(secret)
      s = client.read('secret/'+secret)
      client.write('secret/dvault/'+environment+'/'+PROJECT+'/'+filename, value=s["data"]["value"])
