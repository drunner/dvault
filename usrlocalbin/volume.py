#!/usr/bin/python

import os
import json

with open('/import/config.json') as data_file:    
    data = json.load(data_file)

print(data["volume"])
