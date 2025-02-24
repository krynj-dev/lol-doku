import datetime as dt
import re
from raw import *
from mwrogue.esports_client import EsportsClient
from cooked import *
from rules import *

## Data update tasks
# 1. Grab updated team data and find evolutions and additions
# 2. Grab updated player data and find evolutions and additions
# 3. Traverse rosters to update and create rules for teams/teammates

parentheses_match = "(.+) \\(.*\\)"

def get_fresh_teams_data(site: EsportsClient, time):
    sister_teams = get_sister_teams(site, write=False) #4

    teams = get_teams(site, write=False) #5

    team_redirects = get_team_redirects(site, write=False) #6

    team_renames = get_team_renames(site, write=False) #7

    return sister_teams, teams, team_redirects, team_renames

def get_fresh_players_data(site: EsportsClient, rosters):
    player_set = set()
    acceptable_roles = [ "Top", "Jungle", "Mid", "Bot", "Support" ]
    for roster in rosters:
        if roster["Roles"] is not None and roster["RosterLinks"]:
            if len(roster["Roles"]) != len(roster["RosterLinks"]):
                continue
            players = [roster["RosterLinks"][i] for i in range(len(roster["RosterLinks"])) if any(r in acceptable_roles for r in roster["Roles"][i].split(','))]
            for plr in players:
                player_set.add(plr)

    players = get_players(site, list(player_set), write=False) #2

    # champions = get_champions(site, False) #2.5
    champions = {}

    # champ_players = get_players_champs(site, champions, list(player_set), write=False) #3
    champ_players = {}

    return players, champions, champ_players

def compare_teams(old_teams: dict, new_teams: dict):
    old_keys, new_keys = set(old_teams.keys()), set(new_teams.keys())
    added_keys = new_keys - old_keys
    evos = {}

    for k, v in new_teams.items():
        other_names = v["other_names"]
        sister_teams = v["sister_teams"]
        for o_name in other_names + sister_teams:
            if o_name != k and (o_name in old_teams) and o_name not in new_teams:
                evos[o_name] = (k, v)
    
    for k,v in {k:v for k,v in new_teams.items() if k in old_keys & new_keys}.items():
        new_names = set(v["other_names"]) - set(old_teams[k]["other_names"])
        new_sisters = set(v["sister_teams"]) - set(old_teams[k]["sister_teams"])
        if len(new_names) > 0 or len(new_sisters) > 0:
            evos[k] = (k, v)
        
    adds = {k:v for k,v in new_teams.items() if k in added_keys - set([v1[0] for _, v1 in evos.items()])}
    return adds, evos

def compare_teams_new(old_teams: dict, new_teams: dict):
    adds = {k:v for k,v in new_teams.items() if k not in old_teams}
    deactives = set([k for k in old_teams.keys() if get_team_key(old_teams, k) != get_team_key(new_teams, k)])
    changes = {}
    for k,v in {k:v for k,v in new_teams.items() if k not in set(adds.keys()) | deactives}.items():
        ov = old_teams[k]
        diff = {}
        if v["becomes"] != ov["becomes"]:
            diff["becomes"] = ov["becomes"]
        if v["came_from"] != ov["came_from"]:
            diff["came_from"] = ov["came_from"]
        if v["highest_level"] != ov["highest_level"]:
            diff["highest_level"] = ov["highest_level"]
        if v["image"] != ov["image"]:
            diff["image"] = ov["image"]
        if v["name"] != ov["name"]:
            diff["name"] = ov["name"]
        if v["op"] != ov["op"]:
            diff["op"] = ov["op"]
        if v["region"] != ov["region"]:
            diff["region"] = ov["region"]
        if v["short"] != ov["short"]:
            diff["short"] = ov["short"]
        if len(set(v["other_names"]) - set(ov["other_names"])) > 0:
            diff["other_names"] = set(v["other_names"]) - set(ov["other_names"])
        if len(set(v["sister_teams"]) - set(ov["sister_teams"])) > 0:
            diff["sister_teams"] = set(v["sister_teams"]) - set(ov["sister_teams"])
        if diff != {}:
            changes[k] = diff
    return adds, changes, deactives

