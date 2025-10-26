import json
from shared.util import write_to_json_file, get_player_key


def create_pentakill_rules(cooked_players: dict, pentakills: list, write=True):
    pentakill_rules = {}
    for pentakill in pentakills:
        player_key = get_player_key(cooked_players, pentakill["Link"])
        if player_key is not None:
            count = int(pentakill["Link)"])
            keyf = "{}+ Pentakills"
            # Add to rules
            if count >= 3:
                key = keyf.format(3)
                if key not in pentakill_rules:
                    pentakill_rules[key] = {
                        "key": key,
                        "type": "pentakill",
                        "regions": set(["World"]),
                        "valid_players": set(),
                        "exclusive_crosses": set([keyf.format(2), "Has a Pentakill"]),
                    }
                pentakill_rules[key]["valid_players"].add(player_key)
            if count >= 2:
                key = keyf.format(2)
                if key not in pentakill_rules:
                    pentakill_rules[key] = {
                        "key": key,
                        "type": "pentakill",
                        "regions": set(["World"]),
                        "valid_players": set(),
                        "exclusive_crosses": set([keyf.format(3), "Has a Pentakill"]),
                    }
                pentakill_rules[key]["valid_players"].add(player_key)
            key = "Has a Pentakill"
            if key not in pentakill_rules:
                pentakill_rules[key] = {
                    "key": key,
                    "type": "pentakill",
                    "regions": set(["World"]),
                    "valid_players": set(),
                    "exclusive_crosses": set([keyf.format(3), keyf.format(2)]),
                }
            pentakill_rules[key]["valid_players"].add(player_key)
    if write:
        loc = write_to_json_file(
            "data/rules", "pentakills", pentakill_rules, format=False
        )
        with open(loc, "r+", encoding="utf-8") as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return pentakill_rules
