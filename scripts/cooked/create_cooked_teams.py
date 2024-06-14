import json, datetime as dt

from shared.util import write_to_json_file

def get_team_key(team_dict, term):
    return next((k for i, k in enumerate(team_dict) if term.lower() == team_dict[k]["op"].lower() or term.lower() == team_dict[k]["name"].lower()), None)

def get_has_child_set(teams_sets: dict):
    has_child_in_set = set()
    for k in teams_sets.keys():
        if teams_sets[k]["came_from"] is not None and get_team_key(teams_sets, teams_sets[k]["came_from"]) is not None:
            has_child_in_set.add(k)
    return has_child_in_set

def add_all_teams(teams_sets: dict, raw_teams: list):
    for team in raw_teams:
        overview_page = team["OverviewPage"]
        key = team["Name"]
        if key == "":
            key = overview_page
        if overview_page not in teams_sets:
            teams_sets[overview_page] = {
                "op": overview_page,
                "name": key,
                "other_names": {overview_page, key},
                "sister_teams": set(),
                "short": team["Short"],
                "region": team["Region"],
                "image": team["Image"],
                "becomes": None,
                "came_from": None
            }
        else:
            teams_sets[overview_page]["other_names"] = teams_sets[overview_page]["other_names"].union({overview_page, key})
    return teams_sets

def populate_renames(teams_sets: dict, raw_teams_renames: list):
    for rename in raw_teams_renames:
        old_name = rename["OriginalName"]
        new_name = rename["NewName"]
        same_page = rename["IsSamePage"]
        if rename["Verb"] is None or rename["Verb"] == "acquire" or old_name.lower() == new_name.lower():
            continue
        old_key = get_team_key(teams_sets, old_name)
        new_key = get_team_key(teams_sets, new_name)
        if old_key is None and new_key is None:
            teams_sets[new_name] = {
                    "op": new_name,
                    "name": new_name,
                    "other_names": {new_name},
                    "sister_teams": set(),
                    "short": None,
                    "region": None,
                    "image": None,
                    "becomes": None,
                    "came_from": old_name
                }
            teams_sets[old_name] = {
                "op": old_name,
                "name": old_name,
                "other_names": {old_name},
                "sister_teams": set(),
                "short": None,
                "region": None,
                "image": None,
                "becomes": new_name,
                "came_from": None
            }
        elif old_key is not None and new_key is not None:
            teams_sets[new_key]["came_from"] = old_key
            teams_sets[old_key]["becomes"] = new_key
        elif old_key is None:
            teams_sets[old_name] = {
                "op": old_name,
                "name": old_name,
                "other_names": {old_name},
                "sister_teams": set(),
                "short": None,
                "region": None,
                "image": None,
                "becomes": new_key,
                "came_from": None
            }
            teams_sets[new_key]["came_from"] = old_name
        else:
            old_entry = teams_sets[old_key]
            teams_sets[new_name] = {
                "op": new_name,
                "name": new_name,
                "other_names": old_entry["other_names"].union({new_name}),
                "sister_teams": set(),
                "short": None,
                "region": None,
                "image": None,
                "becomes": None,
                "came_from": old_key
            }
            teams_sets[old_key]["becomes"] = new_name
    return teams_sets

def populate_sister_teams(teams_sets: dict, raw_teams_sister: list):
    for raw_sister in raw_teams_sister:
        team_name = raw_sister["Team"]
        team_sisters = raw_sister["AllTeams"]
        if team_name is not None and team_sisters is not None:
            team_key = get_team_key(teams_sets, team_name)
            if team_key is not None:
                sister_to_add = set()
                for sister in team_sisters:
                    sister_key = get_team_key(teams_sets, sister)
                    if sister_key is not None and sister_key.lower() != team_key.lower():
                        sister_to_add.add(sister_key)
                    elif sister is not None and sister.lower() != team_key.lower() and sister.lower() != team_name.lower():
                        sister_to_add.add(sister)
                teams_sets[team_key]["sister_teams"] = teams_sets[team_key]["sister_teams"].union(sister_to_add)
    return teams_sets

