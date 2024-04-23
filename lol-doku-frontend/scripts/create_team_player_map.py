import json, math

player_set = None
team_set = None
raw_roster_data = None

def get_team_key(team_dict, term):
    return next((k for i, k in enumerate(team_dict) if term == team_dict[k]["op"] or term == team_dict[k]["name"]), None)

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
player_to_player = {}
role_to_player = {}

log = ""

filtered_roster_data = list(filter(lambda x: x["TournamentLevel"] in ["Primary", "Secondary"], raw_roster_data))

if player_set is not None and team_set is not None:
    i = 1
    l = len(filtered_roster_data)
    for raw_roster in filtered_roster_data:
        print("\r{}/{}".format(i, l), sep=' ', end='', flush=True)
        team_name = raw_roster["Team"]
        tournament_level = raw_roster["TournamentLevel"]
        if len(raw_roster["RosterLinks"]) != len(raw_roster["Roles"]):
            log += "Ignoring roster for [{}] in competition [{}] as RL and R not equal: {} | {}\n".format(raw_roster["Team"], raw_roster["OverviewPage"], raw_roster["RosterLinks"], raw_roster["Roles"])
            i += 1
            continue
        player_roles = []
        for r, player in zip(raw_roster["Roles"], raw_roster["RosterLinks"]):
            p_key = get_player_key(player_set, player)
            roles = r.split(",")
            for role in roles:
                if role in ["Top", "Jungle", "Mid", "Bot", "Support"] and p_key is not None:
                    player_roles.append((role, p_key))
        if team_name not in team_to_player.keys():
            team_to_player[team_name] = {
                "Primary": set(),
                "Secondary": set()
            }
        for r, p in player_roles:
            if r not in role_to_player.keys():
                role_to_player[r] = {
                    "Primary": set(),
                    "Secondary": set()
                }
            role_to_player[r][tournament_level] |= {p}
            team_to_player[team_name][tournament_level] |= {p}
            if p not in player_to_player.keys():
                player_to_player[p] = {
                    "Primary": set(),
                    "Secondary": set()
                }
            player_to_player[p][tournament_level] |= set([pr[1] for pr in player_roles if pr[1] != p])
        i += 1

compiled_teams = {}
dropped = []

for k in team_to_player.keys():
    # find k overview
    op_keys = []
    for k2 in team_set.keys():
        if k in team_set[k2]["other_names"]:
            op_keys.append(k2)
    if len(op_keys) == 0:
        dropped.append(k)
    elif len(op_keys) > 1:
        perfect_keys = [k2 for k2 in op_keys if team_set[k2]["op"] == k]
        if len(perfect_keys) > 0:
            op_keys = perfect_keys
    for k2 in op_keys:
        if k2 not in compiled_teams.keys():
            compiled_teams[k2] = team_to_player[k]
        else:
            for lk in team_to_player[k]:
                if lk not in compiled_teams[k2]:
                    compiled_teams[k2][lk] = team_to_player[k][lk]
                    continue
                compiled_teams[k2][lk] |= team_to_player[k][lk]

with open('cooked/log_tpm.txt', 'w+', encoding='utf-8') as f:
    f.write(log)
with open('cooked/tpm.json', 'w+', encoding='utf-8') as f:
    json.dump(compiled_teams, f, ensure_ascii=False, indent=4, default=lambda o: list(o))
with open('cooked/ppm.json', 'w+', encoding='utf-8') as f:
    json.dump(player_to_player, f, ensure_ascii=False, indent=4, default=lambda o: list(o))
with open('cooked/rpm.json', 'w+', encoding='utf-8') as f:
    json.dump(role_to_player, f, ensure_ascii=False, indent=4, default=lambda o: list(o))