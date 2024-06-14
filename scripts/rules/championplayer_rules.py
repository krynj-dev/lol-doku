import json
from shared.util import write_to_json_file, get_player_key

def create_champion_rules(cooked_players: dict, raw_player_champions: list, write=True):
    cumulative_counts = {}
    champion_rules = {}
    for player_champ in raw_player_champions:
        player_key = get_player_key(cooked_players, player_champ["OverviewPage"])
        champion_key = player_champ["Champion"]
        if player_key is not None:
            if player_key not in cumulative_counts:
                cumulative_counts[player_key] = {}
            if champion_key not in cumulative_counts[player_key].keys():
                cumulative_counts[player_key][champion_key] = 0
            cumulative_counts[player_key][champion_key] += int(player_champ["GameCount"])
            # Add to rules
            champ_40_key = f"{champion_key} 40+"
            if cumulative_counts[player_key][champion_key] >= 40:
                if champ_40_key not in champion_rules.keys():
                    champion_rules[champ_40_key] = {
                        "key": champ_40_key,
                        "type": "champion",
                        "regions": set(["World"]),
                        "valid_players": set(),
                        "exclusive_crosses": set()
                    }
                champion_rules[champ_40_key]["valid_players"].add(player_key)
            if cumulative_counts[player_key][champion_key] >= 75:
                any_key = "Any Champion 75+"
                if any_key not in champion_rules.keys():
                    champion_rules[any_key] = {
                        "key": any_key,
                        "type": "champion",
                        "regions": set(["World"]),
                        "valid_players": set(),
                        "exclusive_crosses": set()
                    }
                champion_rules[any_key]["valid_players"].add(player_key)
    if write:
        loc = write_to_json_file("data/rules", "champion_counts", champion_rules, format=False)    
        with open(loc, 'r+', encoding='utf-8') as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return champion_rules
                