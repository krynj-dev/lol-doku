import datetime as dt
import re
import time as timelib
from raw import *
from mwrogue.esports_client import EsportsClient
from cooked import *
from rules import *
from collections import Counter

## Data update tasks
# 1. Grab updated team data and find evolutions and additions
# 2. Grab updated player data and find evolutions and additions
# 3. Traverse rosters to update and create rules for teams/teammates

parentheses_match = "(.+) \\(.*\\)"


def get_fresh_teams_data(site: EsportsClient, time):
    sister_teams = get_sister_teams(site, write=False)  # 4

    teams = get_teams(site, write=False)  # 5

    team_redirects = get_team_redirects(site, write=False)  # 6

    team_renames = get_team_renames(site, write=False)  # 7

    return sister_teams, teams, team_redirects, team_renames


def get_fresh_players_data(site: EsportsClient, rosters):
    player_set = set()
    acceptable_roles = ["Top", "Jungle", "Mid", "Bot", "Support"]
    for roster in rosters:
        if roster["Roles"] is not None and roster["RosterLinks"]:
            if len(roster["Roles"]) != len(roster["RosterLinks"]):
                continue
            players = [
                roster["RosterLinks"][i]
                for i in range(len(roster["RosterLinks"]))
                if any(r in acceptable_roles for r in roster["Roles"][i].split(","))
            ]
            for plr in players:
                player_set.add(plr)

    players = get_players(site, None, write=False)  # 2
    # player_imgs = get_player_image_urls(site, None, write=False) # 2.1

    # link_count = Counter([k["Link"] for k in player_imgs])
    player_imgs = {}

    champions = get_champions(site, False)  # 2.5
    # champions = {}

    s = time.perf_counter()
    # champ_players = get_players_champs(site, champions, list(player_set), write=False) #3
    champ_players = get_champ_counts_mp(
        site, champions, list(player_set), write=False
    )  # 3
    e = time.perf_counter()
    print(f"Time to get champs: {(e-s)}")
    # champ_players = {}

    return players, champions, champ_players, player_imgs


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

    for k, v in {
        k: v for k, v in new_teams.items() if k in old_keys & new_keys
    }.items():
        new_names = set(v["other_names"]) - set(old_teams[k]["other_names"])
        new_sisters = set(v["sister_teams"]) - set(old_teams[k]["sister_teams"])
        if len(new_names) > 0 or len(new_sisters) > 0:
            evos[k] = (k, v)

    adds = {
        k: v
        for k, v in new_teams.items()
        if k in added_keys - set([v1[0] for _, v1 in evos.items()])
    }
    return adds, evos


def compare_teams_new(old_teams: dict, new_teams: dict):
    adds = {k: v for k, v in new_teams.items() if k not in old_teams}
    deactives = set(
        [
            k
            for k in old_teams.keys()
            if get_team_key(old_teams, k) != get_team_key(new_teams, k)
            and ("active" not in old_teams[k] or old_teams[k]["active"] != False)
        ]
    )
    changes = {}
    for k, v in {
        k: v for k, v in new_teams.items() if k not in set(adds.keys()) | deactives
    }.items():
        ov = old_teams[k]
        diff = {}
        if v["becomes"] != ov["becomes"]:
            diff["becomes"] = v["becomes"]
        if v["came_from"] != ov["came_from"]:
            diff["came_from"] = v["came_from"]
        if v["highest_level"] != ov["highest_level"]:
            diff["highest_level"] = v["highest_level"]
        if v["image"] != ov["image"]:
            diff["image"] = v["image"]
        if v["name"] != ov["name"]:
            diff["name"] = v["name"]
        if v["op"] != ov["op"]:
            diff["op"] = v["op"]
        if v["region"] != ov["region"]:
            diff["region"] = v["region"]
        if v["short"] != ov["short"]:
            diff["short"] = v["short"]
        if len(set(v["other_names"]) - set(ov["other_names"])) > 0:
            diff["other_names"] = set(v["other_names"]) - set(ov["other_names"])
        if len(set(v["sister_teams"]) - set(ov["sister_teams"])) > 0:
            diff["sister_teams"] = set(v["sister_teams"]) - set(ov["sister_teams"])
        if "active" in ov:
            diff["active"] = True
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
                evos[o_name][1]["alternate_names"] = list(
                    set(evos[o_name][1]["alternate_names"])
                    - set(old_players[o_name]["alternate_names"])
                )
            elif (
                name_match
                and name_match.group(1) in old_players
                and old_players[name_match.group(1)]["name"] == v["name"]
            ):
                evos[name_match.group(1)] = (k, v.copy())
                evos[name_match.group(1)][1]["alternate_names"] = list(
                    set(evos[name_match.group(1)][1]["alternate_names"])
                    - set(old_players[name_match.group(1)]["alternate_names"])
                )
    for k in old_keys - new_keys - set(evos.keys()):
        nk = get_player_key(new_players, k)
        if nk is not None:
            nv = new_players[nk].copy()
            nv["alternate_names"] = list(
                set(new_players[nk]["alternate_names"])
                - set(old_players[k]["alternate_names"])
            )
            evos[k] = (nk, nv)
            continue
        if nk is None:
            for alt_name in old_players[k]["alternate_names"]:
                nk2 = get_player_key(new_players, alt_name)
                if (
                    nk2 is not None
                    and old_players[k]["name"] == new_players[nk2]["name"]
                ):
                    nv2 = new_players[nk2].copy()
                    nv2["alternate_names"] = list(
                        set(new_players[nk2]["alternate_names"])
                        - set(old_players[k]["alternate_names"])
                    )  # removed + [k]
                    evos[k] = (nk2, nv2)
                    continue
    changes = {}
    for k, v in evos.items():
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
            diff["alternate_names"] = set(v[1]["alternate_names"]) - set(
                ov["alternate_names"]
            )
        if diff != {}:
            changes[k] = diff
    adds = {
        k: v
        for k, v in new_players.items()
        if k in added_keys - set([v1[0] for _, v1 in evos.items()])
    }
    return adds, changes, []