def compare_players(old_players: dict, new_players: dict):
    old_keys, new_keys = set(old_players.keys()), set(new_players.keys())
    added_keys = new_keys - old_keys
    evos = {}

    for k, v in new_players.items():
        other_names = v["alternate_names"]
        name_match = re.match(parentheses_match, k)
        for o_name in other_names:
            if o_name != k and (o_name in old_players) and o_name not in new_players:
                evos[o_name] = (k, v.copy())
                evos[o_name][1]["alternate_names"] = list(set(evos[o_name][1]["alternate_names"]) - set(old_players[o_name]["alternate_names"]))
            elif (
                name_match and name_match.group(1) in old_players 
                and old_players[name_match.group(1)]["name"] == v["name"]
            ):
                evos[name_match.group(1)] = (k, v.copy())
                evos[name_match.group(1)][1]["alternate_names"] = list(set(evos[name_match.group(1)][1]["alternate_names"]) - set(old_players[name_match.group(1)]["alternate_names"]))
    for k in old_keys-new_keys-set(evos.keys()):
        nk = get_player_key(new_players, k)
        if nk is not None:
            nv = new_players[nk].copy()
            nv["alternate_names"] = list(set(new_players[nk]["alternate_names"]) - set(old_players[k]["alternate_names"]))
            evos[k] = (nk, nv)
            continue
        if nk is None:
            for alt_name in old_players[k]["alternate_names"]:
                nk2 = get_player_key(new_players, alt_name)
                if nk2 is not None and old_players[k]["name"] == new_players[nk2]["name"]:
                    nv2 = new_players[nk2].copy()
                    nv2["alternate_names"] = list(set(new_players[nk2]["alternate_names"]) - set(old_players[k]["alternate_names"])) # removed + [k]
                    evos[k] = (nk2, nv2)
                    continue
    changes = {}
    for k,v in evos.items():
        ov = old_players[get_player_key(old_players, k)]
        diff = {}
        if v[1]["display_name"] != ov["display_name"] and v[1]["display_name"] != "":
            diff["display_name"] = v[1]["display_name"]
        if v[1]["name"] != ov["name"] and v[1]["name"] != "":
            diff["name"] = v[1]["name"]
        if v[1]["country"] != ov["country"] and v[1]["country"] != "":
            diff["country"] = v[1]["country"]
        if v[1]["age"] != ov["age"] and v[1]["age"] != "":
            diff["age"] = v[1]["age"]
        if v[1]["residency"] != ov["residency"] and v[1]["residency"] != "":
            diff["residency"] = v[1]["residency"]
        if len(set(v[1]["alternate_names"]) - set(ov["alternate_names"])) > 0:
            diff["alternate_names"] = set(v[1]["alternate_names"]) - set(ov["alternate_names"])
        if diff != {}:
            changes[k] = diff
    adds = {k:v for k,v in new_players.items() if k in added_keys - set([v1[0] for _, v1 in evos.items()])}
    return adds, changes, []

def compare_rules(old_rules, new_rules, player_evos, compare_key=lambda x: (None, x)):
    compared = {k:compare_key(k) for k in old_rules.keys()}
    changes = {}
    deactives = set([k for k,v in compared.items() if v[0] == 'rem'])
    seen = set()
    adds = {}
    for k,v in {k:v for k,v in old_rules.items() if k in new_rules or compared[k][0] != 'rem'}.items():
        nk = compared[k][1]
        seen.add(nk)
        if nk not in new_rules:
            continue
        nv = new_rules[nk]
        diff = {}
        for f in v.keys():
            if f == "regions":
                continue
            if f not in ["exclusive_crosses", "valid_players"] and v[f] != nv[f]:
                diff[f] = nv[f]
            elif f == "exclusive_crosses" and len(set(nv[f]) - set(v[f])) > 0:
                diff[f] = set(nv[f]) - set(v[f])
            elif f == "valid_players":
                adjusted_players = set()
                for p in v[f]:
                    if p in player_evos:
                        adjusted_players.add(player_evos[p]["display_name"])
                    else:
                        adjusted_players.add(p)
                plr_diff = set(nv[f]) - adjusted_players
                if len(plr_diff) > 0:
                    diff[f] = plr_diff
        if diff != {}:
            changes[k] = diff
    adds = {k:v for k,v in new_rules.items() if k not in seen}
    # Giving the players over to the new one
    for k,v in {k:v for k,v in old_rules.items() if k in deactives}.items():
        nk = compared[k][1]
        if nk in adds:
            adjusted_players = set()
            for p in set(v["valid_players"]):
                if p in player_evos:
                    adjusted_players.add(player_evos[p]["display_name"])
                else:
                    adjusted_players.add(p)
            adds[nk]["exclusive_crosses"] = set(adds[nk]["exclusive_crosses"]) | set(v["exclusive_crosses"])
            adds[nk]["valid_players"] = set(adds[nk]["valid_players"]) | adjusted_players
            # adds[nk]["regions"] = set(adds[nk]["regions"]) | set(v["regions"])
            continue
        if nk is None:
            deactives.add(k)
            continue
        cross_diff = set(v["exclusive_crosses"])
        plr_diff = set(v["valid_players"])
        if nk in old_rules:
            cross_diff -= set(old_rules[nk]["exclusive_crosses"])
            plr_diff -= set(old_rules[nk]["valid_players"])
        adjusted_players = set()
        for p in plr_diff:
            if p in player_evos:
                adjusted_players.add(player_evos[p]["display_name"])
            else:
                adjusted_players.add(p)
        if nk not in old_rules:
            adds[nk] = v
        if nk not in changes:
            changes[nk] = {
                "exclusive_crosses": cross_diff,
                "valid_players": adjusted_players,
            }
        else:
            if "exclusive_crosses" in changes[nk]:
                cross_diff |= set(changes[nk]["exclusive_crosses"])
            if "valid_players" in changes[nk]:
                adjusted_players |= set(changes[nk]["valid_players"])
            if len(cross_diff) > 0:
                 changes[nk]["exclusive_crosses"] = cross_diff
            if len(adjusted_players) > 0:
                changes[nk]["valid_players"] = adjusted_players

    return adds, changes, deactives

