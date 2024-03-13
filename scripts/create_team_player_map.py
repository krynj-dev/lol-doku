import json, math

player_set = None
team_set = None
raw_roster_data = None

def get_team_key(team_dict, term):
    return next((k for i, k in enumerate(team_dict) if term.lower() == team_dict[k]["op"].lower() or term.lower() == team_dict[k]["name"].lower()), None)

def get_player_key(player_set, term):
    keys = [k for k in player_set.keys() if term.lower() in [n.lower() for n in player_set[k]["alternate_names"]]]
    if len(keys) > 1:
        print("\rFound multiple options for {}: {}".format(term, keys), flush=True)
        keys = [k for k in keys if term in player_set[k]["alternate_names"]]
        if len(keys) > 1:
            print("Ree")
            return None
        else:
            print("Case sensitive resolved [{}] to [{}]".format(term, keys[0]))
            return keys[0]
    elif len(keys) == 0:
        return None
    else:
        return keys[0]

def truncate_tournament_level(level):
    prio = ["Primary", "Secondary", "Showmatch", ""]
    if level not in prio:
        return ""
    return level

with open('cooked/teams.json', 'r+', encoding='utf-8') as f:
    team_set = json.load(f)
with open('cooked/players.json', 'r+', encoding='utf-8') as f:
    player_set = json.load(f)
with open('raw/team_rosters.json', 'r+', encoding='utf-8') as f:
    raw_roster_data = json.load(f)

team_to_player = {}

log = ""

if player_set is not None and team_set is not None:
    i = 1
    l = len(raw_roster_data)
    for raw_roster in raw_roster_data:
        print("\r{}/{}".format(i, l), sep=' ', end='', flush=True)
        team_name = raw_roster["Team"].lower()
        tournament_level = truncate_tournament_level(raw_roster["TournamentLevel"])
        team_set_membership = [k for k in team_set.keys() if team_name in [t.lower() for t in team_set[k]["other_names"]]]
        if len(raw_roster["RosterLinks"]) != len(raw_roster["Roles"]):
            log += "Ignoring roster for [{}] in competition [{}] as RL and R not equal: {} | {}\n".format(raw_roster["Team"], raw_roster["OverviewPage"], raw_roster["RosterLinks"], raw_roster["Roles"])
            i += 1
            continue
        player_roles = []
        for r, player in zip(raw_roster["Roles"], raw_roster["RosterLinks"]):
            p_key = get_player_key(player_set, player)
            roles = r.split(",")
            for role in roles:
                if role not in ["Coach", "Substitute"] and p_key is not None:
                    player_roles.append((role, p_key))
        if team_name not in team_to_player.keys():
            team_to_player[team_name] = {
                tournament_level: {}
            }
        elif tournament_level not in team_to_player[team_name].keys():
            team_to_player[team_name][tournament_level] = {}
        for r, p in player_roles:
            if r not in team_to_player[team_name][tournament_level].keys():
                team_to_player[team_name][tournament_level][r] = {p}
            else:
                team_to_player[team_name][tournament_level][r] |= {p}
        i += 1

with open('cooked/log_tpm.txt', 'w+', encoding='utf-8') as f:
    f.write(log)
with open('cooked/tpm.json', 'w+', encoding='utf-8') as f:
    json.dump(team_to_player, f, ensure_ascii=False, indent=4, default=lambda o: list(o))