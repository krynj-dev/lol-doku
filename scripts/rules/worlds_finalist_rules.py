import json
from shared.util import write_to_json_file, get_player_key_cached

def create_worlds_finalist_rules(cooked_players: dict, raw_tournament_results: list, write=True):
    worlds_finalist_rules = {}
    playing_roles = ["Top", "Jungle", "Mid", "Bot", "Support"]
    pk_cache = {}
    for team_result in raw_tournament_results:
        event_name = team_result["Event"]
        if "Worlds" in event_name and "Qualif" not in event_name and team_result["Place"] in ["1", "2"]:
            rule_key = "Worlds Finalist"
            if len(team_result["Roles"]) != len(team_result["RosterLinks"]):
                continue
            players = set()
            for i in range(len(team_result["Roles"])):
                for role in team_result["Roles"][i].split(','):
                    if role in playing_roles:
                        players.add(team_result["RosterLinks"][i])
            if rule_key not in worlds_finalist_rules.keys():
                worlds_finalist_rules[rule_key] = {
                    "key": rule_key,
                    "type": "finalist",
                    "regions": set(["World"]),
                    "valid_players": set(),
                    "exclusive_crosses": set()
                }
            p_keys = [get_player_key_cached(cooked_players, p, pk_cache) for p in players]
            worlds_finalist_rules[rule_key]["valid_players"] |= set([x for x in p_keys if x is not None])
    if write:
        finalist_loc = write_to_json_file("data/rules", "finalists", worlds_finalist_rules, format=False)
        with open(finalist_loc, 'r+', encoding='utf-8') as f:
            saved_finalists = json.load(f)
        return saved_finalists
    else:
        return worlds_finalist_rules

def create_worlds_participant_rules(cooked_players: dict, raw_tournament_results: list, write=True):
    pk_cache = {}
    top_16 = set()
    for i in range(1, 17):
        top_16.add(str(i))
        for j in range(i, 17):
            top_16.add(f"{i}-{j}")
    worlds_participant_rules = {}
    playing_roles = ["Top", "Jungle", "Mid", "Bot", "Support"]
    for team_result in raw_tournament_results:
        event_name = team_result["Event"]
        if "Worlds" in event_name and "Qualifier" not in event_name and team_result["Place"] in top_16:
            rule_key = f"{event_name} Participant"
            if len(team_result["Roles"]) != len(team_result["RosterLinks"]):
                continue
            players = set()
            for i in range(len(team_result["Roles"])):
                for role in team_result["Roles"][i].split(','):
                    if role in playing_roles:
                        players.add(team_result["RosterLinks"][i])
            if rule_key not in worlds_participant_rules.keys():
                worlds_participant_rules[rule_key] = {
                    "key": rule_key,
                    "type": "tournament",
                    "regions": set(["World"]),
                    "valid_players": set(),
                    "exclusive_crosses": set()
                }
            p_keys = [get_player_key_cached(cooked_players, p, pk_cache) for p in players]
            worlds_participant_rules[rule_key]["valid_players"] |= set([x for x in p_keys if x is not None])
    if write:
        participant_loc = write_to_json_file("data/rules", "worlds_participants", worlds_participant_rules, format=False)
        with open(participant_loc, 'r+', encoding='utf-8') as f:
            saved_participants = json.load(f)
        return saved_participants
    else:
        return worlds_participant_rules

def create_league_finalist_rules(cooked_players: dict, raw_tournament_results: list, write=True):
    pk_cache = {}
    rules = {}
    playing_roles = ["Top", "Jungle", "Mid", "Bot", "Support"]
    for team_result in raw_tournament_results:
        # Check worlds
        if len(team_result["Roles"]) != len(team_result["RosterLinks"]):
            continue
        players = set()
        for i in range(len(team_result["Roles"])):
            for role in team_result["Roles"][i].split(','):
                if role in playing_roles:
                    players.add(team_result["RosterLinks"][i])
        if team_result['Region'] == 'International':
            event_name = team_result['Name'].replace(" Main Event", "")
            rule_key = f"{event_name} Participant"
            if team_result['Place Number'] != '' and int(team_result['Place Number']) <= 2:
                rule_key_alt = f"{team_result['League']} Finalist"
                if rule_key_alt not in rules:
                    rules[rule_key_alt] = {
                        "key": rule_key_alt,
                        "type": "tournament",
                        "regions": set([team_result['Region']]),
                        "valid_players": set(),
                        "exclusive_crosses": set()
                    }
                p_keys = [get_player_key_cached(cooked_players, p, pk_cache) for p in players]
                rules[rule_key_alt]["valid_players"] |= set([x for x in p_keys if x is not None])
        else:
            assert team_result['Place Number'] == "1"
            rule_key = f"{team_result['ShortName']} Winner"
        if rule_key not in rules:
            rules[rule_key] = {
                "key": rule_key,
                "type": "tournament",
                "regions": set([team_result['Region']]),
                "valid_players": set(),
                "exclusive_crosses": set()
            }
        p_keys = [get_player_key_cached(cooked_players, p, pk_cache) for p in players]
        rules[rule_key]["valid_players"] |= set([x for x in p_keys if x is not None])
    if write:
        loc = write_to_json_file("data/rules", "tournament_results", rules, format=False)
        with open(loc, 'r+', encoding='utf-8') as f:
            saved_rules = json.load(f)
        return saved_rules
    else:
        return rules
            