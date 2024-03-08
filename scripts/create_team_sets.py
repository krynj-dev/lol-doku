import time, codecs, datetime as dt, json, os
from functools import cmp_to_key

os.makedirs("cooked", exist_ok=True)

def get_team_key(team_dict, term):
    return next((k for i, k in enumerate(team_dict) if term.lower() == team_dict[k]["op"].lower() or term.lower() == team_dict[k]["name"].lower()), None)

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

log = ""

######################################
# Algorithm
#   - Put every team into the list
#   - Populate the renames and rebrands
#   - Populate sister teams
#   - For all teams give other_names to parents and sisters
#   - Put together roster data
#   - Find and reconcile loops
#
######################################

if raw_team_data is not None and raw_rename_data is not None and raw_sister_data is not None and raw_roster_data is not None:
    team_sets = {}
    ############################
    # Put every team into list #
    ############################
    print("1: Adding teams to list... ", end="\t")
    for raw_team in raw_team_data:
        overview_page = raw_team["OverviewPage"]
        key = raw_team["Name"]
        if key == "":
            key = overview_page
        if overview_page not in team_sets:
            team_sets[overview_page] = {
                "op": overview_page,
                "name": key,
                "other_names": {overview_page, key},
                "sister_teams": set(),
                "short": raw_team["Short"],
                "region": raw_team["Region"],
                "image": raw_team["Image"],
                "becomes": None,
                "came_from": None
            }
        else:
            team_sets[overview_page]["other_names"] = team_sets[overview_page]["other_names"].union({overview_page, key})
    print("Done!")

    print("2: Adding renames and rebrands... ", end="\t")
    #####################################
    # Populate the renames and rebrands #
    #####################################
    for raw_rename in raw_rename_data:
        o_name = raw_rename["OriginalName"]
        n_name = raw_rename["NewName"]
        same_page = raw_rename["IsSamePage"]
        if raw_rename["Verb"] is not None and raw_rename["Verb"] != "acquire" and o_name.lower() != n_name.lower(): # Ignore acquisitions
            o_key = get_team_key(team_sets, o_name)
            n_key = get_team_key(team_sets, n_name)
            if o_key is None and n_key is None: # Create new entry
                team_sets[n_name] = {
                    "op": n_name,
                    "name": n_name,
                    "other_names": {n_name},
                    "sister_teams": set(),
                    "short": None,
                    "region": None,
                    "image": None,
                    "becomes": None,
                    "came_from": o_name
                }
                team_sets[o_name] = {
                    "op": o_name,
                    "name": o_name,
                    "other_names": {o_name},
                    "sister_teams": set(),
                    "short": None,
                    "region": None,
                    "image": None,
                    "becomes": n_name,
                    "came_from": None
                }
            # elif same_page == "Yes": 
            #     if (o_key is not None and n_key is not None and o_key.lower() != n_key.lower()): # Probably made o_key in this loop, so merge
            #         o_entry = team_sets[o_key]
            #         team_sets[n_key]["other_names"] = team_sets[n_key]["other_names"].union(o_entry["other_names"])
            #         team_sets[n_key]["came_from"] = o_name
            #         del(team_sets[o_key])
            #     else: # Simply add to existing page
            #         if o_key is None: # Add to new
            #             team_sets[n_key]["other_names"].add(o_name)
            #             team_sets[n_key]["came_from"] = o_name
            #         else:  # create new listing, delete old one
            #             o_entry = team_sets[o_key]
            #             team_sets[n_name] = {
            #                 "op": n_name,
            #                 "name": n_name,
            #                 "other_names": {n_name}.union(o_entry["other_names"]),
            #                 "sister_teams": set(),
            #                 "short": o_entry["short"],
            #                 "region": o_entry["region"],
            #                 "image": o_entry["image"],
            #                 "becomes": None,
            #                 "came_from": o_name
            #             }
            #             del(team_sets[o_key])
            else: # Different pages
                if o_key is not None and n_key is not None: # Point to each other
                    team_sets[n_key]["came_from"] = o_key
                    team_sets[o_key]["becomes"] = n_key
                elif o_key is None: # Create old and point
                    team_sets[o_name] = {
                        "op": o_name,
                        "name": o_name,
                        "other_names": {o_name},
                        "sister_teams": set(),
                        "short": None,
                        "region": None,
                        "image": None,
                        "becomes": n_key,
                        "came_from": None
                    }
                    team_sets[n_key]["came_from"] = o_name
                else: # create new and point
                    o_entry = team_sets[o_key]
                    team_sets[n_name] = {
                        "op": n_name,
                        "name": n_name,
                        "other_names": o_entry["other_names"].union({n_name}),
                        "sister_teams": set(),
                        "short": None,
                        "region": None,
                        "image": None,
                        "becomes": None,
                        "came_from": o_key
                    }
                    team_sets[o_key]["becomes"] = n_name
    
    print("Done!")

    print("3: Adding sister teams... ", end="\t")

    #########################
    # Populate sister teams #
    #########################
    for raw_sister in raw_sister_data:
        t_name = raw_sister["Team"]
        t_sisters = raw_sister["AllTeams"]
        if t_name is not None and t_sisters is not None:
            t_key = get_team_key(team_sets, t_name)
            if t_key is not None:
                sis_to_add = set()
                for sis in t_sisters:
                    sis_key = get_team_key(team_sets, sis)
                    if sis_key is not None and sis_key.lower() != t_key.lower():
                        sis_to_add.add(sis_key)
                    elif sis is not None and sis.lower() != t_key.lower() and sis.lower() != t_name.lower():
                        sis_to_add.add(sis)
                team_sets[t_key]["sister_teams"] = team_sets[t_key]["sister_teams"].union(sis_to_add)
    
    print("Done!")

    print("4: Sharing team name alts with sisters and parents... ", end="\t")
    
    #########################################################
    # For all teams give other_names to parents and sisters #
    #########################################################
    visited = set()
    for key in team_sets.keys():
        seen = []
        if team_sets[key]["came_from"] is None: # No children
            cur_key = key
            visited.add(cur_key)
            while team_sets[cur_key]["becomes"] is not None: # Has parent, add data
                nxt_key = team_sets[cur_key]["becomes"]
                # Give to parent then switch to parent
                # log += "Adding {} to {}\n".format(cur_key, nxt_key)
                team_sets[nxt_key]["other_names"] = team_sets[nxt_key]["other_names"].union(team_sets[cur_key]["other_names"])
                # log += str(team_sets[nxt_key]["other_names"]) + '\n'
                seen.append(cur_key)
                cur_key = nxt_key
                visited.add(cur_key)
                if cur_key in seen:
                    break

    for key in team_sets.keys() - visited:
        seen = []
        cur_key = key
        while team_sets[cur_key]["becomes"] is not None: # Has parent, add data
            nxt_key = team_sets[cur_key]["becomes"]
            # Give to parent then switch to parent
            # log += "Adding {} to {}\n".format(cur_key, nxt_key)
            team_sets[nxt_key]["other_names"] = team_sets[nxt_key]["other_names"].union(team_sets[cur_key]["other_names"])
            # log += str(team_sets[nxt_key]["other_names"]) + '\n'
            seen.append(cur_key)
            cur_key = nxt_key
            if cur_key in seen:
                break


    for key in team_sets.keys():
        seen = []
        if team_sets[key]["came_from"] is None: # No children
            cur_key = key
            for sis in team_sets[cur_key]["sister_teams"]:
                sis_key = get_team_key(team_sets, sis)
                if sis_key is not None:
                    team_sets[sis_key]["other_names"] = team_sets[sis_key]["other_names"].union(team_sets[cur_key]["other_names"])
            while team_sets[cur_key]["becomes"] is not None: # Has parent, add data
                nxt_key = team_sets[cur_key]["becomes"]
                seen.append(cur_key)
                cur_key = nxt_key
                if cur_key in seen:
                    break
                for sis in team_sets[cur_key]["sister_teams"]:
                    sis_key = get_team_key(team_sets, sis)
                    if sis_key is not None:
                        team_sets[sis_key]["other_names"] = team_sets[sis_key]["other_names"].union(team_sets[cur_key]["other_names"])

    print("Done!")

    print("5: Loading roster data... ", end="\t")

    ############################
    # Put together roster data #
    ############################
    level_prio = ["Primary", "Secondary", "Showmatch", ""]
    roster_last_played = {}
    for raw_roster in raw_roster_data:
        t_name = raw_roster["Team"]
        t_key = get_team_key(team_sets, t_name)
        t_level = raw_roster["TournamentLevel"]
        t_date = raw_roster["Date"]
        if t_date is not None and t_date != "":
            if t_key is None:
                t_key = t_name
            if t_level not in level_prio:
                t_level = ""
            if t_key not in roster_last_played.keys():
                roster_last_played[t_key] = (t_date, t_level)
            else:
                if roster_last_played[t_key][1] in level_prio and level_prio.index(roster_last_played[t_key][1]) > level_prio.index(t_level):
                    roster_last_played[t_key] = (t_date, t_level)
                elif dt.datetime.strptime(roster_last_played[t_key][0], "%Y-%m-%d") < dt.datetime.strptime(t_date, "%Y-%m-%d"):
                    roster_last_played[t_key] = (t_date, t_level)
    
    # print("Done!")

    # print("6: Sharing team name alts with sisters and parents... ", end="\t")
    
    ############################
    # Find and reconcile loops #
    ############################
    # not_top = set()
    # for key in team_sets.keys():
    #     if team_sets[key]["came_from"] is None: # No children
    #         team_chain = []
    #         cur_key = key
    #         team_chain.append(cur_key)
    #         while team_sets[cur_key]["becomes"] is not None: # Has parent
    #             cur_key = team_sets[cur_key]["becomes"]
    #             if cur_key in team_chain:
    #                 break
    #             team_chain.append(cur_key)
    #         chain_recencies = [(k, roster_last_played[k]) for k in team_chain if k in roster_last_played.keys() and roster_last_played[k] != ""]
    #         chain_recencies = sorted(chain_recencies, key=lambda x: dt.datetime.strptime(x[1][0], "%Y-%m-%d"), reverse=True)
    #         # chain_recencies = sorted(chain_recencies, key=lambda x: level_prio.index(x[1][1]))
    #         # log += "{}\n".format(chain_recencies)
            
    #         if len(chain_recencies) == 0:
    #             not_top = not_top.union(set(team_chain))
    #         elif len(chain_recencies) > 1:
    #             master_n = chain_recencies[0][0]
    #             # print(master_n, [k for k in team_chain if k != master_n], sep=" |\t")
    #             not_top = not_top.union(set([k for k in team_chain if k != master_n]))
    
    ## Del not tops
    # for k in not_top:
    #     del(team_sets[k])

    print("Done!")

    print("6: Deleting sister teams that aren't the main... ", end="\t")

    not_main = set()
    for key in team_sets.keys():
        if len(team_sets[key]["sister_teams"]) > 0:
            sister_group = [(t, roster_last_played[t]) for t in team_sets[key]["sister_teams"].union({key}) if t in roster_last_played.keys() and roster_last_played[t] != ""]
            sister_group = sorted(sister_group, key=lambda x: x[0]) # Alphabetical
            sister_group = sorted(sister_group, key=lambda x: dt.datetime.strptime(x[1][0], "%Y-%m-%d"), reverse=True) # Most recently played
            sister_group = sorted(sister_group, key=lambda x: level_prio.index(x[1][1])) # Highest level played
            # log += "{}\n".format(sister_group)
            master_i = 0
            while (get_team_key(team_sets, sister_group[master_i][0]) is None and master_i < len(sister_group) - 1):
                master_i += 1
            master_n = sister_group[master_i]
            dead_set = [get_team_key(team_sets, k[0]) for k in sister_group if k != master_n]
            not_main = not_main.union(set([t for t in dead_set if t is not None]))
    
    ## Del not mains
    for k in not_main:
        del(team_sets[k])
    
    print("Done!")

    print("7: Deleting teams that are subsets of others... ", end="\t")

    ## This will take time kek
    eclipsed = {}
    equiv = {}
    for key_a in team_sets.keys():
        for key_b in team_sets.keys():
            if key_a != key_b and team_sets[key_a]["other_names"] < team_sets[key_b]["other_names"]:
                if key_a not in eclipsed.keys():
                    eclipsed[key_a] = {key_b}
                else:
                    eclipsed[key_a].add(key_b)
            elif key_a != key_b and team_sets[key_a]["other_names"] == team_sets[key_b]["other_names"]:
                if key_a not in equiv.keys():
                    equiv[key_a] = {key_b}
                else:
                    equiv[key_a].add(key_b)

    # Delete all eclipsed teams
    for k in eclipsed.keys():
        del(team_sets[k])
    
    # Delete equiv teams
    not_main = set()
    for key in equiv.keys():
        equiv_group = [(t, roster_last_played[t]) for t in equiv[key].union({key}) if t in roster_last_played.keys()]
        equiv_group = sorted(equiv_group, key=lambda x: x[0]) # Alphabetical
        equiv_group = sorted(equiv_group, key=lambda x: dt.datetime.strptime(x[1][0], "%Y-%m-%d"), reverse=True) # Most recently played
        equiv_group = sorted(equiv_group, key=lambda x: level_prio.index(x[1][1])) # Highest level played
        if len(equiv_group) == 0:
            not_main = not_main.union([k for k in equiv[key].union({key}) if get_team_key(team_sets, k) is not None])
            continue
        log += "{} | {} | {}\n".format(key, equiv[key], equiv_group)
        master_i = 0
        while (get_team_key(team_sets, equiv_group[master_i][0]) is None and master_i < len(equiv_group) - 1):
            master_i += 1
        master_n = equiv_group[master_i][0]
        dead_set = [get_team_key(team_sets, k) for k in equiv[key].union({key}) if k != master_n]
        log += "DS: {}\n".format(dead_set)
        not_main = not_main.union(set([t for t in dead_set if t is not None]))
    ## Del not mains
    for k in not_main:
        del(team_sets[k])

    print("Done!")

    print("8: Deleting teams that did have rosters that played... ", end="\t")
    
    # remove rosterless teams
    no_roster = set()
    has_child_in_set = set()
    for k in team_sets.keys():
        if k not in roster_last_played:
            no_roster.add(k)
        if team_sets[k]["came_from"] is not None and get_team_key(team_sets, team_sets[k]["came_from"]) is not None:
            has_child_in_set.add(k)

    for k in no_roster:
        del(team_sets[k])
    
    print("Done!")

    print("9: Giving sister data to parents for children still in set... ", end="\t")

    bubbled = set()
    bottoms = set()
    for k in has_child_in_set:
        seen = set()
        cur_key = k
        bubbled.add(cur_key)
        while team_sets[cur_key]["came_from"] is not None and get_team_key(team_sets, team_sets[cur_key]["came_from"]) is not None and team_sets[cur_key]["came_from"] not in seen:
            seen.add(cur_key)
            bubbled.add(cur_key)
            cur_key = team_sets[cur_key]["came_from"]
            bubbled.add(cur_key)
        bottoms.add(cur_key)
    
    visited = set()
    loopers = []
    top_dogs = set()
    for t in bottoms:
        cur_key = t
        while cur_key is not None and cur_key not in visited:
            visited.add(cur_key)
            nxt_key = team_sets[cur_key]["becomes"]
            # Give to parent if exists
            if nxt_key is not None:
                team_sets[nxt_key]["other_names"] |= team_sets[cur_key]["other_names"]
            if nxt_key in visited: # Loop
                loopers.append({cur_key, nxt_key})
            elif nxt_key is None:
                top_dogs.add(cur_key)
            cur_key = nxt_key

    to_go = bubbled - top_dogs
    for loop in loopers:
        loop_rosters = [(k, roster_last_played[k]) for k in loop if k in roster_last_played]
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
        del(team_sets[k])
    
    print("Done!")

    print("10: Saving to file... ", end="\t")

    with open('cooked/teams.json', 'w+', encoding='utf-8') as f:
        for k in team_sets.keys():
            team_sets[k]["other_names"] = sorted(team_sets[k]["other_names"])
            team_sets[k]["sister_teams"] = sorted(team_sets[k]["sister_teams"])
            team_sets[k]["highest_level"] = roster_last_played[k][1]
        json.dump(team_sets, f, ensure_ascii=False, indent=4, sort_keys=True, default=lambda o: list(o))
    with open('cooked/log.txt', 'w+', encoding='utf-8') as f:
        f.write(log)
    
    print("Done!")