def compare_rules_new(old_rules, new_rules, player_evos, compare_key=lambda x: (None, x)):
    adds = {k:v for k,v in new_rules.items() if k not in old_rules}
    deactives = set([k for k in old_rules.keys() if k not in new_rules and compare_key(k) != k])
    changes = {}
    for k,v in {k:v for k,v in new_rules.items() if k not in set(adds.keys()) | deactives}.items():
        ov = old_rules[k]
        adjusted_players = []
        for p in ov["valid_players"]:
            if p in player_evos:
                adjusted_players.append(player_evos[p]["display_name"])
            else:
                adjusted_players.append(p)
        diff = {}
        if len(set(v["valid_players"]) - set(adjusted_players)) > 0:
            diff["valid_players"] = set(v["valid_players"]) - set(adjusted_players)
        if diff != {}:
            changes[k] = diff
    for k in [l for l in deactives if compare_key(l) is not None]:
        if compare_key(k) in adds:
            adds[compare_key(k)]["valid_players"] = set(adds[compare_key(k)]["valid_players"]) | set(old_rules[k]['valid_players'])
        elif compare_key(k) in changes:
            changes[compare_key(k)]["valid_players"] = set(changes[compare_key(k)]["valid_players"]) | set(old_rules[k]['valid_players'])
    for k in [k for k in deactives if compare_key(k) in old_rules]:
        nk = compare_key(k)
        v = old_rules[nk]
        ov = old_rules[k]
        adjusted_players = set()
        plr_diff = set(ov["valid_players"]) - set(v["valid_players"])
        for p in plr_diff:
            if p in player_evos:
                adjusted_players.add(player_evos[p]["display_name"])
            else:
                adjusted_players.add(p)
        diff = {}
        to_add = {}
        if (nk in new_rules):
            to_add = adjusted_players - set(new_rules[nk]["valid_players"])
        else:
            to_add = adjusted_players
        if len(to_add) > 0:
            diff["valid_players"] = to_add
        if diff != {}:
            if nk not in changes:
                changes[nk] = diff
            else:
                changes[nk]["valid_players"] |= diff["valid_players"]

    return adds, changes, deactives

def get_team_key_compare(new_teams, team_evos, team_rems):
    def compare_teams(team_key):
        if team_key in team_rems:
            return ('rem', get_team_key(new_teams, team_key))
        elif team_key in team_evos and "op" in team_evos[team_key]:
            return ('evo', team_evos[team_key]["op"])
        else:
            return (None, team_key)
    return compare_teams

def get_player_key_compare(new_players, player_evos, player_rems):
    def compare_players(player_key):
        if player_key in player_rems:
            return ('rem', get_player_key(new_players, player_key))
        elif player_key in player_evos and "display_name" in player_evos[player_key]:
            return ('evo', player_evos[player_key]["display_name"])
        else:
            return (None, player_key)
    return compare_players

