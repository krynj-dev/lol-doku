import time, codecs, datetime as dt, json, os

os.makedirs("cooked", exist_ok=True)

def compare_roster_recency(a, b):
    # print(a, b, end="\t")
    in_a = ["Primary" in a and a["Primary"] != '', "Secondary" in a and a["Secondary"] != '', "" in a and a[""] != '']
    in_b = ["Primary" in b and b["Primary"] != '', "Secondary" in b and b["Secondary"] != '', "" in b and b[""] != '']
    # print(in_a, in_b)
    if in_a[0] and in_b[0]:
        if dt.datetime.strptime(a["Primary"], "%Y-%m-%d") > dt.datetime.strptime(b["Primary"], "%Y-%m-%d"):
            return True
        else:
            return False
    elif in_a[0] and not in_b[0]:
        return True
    elif not in_a[0] and in_b[0]:
        return False
    elif in_a[1] and in_b[1]:
        if dt.datetime.strptime(a["Secondary"], "%Y-%m-%d") > dt.datetime.strptime(b["Secondary"], "%Y-%m-%d"):
            return True
        else:
            return False
    elif in_a[1] and not in_b[1]:
        return True
    elif not in_a[1] and in_b[1]:
        return False
    elif in_a[2] and in_b[2]:
        if dt.datetime.strptime(a[""], "%Y-%m-%d") > dt.datetime.strptime(b[""], "%Y-%m-%d"):
            return True
        else:
            return False
    elif in_a[2] and not in_b[2]:
        return True
    elif not in_a[2] and in_b[2]:
        return False
    else:
        return True


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
                # print(team_sets[k_new]["other_names"])
            elif k_old is not None:
                team_sets[name_new] = {
                    "name": name_new,
                    "other_names": [name_new] + team_sets[k_old]["other_names"],
                    "sister_teams": [],
                    "short": None,
                    "region": None,
                    "image": None,
                }
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
                }
    
    for raw_sister in raw_sister_data:
        sister_team = raw_sister["Team"]
        assoc_teams = raw_sister["AllTeams"]
        log += "{} | {}\n".format(sister_team, assoc_teams)
        k_team = next((k for i, k in enumerate(team_sets) if k == sister_team or sister_team == team_sets[k]["other_names"][0]), None)
        if k_team is not None:
            for sister in assoc_teams:
                k_sister = [k for i, k in enumerate(team_sets) if k == sister or sister == team_sets[k]["other_names"][0]]
                for op_sister in k_sister:
                    if op_sister != team_sets[k_team]["name"] or op_sister != k_team:
                        team_sets[k_team]["sister_teams"].append(op_sister)
                if (sister != team_sets[k_team]["name"] or sister != k_team) and sister not in team_sets[k_team]["sister_teams"]:
                    team_sets[k_team]["sister_teams"].append(sister)
                
        
                            
            
    with open('cooked/teams.json', 'w+', encoding='utf-8') as f:
        json.dump(team_sets, f, ensure_ascii=False, indent=4)
    with open('cooked/log.txt', 'w+', encoding='utf-8') as f:
        f.write(log)