def compare_rules(old_rules, new_rules, player_evos, compare_key=lambda x: (None, x)):
    compared = {k: compare_key(k) for k in old_rules.keys()}
    changes = {}
    deactives = set([k for k, v in compared.items() if v[0] == "rem"])
    seen = set()
    adds = {}
    for k, v in {
        k: v for k, v in old_rules.items() if k in new_rules or compared[k][0] != "rem"
    }.items():
        nk = compared[k][1]
        seen.add(nk)
        if nk not in new_rules:
            continue
        nv = new_rules[nk]
        diff = {}
        for f in v.keys():
            if f == "regions":
                continue
            if (
                f not in ["exclusive_crosses", "valid_players", "active"]
                and v[f] != nv[f]
            ):
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
            elif f == "active":
                diff[f] = True
        if diff != {}:
            changes[k] = diff
    adds = {k: v for k, v in new_rules.items() if k not in seen}
    # Giving the players over to the new one
    for k, v in {k: v for k, v in old_rules.items() if k in deactives}.items():
        nk = compared[k][1]
        if nk in adds:
            adjusted_players = set()
            for p in set(v["valid_players"]):
                if p in player_evos:
                    adjusted_players.add(player_evos[p]["display_name"])
                else:
                    adjusted_players.add(p)
            adds[nk]["exclusive_crosses"] = set(adds[nk]["exclusive_crosses"]) | set(
                v["exclusive_crosses"]
            )
            adds[nk]["valid_players"] = (
                set(adds[nk]["valid_players"]) | adjusted_players
            )
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


def compare_rules_new(
    old_rules, new_rules, player_evos, compare_key=lambda x: (None, x)
):
    compares = [
        compare_key(k)[1] for k in old_rules.keys() if compare_key(k)[0] is not None
    ]
    adds = {
        k: v for k, v in new_rules.items() if k not in old_rules and k not in compares
    }
    deactives = set(
        [
            k
            for k in old_rules.keys()
            if k not in new_rules and compare_key(k)[0] == "rem"
        ]
    )
    changes = {}
    for k, v in {
        k: v for k, v in new_rules.items() if k not in set(adds.keys()) | deactives
    }.items():
        ok = next((g for g in old_rules.keys() if compare_key(g)[1] == k), k)
        ov = old_rules[ok]
        adjusted_players = []
        for p in ov["valid_players"]:
            if p in player_evos:
                adjusted_players.append(player_evos[p]["display_name"])
            else:
                adjusted_players.append(p)
        diff = {}
        if len(set(v["valid_players"]) - set(adjusted_players)) > 0:
            diff["valid_players"] = set(v["valid_players"]) - set(adjusted_players)
        if ok != k:
            diff["key"] = k
        if diff != {}:
            changes[ok] = diff
    for k in [l for l in deactives if compare_key(l) is not None]:
        if compare_key(k) in adds:
            adds[compare_key(k)]["valid_players"] = set(
                adds[compare_key(k)]["valid_players"]
            ) | set(old_rules[k]["valid_players"])
        elif compare_key(k) in changes:
            changes[compare_key(k)]["valid_players"] = set(
                changes[compare_key(k)]["valid_players"]
            ) | set(old_rules[k]["valid_players"])
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
        if nk in new_rules:
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
            return ("rem", get_team_key(new_teams, team_key))
        elif team_key in team_evos and "op" in team_evos[team_key]:
            return ("evo", team_evos[team_key]["op"])
        else:
            return (None, team_key)

    return compare_teams