def perform_data_update(site: EsportsClient, time=dt.datetime(dt.datetime.now().year-1, 1, 1)):
    ## Grab new rosters
    all_rosters = get_rosters(site, write=False)
    ## Load old teams
    with open("data/cooked/teams.json", "r+", encoding='utf-8') as f:
        old_teams = json.load(f)
    ## Grab new teams data
    sister_teams, teams, team_redirects, team_renames = get_fresh_teams_data(site, time)
    new_teams = cook_teams_data(teams, sister_teams, team_renames, team_redirects, all_rosters, write=False)
    team_adds, team_evos, team_rems = compare_teams_new(old_teams, new_teams)
    ## Load old players
    with open("data/cooked/players.json", "r+", encoding='utf-8') as f:
        old_players = json.load(f)
    ## Grab new players data
    players, champs, champ_players = get_fresh_players_data(site, all_rosters)
    new_players = cook_players_data(site, players, [], write=False)
    player_adds, player_evos, player_rems = compare_players(old_players, new_players)
    ## Grab tournament results
    new_tournament_results = get_tournament_results(site, write=False)
    ##### RULES ######
    ## Create new rules
    new_rosters = list(filter(lambda x: x['Date'] == '' or dt.datetime.strptime(x['Date'], "%Y-%m-%d")>=time, all_rosters))
    new_team_rules, new_teammate_rules, new_role_rules = create_team_teammate_role_rules(new_teams, new_players, new_rosters, write=False)
    new_finalists_rules = create_worlds_finalist_rules(new_players, new_tournament_results, write=False)
    new_worlds_participant_rules = create_worlds_participant_rules(new_players, new_tournament_results, write=False)
    new_countries_rules = create_country_rules(new_players, write=False)
    new_champions_rules = create_champion_rules(new_players, champ_players, write=False)
    ## Load old rules
    with open(f"data/rules/teams.json", "r+", encoding='utf-8') as f:
        old_team_rules = json.load(f)
    with open(f"data/rules/teammates.json", "r+", encoding='utf-8') as f:
        old_teammates_rules = json.load(f)
    with open(f"data/rules/roles.json", "r+", encoding='utf-8') as f:
        old_roles_rules = json.load(f)
    with open(f"data/rules/finalists.json", "r+", encoding='utf-8') as f:
        old_finalists_rules = json.load(f)
    with open(f"data/rules/worlds_participants.json", "r+", encoding='utf-8') as f:
        old_worlds_participants_rules = json.load(f)
    with open(f"data/rules/countries.json", "r+", encoding='utf-8') as f:
        old_countries_rules = json.load(f)
    with open(f"data/rules/champion_counts.json", "r+", encoding='utf-8') as f:
        old_champion_rules = json.load(f)
    ## Generate rule update files
    team_rule_adds, team_rule_evos, team_rule_rems = compare_rules(old_team_rules, new_team_rules, player_evos, compare_key=get_team_key_compare(new_teams, team_evos, team_rems))
    teammate_rule_adds, teammate_rule_evos, teammate_rule_rems = compare_rules(old_teammates_rules, new_teammate_rules, player_evos, compare_key=get_player_key_compare(new_players, player_evos, player_rems))
    roles_rule_adds, roles_rule_evos, roles_rule_rems = compare_rules_new(old_roles_rules, new_role_rules, player_evos)
    finalists_rule_adds, finalists_rule_evos, finalists_rule_rems = compare_rules_new(old_finalists_rules, new_finalists_rules, player_evos)
    worlds_participants_rule_adds, worlds_participants_rule_evos, worlds_participants_rule_rems = compare_rules_new(old_worlds_participants_rules, new_worlds_participant_rules, player_evos)
    countries_rule_adds, countries_rule_evos, countries_rule_rems = compare_rules_new(old_countries_rules, new_countries_rules, player_evos)
    champions_rule_adds, champions_rule_evos, champions_rule_rems = compare_rules_new(old_champion_rules, new_champions_rules, player_evos)
    ## Save update files
    write_to_json_file("data/update/cooked", "players", {
        "add": player_adds,
        "evo": player_evos,
        "rem": player_rems
    }, format=False)
    write_to_json_file("data/update/cooked", "teams", {
        "add": team_adds,
        "evo": team_evos,
        "rem": team_rems
    }, format=False)
    write_to_json_file("data/update/rules", "teams", {
        "add": team_rule_adds,
        "evo": team_rule_evos,
        "rem": team_rule_rems
    }, format=False)
    write_to_json_file("data/update/rules", "teammates", {
        "add": teammate_rule_adds,
        "evo": teammate_rule_evos,
        "rem": teammate_rule_rems
    }, format=False)
    write_to_json_file("data/update/rules", "roles", {
        "add": roles_rule_adds,
        "evo": roles_rule_evos,
        "rem": roles_rule_rems
    }, format=False)
    write_to_json_file("data/update/rules", "finalists", {
        "add": finalists_rule_adds,
        "evo": finalists_rule_evos,
        "rem": finalists_rule_rems
    }, format=False)
    write_to_json_file("data/update/rules", "worlds_participants", {
        "add": worlds_participants_rule_adds,
        "evo": worlds_participants_rule_evos,
        "rem": worlds_participants_rule_rems
    }, format=False)
    write_to_json_file("data/update/rules", "countries", {
        "add": countries_rule_adds,
        "evo": countries_rule_evos,
        "rem": countries_rule_rems
    }, format=False)
    write_to_json_file("data/update/rules", "champion_counts", {
        "add": champions_rule_adds,
        "evo": champions_rule_evos,
        "rem": champions_rule_rems
    }, format=False)
    return
