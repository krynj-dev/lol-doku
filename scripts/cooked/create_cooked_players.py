import json
from images import *
from mwrogue.esports_client import EsportsClient

from shared.util import write_to_json_file

def cook_players_data(site: EsportsClient, raw_players: list, raw_player_images: list, write=True):
    player_sets = {}
    for raw_player in raw_players:
        overview_page = raw_player["OverviewPage"]
        all_name = raw_player["AllName"]
        if overview_page != "" and all_name != "":
            if overview_page not in player_sets:
                player_sets[overview_page] = {
                    "display_name": overview_page,
                    "name": raw_player["Name"],
                    "country": raw_player["Country"],
                    "age": raw_player["Age"],
                    "residency": raw_player["Residency"],
                    "alternate_names": [
                        all_name
                    ],
                    "image": raw_player["Image"]
                }
            else:
                player_sets[overview_page]["alternate_names"].append(all_name)
    player_sets = retrieve_player_images(site, player_sets, raw_player_images)
    if write:
        loc = write_to_json_file("data/cooked", "players", player_sets, format=False)
        with open(loc, 'r+', encoding='utf-8') as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return player_sets
    