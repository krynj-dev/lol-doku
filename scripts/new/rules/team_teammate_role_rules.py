import json
from shared.util import write_to_json_file, get_team_key, get_player_key

def create_team_teammate_role_rules(cooked_teams: dict, cooked_players: dict, raw_rosters: list):
    team_rules = {}
    teammate_rules = {}
    role_rules = {}
    player_roles = ["Top", "Jungle", "Mid", "Bot", "Support"]
    roster_no = 0
    for roster in raw_rosters:
        roster_no += 1
        print(f"\rRoster {roster_no}/{len(raw_rosters)}", sep=' ', end='', flush=True)
        team_key = get_team_key(cooked_teams, roster["Team"])
        if roster["Roles"] is None or roster["RosterLinks"] is None or len(roster["Roles"]) != len(roster["RosterLinks"]):
            continue
        if team_key is not None:
            region = cooked_teams[team_key]["region"]
            if region != "" and region is not None:
                region_set = set([region])
            else:
                region_set = set()
        else:
            region_set = set()

        for i in range(len(roster["RosterLinks"])):
            player_name = roster["RosterLinks"][i]
            player_key = get_player_key(cooked_players, player_name)
            if player_key is None:
                continue
            for role in roster["Roles"][i].split(','):
                if role not in player_roles:
                    continue
                roster_region = roster["Region"]
                if roster["Region"] != "" and roster["Region"] is not None:
                    region_set.add(roster_region)
                # Add to role rules
                if role not in role_rules.keys():
                    role_rules[role] = {
                        "key": role,
                        "type": "role",
                        "regions": set(["World"]),
                        "valid_players": set(),
                        "exclusive_crosses": set()
                    }
                role_rules[role]["valid_players"].add(player_key)
                # Add to team rules (if team has page)
                if team_key is not None:
                    if team_key not in team_rules.keys():
                        team_rules[team_key] = {
                            "key": team_key,
                            "type": "team",
                            "regions": region_set,
                            "valid_players": set(),
                        "exclusive_crosses": set()
                        }
                    team_rules[team_key]["valid_players"].add(player_key)
                    team_rules[team_key]["regions"] |= region_set
                # Add to teammate rules
                if "" in region_set:
                    print("wtf")
                player_region = cooked_players[player_key]["residency"]
                player_regions = set()
                player_regions.update(region_set)
                if player_region != "":
                    player_regions.add(player_region)
                if "" in player_regions:
                    print("wth")
                if player_key not in teammate_rules.keys():
                    teammate_rules[player_key] = {
                        "key": player_key,
                        "type": "teammate",
                        "regions": player_regions,
                        "valid_players": set(),
                        "exclusive_crosses": set()
                    }
                teammate_rules[player_key]["valid_players"] |= set(
                    [get_player_key(cooked_players, roster["RosterLinks"][i]) for i in range(len(roster["RosterLinks"])) if roster["Roles"][i] in player_roles and player_name != roster["RosterLinks"][i] and get_player_key(cooked_players, roster["RosterLinks"][i]) is not None]
                    )
                teammate_rules[player_key]["regions"] |= player_regions
    
    team_loc = write_to_json_file("data/rules", "teams", team_rules, format=False)
    teammate_loc = write_to_json_file("data/rules", "teammates", teammate_rules, format=False)
    role_loc = write_to_json_file("data/rules", "roles", role_rules, format=False)
    
    with open(team_loc, 'r+', encoding='utf-8') as f:
        saved_teams = json.load(f)
    with open(teammate_loc, 'r+', encoding='utf-8') as f:
        saved_teammates = json.load(f)
    with open(role_loc, 'r+', encoding='utf-8') as f:
        saved_roles = json.load(f)
    return saved_teams, saved_teammates, saved_roles