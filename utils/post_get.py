import json

# IGCSE
fileorg = "assets/json/igcse.json"
filedest = "assets/json/igcse-subjects.json"
with open(fileorg, "r") as f:
    result = json.load(f)
with open(filedest, "w") as f:
    json.dump(list(result.keys()), f)

# A Level
fileorg = "assets/json/alevel.json"
filedest = "assets/json/alevel-subjects.json"
with open(fileorg, "r") as f:
    result = json.load(f)
with open(filedest, "w") as f:
    json.dump(list(result.keys()), f)
