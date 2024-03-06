import time, codecs, datetime as dt, json, os
from functools import cmp_to_key

os.makedirs("cooked", exist_ok=True)

def compare_roster_recency(a, b):
    # print(a, b, end="\t")
    in_a = ["Primary" in a and a["Primary"] != '', "Secondary" in a and a["Secondary"] != '', "" in a and a[""] != '']
    in_b = ["Primary" in b and b["Primary"] != '', "Secondary" in b and b["Secondary"] != '', "" in b and b[""] != '']
    # print(in_a, in_b)
    if in_a[0] and in_b[0]:
        if dt.datetime.strptime(a["Primary"], "%Y-%m-%d") > dt.datetime.strptime(b["Primary"], "%Y-%m-%d"):
            return 1
        else:
            return -1
    elif in_a[0] and not in_b[0]:
        return 1
    elif not in_a[0] and in_b[0]:
        return -1
    elif in_a[1] and in_b[1]:
        if dt.datetime.strptime(a["Secondary"], "%Y-%m-%d") > dt.datetime.strptime(b["Secondary"], "%Y-%m-%d"):
            return 1
        else:
            return -1
    elif in_a[1] and not in_b[1]:
        return 1
    elif not in_a[1] and in_b[1]:
        return -1
    elif in_a[2] and in_b[2]:
        if dt.datetime.strptime(a[""], "%Y-%m-%d") > dt.datetime.strptime(b[""], "%Y-%m-%d"):
            return 1
        else:
            return -1
    elif in_a[2] and not in_b[2]:
        return 1
    elif not in_a[2] and in_b[2]:
        return -1
    else:
        return 1

def get_set_list_key(set_list):
    def set_list_key(a):
        is_parent = False
        is_sibling = False
        is_child = False
        for k in set_list.keys():
            if k != a:
                if a in set_list[k]["other_names"]:
                    is_child = True
                # if a in set_list[k]["sister_teams"]:
                #     is_sibling = True
                if a in set_list[k]["future_names"]:
                    is_parent = True
            if is_child and is_parent and is_sibling:
                break
        if is_child and not is_parent: # starting evolution
            return -1
        elif is_child and is_parent: # middle evolution
            return 0
        elif not is_child and is_parent: # final evolution
            return 1
        return 2 # no evolution line
    return set_list_key


raw_team_data = None
raw_rename_data = None
raw_sister_data = None
raw_roster_data = None

with open('raw/teams.json', 'r+', encoding='utf-8') as f:
    raw_team_data = json.load(f)
with open('raw/team_renames.json', 'r+', encoding='utf-8') as f:
    raw_rename_data = json.load(f)
with open('raw/sister_teams.json', 'r+', encoding='utf-8') as f:
    raw_sister_data = json.load(f)
with open('raw/team_rosters.json', 'r+', encoding='utf-8') as f:
    raw_roster_data = json.load(f)

