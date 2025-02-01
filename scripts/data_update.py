import datetime as dt
from raw import *
from cooked import *
from rules import *
from mwrogue.esports_client import EsportsClient

def fetch_raw(site: EsportsClient):
    rosters = get_rosters(site, write=False) #1

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

    player_imgs = get_player_image_urls(site, list(player_set), write=False) # 2.1

    champions = get_champions(site, False) #2.5

    # champ_players = get_players_champs(site, champions, list(player_set), write=False) #3
    champ_players = {}

    sister_teams = get_sister_teams(site, write=False) #4

    teams = get_teams(site, write=False) #5

    team_redirects = get_team_redirects(site, write=False) #6

    team_renames = get_team_renames(site, write=False) #7

    tournament_results = get_tournament_results(site, write=False) #10
    return (
        rosters, players, player_imgs, champions, champ_players, sister_teams, teams, team_redirects, team_renames, tournament_results
    )

def get_new_rosters(all_rosters):
    with open("data/raw/raw_rosters.json", "r+", encoding='utf-8') as f:
        old_rosters = json.load(f)
    # old_max_date = max([dt.datetime.strptime(r["Date"], '%Y-%m-%d') for r in old_rosters if r["Date"] != ""])
    old_max_date = dt.datetime(dt.datetime.now().year, 1, 1)
    return [r for r in all_rosters if r["Date"] == "" or dt.datetime.strptime(r["Date"], '%Y-%m-%d') >= old_max_date]

def compare_teams(new_teams):
    with open("data/cooked/teams.json", "r+", encoding='utf-8') as f:
        old_teams = json.load(f)
    old_keys, new_keys = set(old_teams.keys()), set(new_teams.keys())
    removed_keys = old_keys - new_keys
    added_keys = new_keys - old_keys
    evolutions = set()
    for k in removed_keys:
        for l in added_keys:
            if k in new_teams[l]["other_names"]:
                evolutions.add((k, l))
    team_edits = {}
    for k in old_keys & new_keys:
        old_team = old_teams[k]
        new_team = new_teams[k]
        if old_team["becomes"] != new_team["becomes"]:
            if k not in team_edits.keys():
                team_edits[k] = {}
            team_edits[k]["becomes"] = new_team["becomes"]
        if old_team["came_from"] != new_team["came_from"]:
            if k not in team_edits.keys():
                team_edits[k] = {}
            team_edits[k]["came_from"] = new_team["came_from"]
        if old_team["highest_level"] != new_team["highest_level"]:
            if k not in team_edits.keys():
                team_edits[k] = {}
            team_edits[k]["highest_level"] = new_team["highest_level"]
        if old_team["image"] != new_team["image"]:
            if k not in team_edits.keys():
                team_edits[k] = {}
            team_edits[k]["image"] = new_team["image"]
        if old_team["name"] != new_team["name"]:
            if k not in team_edits.keys():
                team_edits[k] = {}
            team_edits[k]["name"] = new_team["name"]
        if old_team["op"] != new_team["op"]:
            if k not in team_edits.keys():
                team_edits[k] = {}
            team_edits[k]["op"] = new_team["op"]
        if old_team["region"] != new_team["region"]:
            if k not in team_edits.keys():
                team_edits[k] = {}
            team_edits[k]["region"] = new_team["region"]
        if old_team["short"] != new_team["short"]:
            if k not in team_edits.keys():
                team_edits[k] = {}
            team_edits[k]["short"] = new_team["short"]
        if set(old_team["other_names"]) != set(new_team["other_names"]):
            if k not in team_edits.keys():
                team_edits[k] = {}
            team_edits[k]["other_names"] = new_team["other_names"]
        if set(old_team["sister_teams"]) != set(new_team["sister_teams"]):
            if k not in team_edits.keys():
                team_edits[k] = {}
            team_edits[k]["sister_teams"] = new_team["sister_teams"]
    return_obj = {
        "remove": removed_keys - set([x[0] for x in evolutions]),
        "add": added_keys - set([x[1] for x in evolutions]),
        "modified": team_edits,
        "evolved": [((o, old_teams[o]), (n, new_teams[n])) for o, n in evolutions]
    }
    loc = write_to_json_file("data/cooked", "teams_update", return_obj, delimit=False, format=False)
    with open(loc, 'r+', encoding='utf-8') as f:
        saved_obj = json.load(f)
    return saved_obj