def bubble_other_names_to_parents_and_siblings(teams_sets: dict):
    visited = set()
    for key in teams_sets.keys():
        seen = []
        if teams_sets[key]["came_from"] is None: # No children
            cur_key = key
            visited.add(cur_key)
            while teams_sets[cur_key]["becomes"] is not None: # Has parent, add data
                nxt_key = teams_sets[cur_key]["becomes"]
                # Give to parent then switch to parent
                teams_sets[nxt_key]["other_names"] = teams_sets[nxt_key]["other_names"].union(teams_sets[cur_key]["other_names"])
                seen.append(cur_key)
                cur_key = nxt_key
                visited.add(cur_key)
                if cur_key in seen:
                    break
    
    for key in teams_sets.keys() - visited:
        seen = []
        cur_key = key
        while teams_sets[cur_key]["becomes"] is not None: # Has parent, add data
            nxt_key = teams_sets[cur_key]["becomes"]
            # Give to parent then switch to parent
            teams_sets[nxt_key]["other_names"] = teams_sets[nxt_key]["other_names"].union(teams_sets[cur_key]["other_names"])
            seen.append(cur_key)
            cur_key = nxt_key
            if cur_key in seen:
                break
    
    for key in teams_sets.keys():
        seen = []
        if teams_sets[key]["came_from"] is None: # No children
            cur_key = key
            for sis in teams_sets[cur_key]["sister_teams"]:
                sis_key = get_team_key(teams_sets, sis)
                if sis_key is not None:
                    teams_sets[sis_key]["other_names"] = teams_sets[sis_key]["other_names"].union(teams_sets[cur_key]["other_names"])
            while teams_sets[cur_key]["becomes"] is not None: # Has parent, add data
                nxt_key = teams_sets[cur_key]["becomes"]
                seen.append(cur_key)
                cur_key = nxt_key
                if cur_key in seen:
                    break
                for sis in teams_sets[cur_key]["sister_teams"]:
                    sis_key = get_team_key(teams_sets, sis)
                    if sis_key is not None:
                        teams_sets[sis_key]["other_names"] = teams_sets[sis_key]["other_names"].union(teams_sets[cur_key]["other_names"])
    return teams_sets

def get_formatted_roster_data(teams_sets: dict, raw_rosters: list, level_prio: list):
    roster_last_played = {}
    for roster in raw_rosters:
        team_name = roster["Team"]
        team_key = get_team_key(teams_sets, team_name)
        roster_level = roster["TournamentLevel"]
        roster_date = roster["Date"]
        if roster_date is not None and roster_date != "":
            if team_key is None:
                team_key = team_name
            if roster_level not in level_prio:
                roster_level = ""
            if team_key not in roster_last_played.keys():
                roster_last_played[team_key] = (roster_date, roster_level)
            else:
                if roster_last_played[team_key][1] in level_prio and level_prio.index(roster_last_played[team_key][1]) > level_prio.index(roster_level):
                    roster_last_played[team_key] = (roster_date, roster_level)
                elif dt.datetime.strptime(roster_last_played[team_key][0], "%Y-%m-%d") < dt.datetime.strptime(roster_date, "%Y-%m-%d"):
                    roster_last_played[team_key] = (roster_date, roster_level)
    return roster_last_played

def delete_subordinate_sister_teams(teams_sets: dict, roster_recency: dict, level_prio: list):
    never_prim = set()
    not_main = set()
    for key in teams_sets.keys():
        if len(teams_sets[key]["sister_teams"]) > 0:
            sister_group = [(t, roster_recency[t]) for t in teams_sets[key]["sister_teams"].union({key}) if t in roster_recency.keys() and roster_recency[t] != ""]
            sister_group = sorted(sister_group, key=lambda x: x[0]) # Alphabetical
            sister_group = sorted(sister_group, key=lambda x: dt.datetime.strptime(x[1][0], "%Y-%m-%d"), reverse=True) # Most recently played
            sister_group = sorted(sister_group, key=lambda x: level_prio.index(x[1][1])) # Highest level played
            neglected = [t for t in teams_sets[key]["sister_teams"] if t not in roster_recency.keys()]
            master_i = 0
            if len(sister_group) == 0:
                never_prim.add(key)
                continue
            while (get_team_key(teams_sets, sister_group[master_i][0]) is None and master_i < len(sister_group) - 1):
                master_i += 1
            master_n = sister_group[master_i]
            dead_set = [get_team_key(teams_sets, k[0]) for k in sister_group if k != master_n]
            not_main = not_main.union(set([t for t in dead_set if t is not None]))

            for neg in neglected:
                if neg in teams_sets.keys():
                    teams_sets[key]["sister_teams"] |= teams_sets[neg]["sister_teams"]
                    teams_sets[key]["other_names"] |= teams_sets[neg]["other_names"]
                    not_main.add(neg)
    ## Del not mains
    for k in not_main:
        del(teams_sets[k])
    return teams_sets