if raw_team_data is not None and raw_rename_data is not None and raw_sister_data is not None and raw_roster_data is not None:
    team_sets = {}
    for raw_team in raw_team_data:
        overview_page = raw_team["OverviewPage"]
        key = raw_team["Name"]
        # key = overview_page
        if key == "":
            key = overview_page
        if overview_page not in team_sets:
            team_sets[overview_page] = {
                "name": overview_page,
                "other_names": [key],
                "sister_teams": [],
                "short": raw_team["Short"],
                "region": raw_team["Region"],
                "image": raw_team["Image"],
                "future_names": []
            }
        else:
            team_sets[overview_page]["other_names"].append(key)
    ## Prepare roster data for renames
    roster_recency = {}
    for raw_roster in raw_roster_data:
        team_name = raw_roster["Team"]
        tournament_level = raw_roster["TournamentLevel"]
        if raw_roster["Team"] not in roster_recency:
            roster_recency[raw_roster["Team"]] = {
                tournament_level: raw_roster["Date"]
            }
        else:
            if tournament_level not in roster_recency[team_name] or roster_recency[team_name][tournament_level] < raw_roster["Date"]:
                roster_recency[team_name][tournament_level] = raw_roster["Date"]
    
    ## Handle renames
    log = ""
    for raw_rename in raw_rename_data:
        name_old = raw_rename["OriginalName"]
        name_new = raw_rename["NewName"]
        verb = raw_rename["Verb"]
        date = raw_rename["Date"]
        if verb is not None and verb != "acquire":
            k_old = next((k for i, k in enumerate(team_sets) if team_sets[k]["name"] == name_old or name_old in team_sets[k]["other_names"]), None)
            k_new = next((k for i, k in enumerate(team_sets) if team_sets[k]["name"] == name_new or name_new in team_sets[k]["other_names"]), None)
            if k_old is not None and k_new is not None:
                # Add the old team names to the new one
                # print("{} -> {}".format(k_old, k_new))
                team_sets[k_new]["other_names"] += [t for t in team_sets[k_old]["other_names"] if t not in team_sets[k_new]["other_names"]]
                if k_old not in team_sets[k_new]["other_names"]:
                    team_sets[k_new]["other_names"].append(k_old)
                if k_new not in team_sets[k_old]["future_names"]:
                    team_sets[k_old]["future_names"].append(k_new)
                # print(team_sets[k_new]["other_names"])
            elif k_old is not None:
                team_sets[name_new] = {
                    "name": name_new,
                    "other_names": [name_new] + team_sets[k_old]["other_names"],
                    "sister_teams": [],
                    "short": None,
                    "region": None,
                    "image": None,
                    "future_names": []
                }
                team_sets[k_old]["future_names"].append(name_new)
            elif k_new is not None:
                if name_old not in team_sets[k_new]["other_names"]:
                    team_sets[k_new]["other_names"].append(name_old)
            else:
                team_sets[name_new] = {
                    "name": name_new,
                    "other_names": [name_new, name_old],
                    "sister_teams": [],
                    "short": None,
                    "region": None,
                    "image": None,
                    "future_names": []
                }

    # Populate Sister Teams
    for raw_sister in raw_sister_data:
        sister_team = raw_sister["Team"]
        assoc_teams = raw_sister["AllTeams"]
        k_team = next((k for i, k in enumerate(team_sets) if k == sister_team or sister_team == team_sets[k]["other_names"][0]), None)
        if k_team is not None:
            for sister in assoc_teams:
                k_sister = [k for i, k in enumerate(team_sets) if k == sister or sister == team_sets[k]["other_names"][0]]
                for op_sister in k_sister:
                    if op_sister != team_sets[k_team]["name"] or op_sister != k_team:
                        team_sets[k_team]["sister_teams"].append(op_sister)
                if (sister != team_sets[k_team]["name"] or sister != k_team) and sister not in team_sets[k_team]["sister_teams"]:
                    team_sets[k_team]["sister_teams"].append(sister)

    slk_func = get_set_list_key(team_sets)
    
    # Do merging
    sorted_list = [k for k in sorted(team_sets.keys(), key=slk_func)]

    cur_phase = -1
    phase_0_cleanup = []
    phase_1_begun = False
    for k in sorted_list:
        cur_phase = slk_func(k)
        s = team_sets[k]
        if cur_phase == -1:
            give_to = set(s["other_names"] + s["sister_teams"])
            for receiver in give_to:
                k_rec = next((k for i, k in enumerate(team_sets) if k == receiver or team_sets[k]["other_names"] == receiver), None)
                if k_rec is not None:
                    # Give info over
                    team_sets[k_rec]["other_names"] = list(set(team_sets[k_rec]["other_names"] + s["other_names"]))
                    team_sets[k_rec]["sister_teams"] = list(set(team_sets[k_rec]["sister_teams"] + s["sister_teams"]))
            del(team_sets[k])
            slk_func = get_set_list_key(team_sets)
        elif cur_phase == 0:
            give_to = set(s["other_names"] + s["sister_teams"])
            for receiver in give_to:
                k_rec = next((k for i, k in enumerate(team_sets) if k == receiver or team_sets[k]["other_names"] == receiver), None)
                if k_rec is not None:
                    # Give info over
                    team_sets[k_rec]["other_names"] = list(set(team_sets[k_rec]["other_names"] + s["other_names"]))
                    team_sets[k_rec]["sister_teams"] = list(set(team_sets[k_rec]["sister_teams"] + s["sister_teams"]))
            phase_0_cleanup.append(k)
        elif cur_phase >= 1:
            if not phase_1_begun:
                for delk in phase_0_cleanup:
                    del(team_sets[delk])
                slk_func = get_set_list_key(team_sets)
                phase_1_begun = True
            give_to = set(s["other_names"] + s["sister_teams"])
            for receiver in give_to:
                k_rec = next((k for i, k in enumerate(team_sets) if k == receiver or team_sets[k]["other_names"] == receiver), None)
                if k_rec is not None:
                    # Give info over
                    team_sets[k_rec]["other_names"] = list(set(team_sets[k_rec]["other_names"] + s["other_names"]))
                    team_sets[k_rec]["sister_teams"] = list(set(team_sets[k_rec]["sister_teams"] + s["sister_teams"]))
    
    # Find which team to merge sister teams into
    bubble_up = {}
    ghosts = set()
    for k in team_sets.keys():
        assoc_teams = team_sets[k]["sister_teams"]
    # for raw_sister in raw_sister_data:
    #     assoc_teams = raw_sister["AllTeams"]
        k_sisters = [
            next((k for i, k in enumerate(team_sets) if k == st or st == team_sets[k]["other_names"][0]), st) for st in assoc_teams
        ]
        rec_list =[
            (st, next((roster_recency[k] for i, k in enumerate(roster_recency) if k == k_sisters[st] or k == assoc_teams[st]), None)) for st in range(len(k_sisters))
        ]
        for a in [r for r in rec_list if r[1] is None]:
            kdel = k_sisters[a[0]]
            if kdel in team_sets.keys():
                ghosts.add(kdel)
        rec_list = [r for r in rec_list if r[1] is not None]
        prio_list = sorted(rec_list, key=lambda x: cmp_to_key(compare_roster_recency)(x[1]), reverse=True)
        for i in range(1, len(prio_list)):
            x = prio_list[i][0]
            master_team = k_sisters[prio_list[0][0]]
            if k_sisters[x] not in bubble_up:
                bubble_up[k_sisters[x]] = [master_team]
            elif master_team not in bubble_up[k_sisters[x]]:
                bubble_up[k_sisters[x]].append(master_team)
    for g in ghosts:
        log += "{}\n".format(g)
        if next((k for i, k in enumerate(team_sets) if k == g), None) is not None:
            del(team_sets[g])


    for k in bubble_up.keys():
        if k not in bubble_up[k] and k in team_sets.keys():
            for k2 in bubble_up[k]:
                k2_sets = [g for g in team_sets.keys() if k2 in team_sets[g]["other_names"]]
                for k3 in k2_sets:
                    team_sets[k3]["other_names"] = list(set(team_sets[k3]["other_names"] + team_sets[k]["other_names"]))

    for k in bubble_up.keys():
        if k not in bubble_up[k] and k in team_sets.keys():
            del(team_sets[k])
    
    with open('cooked/bubbles.json', 'w+', encoding='utf-8') as f:
        json.dump(bubble_up, f, ensure_ascii=False, indent=4)
    
    with open('cooked/teams.json', 'w+', encoding='utf-8') as f:
        json.dump(team_sets, f, ensure_ascii=False, indent=4)
    with open('cooked/log.txt', 'w+', encoding='utf-8') as f:
        f.write(log)
