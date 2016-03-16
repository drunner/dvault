#!/usr/bin/python

import os
import sys
import json
import hvac
import subprocess

PROJECT = sys.argv[1]
SECRET_PATH = "secret/dvault/"+os.environ['VAULT_ENV']+"/"+PROJECT+"/"

client = hvac.Client(url=os.environ['VAULT_ADDR'], token=os.environ['VAULT_TOKEN'])

def load_secrets(project):
   try:
      secrets = subprocess.check_output(["vault", "list", "-format=json", SECRET_PATH])
      secrets = json.loads(secrets)
   except ValueError, e:
      return json.loads('[]')
   return secrets
   
def extra_secrets(common_secrets):
   data = json.loads(common_secrets)
   if os.environ['VAULT_ENV'] not in data:
      return
   for secret in data[os.environ['VAULT_ENV']]:
      filename = os.path.basename(secret)
      f = open('/tmp/output/'+filename, 'w')
      s = client.read('secret/'+secret)
      f.write(s["data"]["value"])
      f.close()

secrets = load_secrets(PROJECT)

for secret in secrets:
   s = client.read(SECRET_PATH+secret)
   if secret == 'dvault.json':
      extra_secrets(s["data"]["value"])
      continue
   f = open('/tmp/output/'+secret, 'w')
   f.write(s["data"]["value"])
   f.close()