def delete_subset_teams(teams_sets: dict, roster_recency: dict, level_prio: list):
    eclipsed = {}
    equiv = {}
    for key_a in teams_sets.keys():
        for key_b in teams_sets.keys():
            if key_a != key_b and teams_sets[key_a]["other_names"] < teams_sets[key_b]["other_names"] and not (key_a in key_b and "Team)" in key_b):
                a_names = teams_sets[key_a]["other_names"]
                b_names = teams_sets[key_b]["other_names"]
                if key_a not in eclipsed.keys():
                    eclipsed[key_a] = {key_b}
                else:
                    eclipsed[key_a].add(key_b)
            elif key_a != key_b and teams_sets[key_a]["other_names"] == teams_sets[key_b]["other_names"]:
                if key_a not in equiv.keys():
                    equiv[key_a] = {key_b}
                else:
                    equiv[key_a].add(key_b)

    # Delete all eclipsed teams
    for k in eclipsed.keys():
        del(teams_sets[k])
    
    # Delete equiv teams
    not_main = set()
    for key in equiv.keys():
        equiv_group = [(t, roster_recency[t]) for t in equiv[key].union({key}) if t in roster_recency.keys()]
        equiv_group = sorted(equiv_group, key=lambda x: x[0]) # Alphabetical
        equiv_group = sorted(equiv_group, key=lambda x: dt.datetime.strptime(x[1][0], "%Y-%m-%d"), reverse=True) # Most recently played
        equiv_group = sorted(equiv_group, key=lambda x: level_prio.index(x[1][1])) # Highest level played
        if len(equiv_group) == 0:
            not_main = not_main.union([k for k in equiv[key].union({key}) if get_team_key(teams_sets, k) is not None])
            continue
        master_i = 0
        while (get_team_key(teams_sets, equiv_group[master_i][0]) is None and master_i < len(equiv_group) - 1):
            master_i += 1
        master_n = equiv_group[master_i][0]
        dead_set = [get_team_key(teams_sets, k) for k in equiv[key].union({key}) if k != master_n]
        not_main = not_main.union(set([t for t in dead_set if t is not None]))
    ## Del not mains
    for k in not_main:
        del(teams_sets[k])

    return teams_sets

def delete_rosterless_teams(teams_sets: dict, roster_recency: dict):
    no_roster = set()
    for k in teams_sets.keys():
        if k not in roster_recency:
            no_roster.add(k)

    for k in no_roster:
        del(teams_sets[k])
    return teams_sets

def bubble_sisters_to_parents_then_delete_child(teams_sets: dict, roster_recency: dict, level_prio: list, has_child_set: set()):
    bubbled = set()
    bottoms = set()
    for k in has_child_set:
        seen = set()
        cur_key = k
        bubbled.add(cur_key)
        while teams_sets[cur_key]["came_from"] is not None and get_team_key(teams_sets, teams_sets[cur_key]["came_from"]) is not None and teams_sets[cur_key]["came_from"] not in seen:
            seen.add(cur_key)
            bubbled.add(cur_key)
            cur_key = teams_sets[cur_key]["came_from"]
            bubbled.add(cur_key)
        bottoms.add(cur_key)
    
    visited = set()
    loopers = []
    top_dogs = set()
    for t in bottoms:
        cur_key = t
        while cur_key is not None and cur_key not in visited:
            visited.add(cur_key)
            nxt_key = teams_sets[cur_key]["becomes"]
            # Give to parent if exists
            if nxt_key is not None:
                teams_sets[nxt_key]["other_names"] |= teams_sets[cur_key]["other_names"]
            if nxt_key in visited: # Loop
                loopers.append({cur_key, nxt_key})
            elif nxt_key is None:
                top_dogs.add(cur_key)
            cur_key = nxt_key

    to_go = bubbled - top_dogs
    for loop in loopers:
        loop_rosters = [(k, roster_recency[k]) for k in loop if k in roster_recency]
        master_n = None
        if len(loop_rosters) == 0:
            loop_rosters = sorted(list(loop))
            master_n = loop_rosters[0]
        else:
            loop_rosters = sorted(loop_rosters, key=lambda x: x[0]) # Alphabetical
            loop_rosters = sorted(loop_rosters, key=lambda x: dt.datetime.strptime(x[1][0], "%Y-%m-%d"), reverse=True) # Most recently played
            loop_rosters = sorted(loop_rosters, key=lambda x: level_prio.index(x[1][1]))
            master_n = loop_rosters[0][0]
        if master_n is not None:
            to_go -= {master_n}
        else:
            print("?")
    for k in to_go:
        del(teams_sets[k])
    return teams_sets