def get_player_key_compare(new_players, player_evos, player_rems):
    def compare_players(player_key):
        if player_key in player_rems:
            return ("rem", get_player_key(new_players, player_key))
        elif player_key in player_evos and "display_name" in player_evos[player_key]:
            return ("evo", player_evos[player_key]["display_name"])
        else:
            return (None, player_key)

    return compare_players


def compare_remove_old(rule_key):
    return ("rem", None)


def apply_update(base: dict, update: dict, players=None):
    if players is not None:
        for k, v in base.items():
            if "valid_players" in v:
                base[k]["valid_players"] = [
                    (
                        p
                        if p not in players["evo"]
                        or "display_name" not in players["evo"][p]
                        else players["evo"][p]["display_name"]
                    )
                    for p in base[k]["valid_players"]
                ]
        # base = {k if k not in players["evo"] or "display_name" not in players["evo"][k] else players["evo"][k]["display_name"]:v for k,v in base.items()}
    base |= update["add"]
    for k, v in update["evo"].items():
        for k2, v2 in v.items():
            if isinstance(v2, list):
                base[k][k2] = list(set(base[k][k2]) | set(v2))
            else:
                base[k][k2] = v2
        if "display_name" in v:
            base[v["display_name"]] = base[k]
            del base[k]
        if "op" in v:
            base[v["op"]] = base[k]
            del base[k]
        if "key" in v:
            base[v["key"]] = base[k]
            del base[k]
    for n in update["rem"]:
        base[n]["active"] = False
    return base


def open_or_empty(filename: str):
    try:
        with open(filename, "r+", encoding="utf-8") as f:
            return json.load(f)
    except FileNotFoundError:
        return {}


def load_most_recent_data(strip: int = 0):
    # Open old teams
    with open("data/initial/cooked/teams.json", "r+", encoding="utf-8") as f:
        teams = json.load(f)
    # Open old players
    with open("data/initial/cooked/players.json", "r+", encoding="utf-8") as f:
        players = json.load(f)
    ## Load old rules
    with open(f"data/initial/rules/teams.json", "r+", encoding="utf-8") as f:
        team_rules = json.load(f)
    with open(f"data/initial/rules/teammates.json", "r+", encoding="utf-8") as f:
        teammates_rules = json.load(f)
    with open(f"data/initial/rules/roles.json", "r+", encoding="utf-8") as f:
        roles_rules = json.load(f)
    with open(f"data/initial/rules/finalists.json", "r+", encoding="utf-8") as f:
        finalists_rules = json.load(f)
    with open(
        f"data/initial/rules/worlds_participants.json", "r+", encoding="utf-8"
    ) as f:
        worlds_participants_rules = json.load(f)
    with open(f"data/initial/rules/countries.json", "r+", encoding="utf-8") as f:
        countries_rules = json.load(f)
    with open(f"data/initial/rules/champion_counts.json", "r+", encoding="utf-8") as f:
        champion_rules = json.load(f)
    pentakill_rules = open_or_empty("data/initial/rules/pentakills.json")
    league_winner_rules = open_or_empty("data/initial/rules/winners.json")
    # Sort updates
    list_subfolders_with_paths = [f.name for f in os.scandir("data") if f.is_dir()]
    reg = re.compile(r"^\d{4}-\d{2}-\d{2}$")
    list_subfolders_with_paths = list(filter(reg.search, list_subfolders_with_paths))
    list_subfolders_with_paths.sort(key=lambda x: dt.datetime.strptime(x, "%Y-%m-%d"))
    # apply each update
    other_updates = [
        ("/cooked/teams.json", teams),
        ("/cooked/players.json", players),
    ]
    rules_updates = [
        ("/rules/teams.json", team_rules),
        ("/rules/teammates.json", teammates_rules),
        ("/rules/roles.json", roles_rules),
        ("/rules/finalists.json", finalists_rules),
        ("/rules/worlds_participants.json", worlds_participants_rules),
        ("/rules/countries.json", countries_rules),
        ("/rules/pentakills.json", pentakill_rules),
        ("/rules/winners.json", league_winner_rules),
        ("/rules/champion_counts.json", champion_rules),
    ]
    for dirpath in list_subfolders_with_paths[
        : len(list_subfolders_with_paths) - strip
    ]:
        print(f"Applying update {dirpath}")
        update_file = f"data/{dirpath}/cooked/players.json"
        with open(update_file, "r+", encoding="utf-8") as f:
            plr_update = json.load(f)
        for f, b in other_updates:
            update_file = f"data/{dirpath}{f}"
            with open(update_file, "r+", encoding="utf-8") as f:
                update = json.load(f)
            apply_update(b, update)
        for f, b in rules_updates:
            update_file = f"data/{dirpath}{f}"
            try:
                with open(update_file, "r+", encoding="utf-8") as f:
                    update = json.load(f)
                apply_update(b, update, plr_update)
            except FileNotFoundError:
                pass
        pass
    # Update player names

    return (
        teams,
        players,
        team_rules,
        teammates_rules,
        roles_rules,
        finalists_rules,
        worlds_participants_rules,
        countries_rules,
        champion_rules,
        pentakill_rules,
        league_winner_rules,
    )


