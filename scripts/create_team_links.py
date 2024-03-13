import json

with open('cooked/tpm.json', 'r+', encoding='utf-8') as f:
    raw_tpm = json.load(f)

with open('cooked/teams.json', 'r+', encoding='utf-8') as f:
    raw_teams = json.load(f)

compiled_teams = {}
dropped = []

for k in raw_tpm.keys():
    # find k overview
    op_keys = []
    for k2 in raw_teams.keys():
        if k in [n.lower() for n in raw_teams[k2]["other_names"]]:
            op_keys.append(k2)
    if len(op_keys) == 0:
        dropped.append(k)
    for k2 in op_keys:
        if k2 not in compiled_teams.keys():
            compiled_teams[k2] = raw_tpm[k]
        else:
            for lk in raw_tpm[k]:
                if lk not in compiled_teams[k2]:
                    compiled_teams[k2][lk] = raw_tpm[k][lk]
                    continue
                for r in raw_tpm[k][lk]:
                    if r not in compiled_teams[k2][lk]:
                        compiled_teams[k2][lk][r] = raw_tpm[k][lk][r]
                        continue
                    compiled_teams[k2][lk][r] += raw_tpm[k][lk][r]

with open('cooked/tpm_reduced.json', 'w+', encoding='utf-8') as f:
    json.dump(compiled_teams, f, ensure_ascii=False, indent=4, default=lambda o: list(o))

with open('cooked/tpm_reduced_log.txt', 'w+', encoding='utf-8') as f:
    f.write('\n'.join(["Teams Dropped: {}".format(len(dropped))]+dropped))


team_links = {}
level_order = ["Primary", "Secondary", "Showmatch", ""]

def get_team_player_sets(team_players):
    team_player_sets = {}
    for i in range(len(level_order)):
        if level_order[i] not in team_players.keys():
            continue
        if level_order[i] not in team_player_sets.keys():
            team_player_sets[level_order[i]] = set()
        for r in team_players[level_order[i]].keys():
            team_player_sets[level_order[i]] |= set(team_players[level_order[i]][r])
        # Add all above too
        for j in range(i):
            if level_order[j] not in team_player_sets.keys():
                continue
            team_player_sets[level_order[i]] |= team_player_sets[level_order[j]]
    return team_player_sets

l = len(compiled_teams.keys())

key_list = list(compiled_teams.keys())

for i in range(len(key_list)):
    key_a = key_list[i]
    print("\r{}/{}".format(i, l), sep=' ', end='', flush=True)
    team_a_players = compiled_teams[key_a]
    team_a_player_sets = get_team_player_sets(team_a_players)
    # print(team_a_player_sets)
    for j in range(i+1, len(key_list)):
        key_b = key_list[j]
        if key_a == key_b:
            continue
        team_b_players = compiled_teams[key_b]
        team_b_player_sets = get_team_player_sets(team_b_players)
        for level_key in team_a_player_sets.keys():
            if level_key in team_b_player_sets.keys():
                common_players = team_a_player_sets[level_key].intersection(team_b_player_sets[level_key])
                if len(common_players) > 0:
                    if key_a not in team_links.keys():
                        team_links[key_a] = {}
                    if level_key not in team_links[key_a].keys():
                        team_links[key_a][level_key] = {}
                    if key_b not in team_links[key_a][level_key].keys():
                        team_links[key_a][level_key][key_b] = common_players
                    else:
                        team_links[key_a][level_key][key_b] |= common_players

                    if key_b not in team_links.keys():
                        team_links[key_b] = {}
                    if level_key not in team_links[key_b].keys():
                        team_links[key_b][level_key] = {}
                    if key_a not in team_links[key_b][level_key].keys():
                        team_links[key_b][level_key][key_a] = common_players
                    else:
                        team_links[key_b][level_key][key_a] |= common_players
                            
                # print(a_b)
    i += 1
                
with open('cooked/ttm.json', 'w+', encoding='utf-8') as f:
    json.dump(team_links, f, ensure_ascii=False, indent=4, default=lambda o: list(o), sort_keys=True)