def compare_players(new_players):
    with open("data/cooked/players.json", "r+", encoding='utf-8') as f:
        old_players = json.load(f)
    player_edits = {}
    old_keys, new_keys = set(old_players.keys()), set(new_players.keys())
    removed_keys = old_keys - new_keys
    added_keys = new_keys - old_keys
    evolutions = set()
    for k in removed_keys:
        for l in added_keys:
            if k.lower() in [n.lower() for n in new_players[l]["alternate_names"]] or (
                l.lower().split(" (")[0] == k.lower() and new_players[l]["name"] == old_players[k]["name"]
            ):
                evolutions.add((k, l))
    for k in old_keys & new_keys:
        old_player = old_players[k]
        new_player = new_players[k]
        if old_player["age"] != new_player["age"]:
            if k not in player_edits.keys():
                player_edits[k] = {}
            player_edits[k]["age"] = new_player["age"]
        if old_player["country"] != new_player["country"]:
            if k not in player_edits.keys():
                player_edits[k] = {}
            player_edits[k]["country"] = new_player["country"]
        if old_player["display_name"] != new_player["display_name"]:
            if k not in player_edits.keys():
                player_edits[k] = {}
            player_edits[k]["display_name"] = new_player["display_name"]
        if old_player["image"] != new_player["image"] and new_player["image"] != "":
            if k not in player_edits.keys():
                player_edits[k] = {}
            player_edits[k]["image"] = new_player["image"]
        if old_player["country"] != new_player["country"]:
            if k not in player_edits.keys():
                player_edits[k] = {}
            player_edits[k]["country"] = new_player["country"]
        if old_player["name"] != new_player["name"]:
            if k not in player_edits.keys():
                player_edits[k] = {}
            player_edits[k]["name"] = new_player["name"]
        if old_player["residency"] != new_player["residency"]:
            if k not in player_edits.keys():
                player_edits[k] = {}
            player_edits[k]["residency"] = new_player["residency"]
        if set(old_player["alternate_names"]) != set(new_player["alternate_names"]):
            if k not in player_edits.keys():
                player_edits[k] = {}
            player_edits[k]["alternate_names"] = new_player["alternate_names"]
    return_obj = {
        "remove": removed_keys - set([x[0] for x in evolutions]),
        "add": added_keys - set([x[1] for x in evolutions]),
        "modified": player_edits,
        "evolved": [((o, old_players[o]), (n, new_players[n])) for o, n in evolutions]
    }
    loc = write_to_json_file("data/cooked", "players_update", return_obj, delimit=False, format=False)
    with open(loc, 'r+', encoding='utf-8') as f:
        saved_obj = json.load(f)
    return saved_obj

def compare_rules(source, new_rules, edits={}):
    with open(f"data/rules/{source}.json", "r+", encoding='utf-8') as f:
        old_rules = json.load(f)
    old_keys, new_keys = set(old_rules.keys()), set(new_rules.keys())
    added_keys = new_keys - old_keys
    evolutions = set()
    if len(edits.keys()) > 0:
        for evo in edits["evolved"]:
            evolutions.add((evo[0][0], evo[1][0]))
    changed = {}
    for k in old_keys & new_keys:
        old_rule = old_rules[k]
        new_rule = new_rules[k]
        if len(set(new_rule["exclusive_crosses"]) - set(old_rule["exclusive_crosses"])) > 0:
            if k not in changed.keys():
                changed[k] = {}
            changed[k]["exclusive_crosses"] = set(new_rule["exclusive_crosses"]) - set(old_rule["exclusive_crosses"])
        if len(set(new_rule["regions"]) - set(old_rule["regions"])) > 0:
            if k not in changed.keys():
                changed[k] = {}
            changed[k]["regions"] = set(new_rule["regions"]) - set(old_rule["regions"])
        if len(set(new_rule["valid_players"]) - set(old_rule["valid_players"])) > 0:
            if k not in changed.keys():
                changed[k] = {}
            changed[k]["valid_players"] = set(new_rule["valid_players"]) - set(old_rule["valid_players"])
            
    return_obj = {
        "add": added_keys - set([x[1] for x in evolutions]),
        "modified": changed,
        "evolved": [((o, old_rules[o]), (n, new_rules[n])) for o, n in evolutions]
    }
    loc = write_to_json_file("data/rules", f"{source}_update", return_obj, delimit=False, format=False)
    with open(loc, 'r+', encoding='utf-8') as f:
        saved_obj = json.load(f)
    return saved_obj

def get_new_data(site: EsportsClient):
    # Step 1: Fetch all the raw data but DONT write to file (yet)
    rosters, players, player_imgs, champions, champ_players, sister_teams, teams, team_redirects, team_renames, tournament_results = fetch_raw(site)
    # Step 2: Cook the players and teams WITHOUT writing (yet)
    players_cooked = cook_players_data(site, players, player_imgs, write=False)
    teams_cooked = cook_teams_data(teams, sister_teams, team_renames, team_redirects, rosters, write=False)
    # Step 3: Create the new rules
    revamp_rosters = get_new_rosters(rosters)

    team_rules, teammate_rules, role_rules = create_team_teammate_role_rules(teams_cooked, players_cooked, revamp_rosters, write=False)
    champion_rules = create_champion_rules(players_cooked, champ_players, write=False)
    countries_rules = create_country_rules(players_cooked, write=False)
    finalists_rules = create_worlds_finalist_rules(players_cooked, tournament_results, write=False)
    worlds_participant_rules = create_worlds_participant_rules(players_cooked, tournament_results, write=False)
    # Step 4: Compare
    t_edit = compare_teams(teams_cooked)
    p_edit = compare_players(players_cooked)
    print("TEAMS")
    tr_edit = compare_rules("teams", team_rules, t_edit)
    print("TEAMMATES")
    tmr_edit = compare_rules("teammates", teammate_rules)
    print("ROLES")
    rr_edit = compare_rules("roles", role_rules)
    print("CHAMPIONS")
    chr_edit = compare_rules("champion_counts", champion_rules)
    print("COUNTRIES")
    cor_edit = compare_rules("countries", countries_rules)
    print("FINALISTS")
    fr_edit = compare_rules("finalists", finalists_rules)
    print("WORLDS")
    wr_edit = compare_rules("worlds_participants", worlds_participant_rules)
    # TODO: Parse these results into update files
    return