def perform_data_update(
    site: EsportsClient, time=dt.datetime(dt.datetime.now().year - 1, 1, 1)
):
    time_path = dt.datetime.strftime(dt.datetime.now(), "%Y-%m-%d")
    sa = timelib.perf_counter()
    # Load old data
    timer = timelib.perf_counter()
    (
        old_teams,
        old_players,
        old_team_rules,
        old_teammates_rules,
        old_roles_rules,
        old_finalists_rules,
        old_worlds_participants_rules,
        old_countries_rules,
        old_champion_rules,
        old_pentakill_rules,
        old_winner_rules,
    ) = load_most_recent_data()
    print(f"Time to load existing data: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    ## Grab rosters
    all_rosters = get_rosters(
        site,
        write=True,
        write_loc=f"data/{time_path}/raw",
        levels=["Primary", "Secondary"],
    )
    print(f"Time to get rosters: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    ## Grab new teams data
    players, champs, champ_players, urls = get_fresh_players_data(site, all_rosters)
    print(f"Time to get players: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    sister_teams, teams, team_redirects, team_renames = get_fresh_teams_data(site, time)
    print(f"Time to get teams: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    new_teams = cook_teams_data(
        teams, sister_teams, team_renames, team_redirects, all_rosters, write=False
    )
    print(f"Time to cook teams: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    team_adds, team_evos, team_rems = compare_teams_new(old_teams, new_teams)
    print(f"Time to compare teams: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    ## Grab new players data
    new_players = cook_players_data(site, players, [], write=False)
    print(f"Time to cook players: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    player_adds, player_evos, player_rems = compare_players(old_players, new_players)
    print(f"Time to compare players: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    ## Grab tournament results
    new_tournament_results = get_all_tournament_results(
        site, write=True, write_loc=f"data/{time_path}/raw"
    )
    print(f"Time to get tournament results: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    ## Grab new data
    pentakills = get_pentakills(site, write=True, write_loc=f"data/{time_path}/raw")
    print(f"Time to get pentakills: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    ##### RULES ######
    ## Create new rules
    # new_rosters = [r for r in all_rosters if r["TournamentLevel"] == 'Primary']
    new_tournament_results_rules = create_league_finalist_rules(
        new_players, new_tournament_results, write=False
    )
    print(f"Time to make tournament rules: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    new_countries_rules = create_country_rules(new_players, write=False)
    print(f"Time to make country rules: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    new_champions_rules = create_champion_rules(new_players, champ_players, write=False)
    print(f"Time to make champion rules: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    new_pentakill_rules = create_pentakill_rules(new_players, pentakills, write=False)
    print(f"Time to make pentakill rules: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    new_team_rules, new_teammate_rules, new_role_rules = (
        create_team_teammate_role_rules_mp(
            new_teams, new_players, all_rosters, write=False
        )
    )
    print(f"Time to process rosters: {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    ## Generate rule update files
    team_rule_adds, team_rule_evos, team_rule_rems = compare_rules(
        old_team_rules,
        new_team_rules,
        player_evos,
        compare_key=get_team_key_compare(new_teams, team_evos, team_rems),
    )
    teammate_rule_adds, teammate_rule_evos, teammate_rule_rems = compare_rules(
        old_teammates_rules,
        new_teammate_rules,
        player_evos,
        compare_key=get_player_key_compare(new_players, player_evos, player_rems),
    )
    roles_rule_adds, roles_rule_evos, roles_rule_rems = compare_rules_new(
        old_roles_rules, new_role_rules, player_evos
    )
    finalists_rule_adds, finalists_rule_evos, finalists_rule_rems = compare_rules_new(
        old_finalists_rules,
        {
            k: r
            for k, r in new_tournament_results_rules.items()
            if "Finalist" in r["key"]
        },
        player_evos,
        compare_remove_old,
    )
    (
        worlds_participants_rule_adds,
        worlds_participants_rule_evos,
        worlds_participants_rule_rems,
    ) = compare_rules_new(
        old_worlds_participants_rules,
        {
            k: r
            for k, r in new_tournament_results_rules.items()
            if re.search(r"World.+Participant", r["key"]) is not None
        },
        player_evos,
    )
    league_winner_rule_adds, league_winner_rule_evos, league_winner_rule_rems = (
        compare_rules_new(
            old_winner_rules,
            {
                k: r
                for k, r in new_tournament_results_rules.items()
                if "Winner" in r["key"]
            },
            player_evos,
        )
    )
    countries_rule_adds, countries_rule_evos, countries_rule_rems = compare_rules_new(
        old_countries_rules, new_countries_rules, player_evos
    )
    champions_rule_adds, champions_rule_evos, champions_rule_rems = compare_rules_new(
        old_champion_rules, new_champions_rules, player_evos, compare_remove_old
    )
    pentakill_rule_adds, pentakill_rule_evos, pentakill_rule_rems = compare_rules_new(
        old_pentakill_rules, new_pentakill_rules, player_evos, compare_remove_old
    )
    print(f"Time to make comparison objects (all): {(timelib.perf_counter()-timer)}")
    timer = timelib.perf_counter()
    ea = timelib.perf_counter()
    print(f"Time to process all data: {(ea-sa)}")
    ## Save update files
    write_to_json_file(
        f"data/{time_path}/cooked",
        "players",
        {"add": player_adds, "evo": player_evos, "rem": player_rems},
        format=False,
    )
    write_to_json_file(
        f"data/{time_path}/cooked",
        "teams",
        {"add": team_adds, "evo": team_evos, "rem": team_rems},
        format=False,
    )
    write_to_json_file(
        f"data/{time_path}/rules",
        "teams",
        {"add": team_rule_adds, "evo": team_rule_evos, "rem": team_rule_rems},
        format=False,
    )
    write_to_json_file(
        f"data/{time_path}/rules",
        "teammates",
        {
            "add": teammate_rule_adds,
            "evo": teammate_rule_evos,
            "rem": teammate_rule_rems,
        },
        format=False,
    )
    write_to_json_file(
        f"data/{time_path}/rules",
        "roles",
        {"add": roles_rule_adds, "evo": roles_rule_evos, "rem": roles_rule_rems},
        format=False,
    )
    write_to_json_file(
        f"data/{time_path}/rules",
        "finalists",
        {
            "add": finalists_rule_adds,
            "evo": finalists_rule_evos,
            "rem": finalists_rule_rems,
        },
        format=False,
    )
    write_to_json_file(
        f"data/{time_path}/rules",
        "worlds_participants",
        {
            "add": worlds_participants_rule_adds,
            "evo": worlds_participants_rule_evos,
            "rem": worlds_participants_rule_rems,
        },
        format=False,
    )
    write_to_json_file(
        f"data/{time_path}/rules",
        "countries",
        {
            "add": countries_rule_adds,
            "evo": countries_rule_evos,
            "rem": countries_rule_rems,
        },
        format=False,
    )
    write_to_json_file(
        f"data/{time_path}/rules",
        "champion_counts",
        {
            "add": champions_rule_adds,
            "evo": champions_rule_evos,
            "rem": champions_rule_rems,
        },
        format=False,
    )
    write_to_json_file(
        f"data/{time_path}/rules",
        "pentakills",
        {
            "add": pentakill_rule_adds,
            "evo": pentakill_rule_evos,
            "rem": pentakill_rule_rems,
        },
        format=False,
    )
    write_to_json_file(
        f"data/{time_path}/rules",
        "winners",
        {
            "add": league_winner_rule_adds,
            "evo": league_winner_rule_evos,
            "rem": league_winner_rule_rems,
        },
        format=False,
    )
    return
