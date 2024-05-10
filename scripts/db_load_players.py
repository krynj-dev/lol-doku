import json, requests

raw_player_data = None

with open('cooked/players.json', 'r+', encoding='utf-8') as f:
    raw_player_data = json.load(f)

if raw_player_data is None:
    quit()

for k in list(raw_player_data.keys())[:10]:
    pd = raw_player_data[k]
    # create the player
    res = requests.post('http://localhost:8000/players/', data=pd)
    if res.status_code not in [200, 201]:
        print(f"error {res.status_code}")