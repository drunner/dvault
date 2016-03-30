#!/usr/bin/python

import os
import json

with open('/load') as data_file:
    data = json.load(data_file)

print(data["volume"])