def delete_quirky_teams(teams_sets: dict, roster_recency: dict, raw_teams_redirects: list):
    # Check for teams with parents
    todel = set()
    for k in teams_sets.keys():
        if teams_sets[k]["becomes"] is not None and teams_sets[k]["becomes"] != teams_sets[k]["came_from"]:
            goto = None
            for k2 in teams_sets.keys():
                if k != k2 and teams_sets[k]["becomes"] in teams_sets[k2]["other_names"]:
                    if goto is not None:
                        print("uh oh", k, goto, k2)
                    goto = k2
            if goto is not None:
                teams_sets[goto]["other_names"] |= teams_sets[k]["other_names"]
                todel |= {k}
    
    # Check for redirects
    for redir in raw_teams_redirects:
        a_name = redir["AllName"]
        p_name = redir["PageName"]
        if a_name in teams_sets.keys():
            for k in teams_sets.keys():
                if k != a_name and p_name in teams_sets[k]["other_names"] and "Team)" not in k:
                    teams_sets[k]["other_names"] |= teams_sets[a_name]["other_names"]
                    todel |= {a_name}
    for k in todel:
        del(teams_sets[k])
    
    for roster_key in roster_recency.keys():
        has_loc = False
        for k in teams_sets.keys():
            if roster_key.lower() in [n.lower() for n in teams_sets[k]["other_names"]]:
                has_loc = True
        if not has_loc:
            for redir in raw_teams_redirects:
                a_name = redir["AllName"]
                p_name = redir["PageName"]
                if a_name == roster_key:
                    for k in teams_sets.keys():
                        if p_name in teams_sets[k]["other_names"]:
                            teams_sets[k]["other_names"] |= {a_name}
    return teams_sets

def remove_secondary_names(teams_sets: dict, roster_recency: dict):
    for team_key in teams_sets.keys():
        # other names
        irrelevant_other_names = set()
        for other_name in teams_sets[team_key]["other_names"]:
            if other_name not in roster_recency.keys():
                irrelevant_other_names.add(other_name)
        for irrelevant_other_name in irrelevant_other_names:
            teams_sets[team_key]["other_names"].remove(irrelevant_other_name)
        # sister teams
        irrelevant_sister_teams = set()
        for sister_team in teams_sets[team_key]["sister_teams"]:
            if sister_team not in roster_recency.keys():
                irrelevant_sister_teams.add(sister_team)
        for irrelevant_sister_team in irrelevant_sister_teams:
            teams_sets[team_key]["sister_teams"].remove(irrelevant_sister_team)
    return teams_sets
        


def format_for_save(teams_sets: dict, roster_recency: dict):
    for k in teams_sets.keys():
        teams_sets[k]["other_names"] = sorted(teams_sets[k]["other_names"])
        teams_sets[k]["sister_teams"] = sorted(teams_sets[k]["sister_teams"])
        teams_sets[k]["highest_level"] = roster_recency[k][1]
    return teams_sets

def cook_teams_data(raw_teams: list, raw_teams_sister: list, raw_teams_renames: list, raw_teams_redirects: list, raw_rosters: list, write=True):
    teams_sets = {}
    teams_sets = add_all_teams(teams_sets, raw_teams)
    print("Evil Geniuses.NA" in teams_sets.keys())
    teams_sets = populate_renames(teams_sets, raw_teams_renames)
    print("Evil Geniuses.NA" in teams_sets.keys())
    teams_sets = populate_sister_teams(teams_sets, raw_teams_sister)
    print("Evil Geniuses.NA" in teams_sets.keys())
    teams_sets = bubble_other_names_to_parents_and_siblings(teams_sets)
    print("Evil Geniuses.NA" in teams_sets.keys())
    level_prio = ["Primary", "Secondary", "Showmatch", ""]
    roster_recency = get_formatted_roster_data(teams_sets, raw_rosters, level_prio)
    teams_sets = delete_subordinate_sister_teams(teams_sets, roster_recency, level_prio)
    print("Evil Geniuses.NA" in teams_sets.keys())
    teams_sets = delete_subset_teams(teams_sets, roster_recency, level_prio)
    print("Evil Geniuses.NA" in teams_sets.keys())
    teams_sets = delete_rosterless_teams(teams_sets, roster_recency)
    print("Evil Geniuses.NA" in teams_sets.keys())
    has_child_set = get_has_child_set(teams_sets)
    teams_sets = bubble_sisters_to_parents_then_delete_child(teams_sets, roster_recency, level_prio, has_child_set)
    print("Evil Geniuses.NA" in teams_sets.keys())
    teams_sets = delete_quirky_teams(teams_sets, roster_recency, raw_teams_redirects)
    print("Evil Geniuses.NA" in teams_sets.keys())
    teams_sets = remove_secondary_names(teams_sets, roster_recency)
    print("Evil Geniuses.NA" in teams_sets.keys())
    teams_sets = format_for_save(teams_sets, roster_recency)
    if write:
        loc = write_to_json_file("data/cooked", "teams", teams_sets, format=False)
        with open(loc, 'r+', encoding='utf-8') as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return teams_sets
    