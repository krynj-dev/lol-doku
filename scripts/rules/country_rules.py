import json
from shared.util import write_to_json_file, get_player_key

def create_country_rules(cooked_players: dict, write=True):
    country_rules = {}
    for player_key in cooked_players.keys():
        player = cooked_players[player_key]
        if "country" not in player.keys():
            continue
        country = player["country"]
        if country is None or country == "":
            continue
        if country not in country_rules:
            country_rules[country] = {
                "key": country,
                "type": "country",
                "regions": set(["World"]),
                "valid_players": set(),
                "exclusive_crosses": set()
            }
        country_rules[country]["valid_players"].add(player_key)
    if write:
        loc = write_to_json_file("data/rules", "countries", country_rules, format=False)    
        with open(loc, 'r+', encoding='utf-8') as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return country_rules
    