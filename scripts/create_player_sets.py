import time, codecs, datetime as dt, json, os

from mwrogue.esports_client import EsportsClient

site = EsportsClient("lol")

os.makedirs("cooked", exist_ok=True)

raw_player_data = None

with open('raw/players.json', 'r+', encoding='utf-8') as f:
    raw_player_data = json.load(f)

if raw_player_data is not None:
    player_sets = {}
    for raw_player in raw_player_data:
        overview_page = raw_player["OverviewPage"]
        all_name = raw_player["AllName"]
        if overview_page != "" and all_name != "":
            if overview_page not in player_sets:
                player_sets[overview_page] = {
                    "displayName": overview_page,
                    "name": raw_player["Name"],
                    "country": raw_player["Country"],
                    "age": raw_player["Age"],
                    "residency": raw_player["Residency"],
                    "alternateNames": [
                        all_name
                    ]
                }
            else:
                player_sets[overview_page]["alternateNames"].append(all_name)
    with open('cooked/players.json', 'w+', encoding='utf-8') as f:
        json.dump(player_sets, f, ensure_ascii=False, indent=4)
