import json, time
from shared.util import write_to_json_file, get_team_key_cached, get_player_key_cached
from multiprocessing import Pool, Manager, Lock, cpu_count


def index_or_large(l: list, o):
    try:
        return l.index(o)
    except ValueError:
        return len(l)


def create_team_teammate_role_rules(
    cooked_teams: dict, cooked_players: dict, raw_rosters: list, write=True
):
    team_rules = {}
    player_levels = {}
    teammate_rules = {}
    role_rules = {}
    player_roles = ["Top", "Jungle", "Mid", "Bot", "Support"]
    levels = ["Primary", "Secondary", "Showmatch", ""]
    p_cache = {}
    t_cache = {}
    roster_no = 0
    bm = []
    for roster in raw_rosters:
        roster_no += 1
        print(f"\rRoster {roster_no}/{len(raw_rosters)}", sep=" ", end="", flush=True)
        team_key = get_team_key_cached(cooked_teams, roster["Team"], t_cache)
        if (
            roster["Roles"] is None
            or roster["RosterLinks"] is None
            or len(roster["Roles"]) != len(roster["RosterLinks"])
        ):
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
            player_key = get_player_key_cached(cooked_players, player_name, p_cache)
            if player_key is None:
                continue
            for role in roster["Roles"][i].split(","):
                if role not in player_roles:
                    continue
                roster_region = roster["Region"]
                if roster["Region"] != "" and roster["Region"] is not None:
                    region_set.add(roster_region)
                # Add to role rules
                if role not in role_rules:
                    role_rules[role] = {
                        "key": role,
                        "type": "role",
                        "regions": set(["World"]),
                        "valid_players": set(),
                        "exclusive_crosses": set(),
                    }
                role_rules[role]["valid_players"].add(player_key)
                # Add to team rules (if team has page)
                if (
                    team_key is not None
                    and cooked_teams[team_key]["highest_level"] == "Primary"
                ):
                    if team_key not in team_rules:
                        team_rules[team_key] = {
                            "key": team_key,
                            "type": "team",
                            "regions": region_set,
                            "valid_players": set(),
                            "exclusive_crosses": set(),
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
                if player_key not in player_levels or (
                    index_or_large(levels, player_levels[player_key])
                    >= index_or_large(levels, roster["TournamentLevel"])
                ):
                    player_levels[player_key] = roster["TournamentLevel"]
                if player_key not in teammate_rules:
                    teammate_rules[player_key] = {
                        "key": player_key,
                        "type": "teammate",
                        "regions": player_regions,
                        "valid_players": set(),
                        "exclusive_crosses": set(),
                    }
                teammate_rules[player_key]["valid_players"] |= set(
                    [
                        get_player_key_cached(
                            cooked_players, roster["RosterLinks"][i], p_cache
                        )
                        for i in range(len(roster["RosterLinks"]))
                        if roster["Roles"][i] in player_roles
                        and player_name != roster["RosterLinks"][i]
                        and get_player_key_cached(
                            cooked_players, roster["RosterLinks"][i], p_cache
                        )
                        is not None
                    ]
                )
                teammate_rules[player_key]["regions"] |= player_regions
    # Remove secondary people
    teammate_rules = {
        k: v for k, v in teammate_rules.items() if player_levels[k] == "Primary"
    }
    if write:
        team_loc = write_to_json_file("data/rules", "teams", team_rules, format=False)
        teammate_loc = write_to_json_file(
            "data/rules", "teammates", teammate_rules, format=False
        )
        role_loc = write_to_json_file("data/rules", "roles", role_rules, format=False)
    return team_rules, teammate_rules, role_rules


## Multiprocessing

cache = None
cache_lock = None
player_levels = None


def init_shared_objects(pk_cache, pk_cache_lock, plr_levels):
    global cache, cache_lock, player_levels
    cache = pk_cache
    cache_lock = pk_cache_lock
    player_levels = plr_levels


def this_pk_cached(cooked_players: dict, key: str):
    global cache, cache_lock
    if key in cache:
        return cache[key]
    # with cache_lock:
    pk = get_player_key_cached(cooked_players, key, {})
    cache[key] = pk
    return pk


def process_rosters_mp(
    cooked_teams: dict, cooked_players: dict, raw_rosters: list, write=True
):
    global cache_lock, player_levels
    team_rules = {}
    teammate_rules = {}
    role_rules = {}
    player_roles = ["Top", "Jungle", "Mid", "Bot", "Support"]
    levels = ["Primary", "Secondary", "Showmatch", ""]
    t_cache = {}
    roster_no = 0
    bm = []
    for roster in raw_rosters:
        roster_no += 1
        team_key = get_team_key_cached(cooked_teams, roster["Team"], t_cache)
        if (
            roster["Roles"] is None
            or roster["RosterLinks"] is None
            or len(roster["Roles"]) != len(roster["RosterLinks"])
        ):
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
            player_key = this_pk_cached(cooked_players, player_name)
            if player_key is None:
                continue
            for role in roster["Roles"][i].split(","):
                if role not in player_roles:
                    continue
                roster_region = roster["Region"]
                if roster["Region"] != "" and roster["Region"] is not None:
                    region_set.add(roster_region)
                # Add to role rules
                if role not in role_rules:
                    role_rules[role] = {
                        "key": role,
                        "type": "role",
                        "regions": set(["World"]),
                        "valid_players": set(),
                        "exclusive_crosses": set(),
                    }
                role_rules[role]["valid_players"].add(player_key)
                # Add to team rules (if team has page)
                if (
                    team_key is not None
                    and cooked_teams[team_key]["highest_level"] == "Primary"
                ):
                    if team_key not in team_rules:
                        team_rules[team_key] = {
                            "key": team_key,
                            "type": "team",
                            "regions": region_set,
                            "valid_players": set(),
                            "exclusive_crosses": set(),
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
                with cache_lock:
                    if player_key not in player_levels or (
                        index_or_large(levels, player_levels[player_key])
                        >= index_or_large(levels, roster["TournamentLevel"])
                    ):
                        player_levels[player_key] = roster["TournamentLevel"]
                if player_key not in teammate_rules:
                    teammate_rules[player_key] = {
                        "key": player_key,
                        "type": "teammate",
                        "regions": player_regions,
                        "valid_players": set(),
                        "exclusive_crosses": set(),
                    }
                teammate_rules[player_key]["valid_players"] |= set(
                    [
                        this_pk_cached(cooked_players, roster["RosterLinks"][i])
                        for i in range(len(roster["RosterLinks"]))
                        if roster["Roles"][i] in player_roles
                        and player_name != roster["RosterLinks"][i]
                        and this_pk_cached(cooked_players, roster["RosterLinks"][i])
                        is not None
                    ]
                )
                teammate_rules[player_key]["regions"] |= player_regions
    print(f"Batch Complete")
    return team_rules, teammate_rules, role_rules


def merge_rule(a, b):
    a["regions"] |= b["regions"]
    a["valid_players"] |= b["valid_players"]
    a["exclusive_crosses"] |= b["exclusive_crosses"]
    return a


def merge_results(results):
    team_rules, teammate_rules, role_rules = {}, {}, {}
    for result in results:
        tr_b, tm_b, rr_b = result
        for k, v in tr_b.items():
            team_rules.setdefault(k, v)
            if k in team_rules:
                team_rules[k] = merge_rule(team_rules[k], v)
        for k, v in tm_b.items():
            teammate_rules.setdefault(k, v)
            if k in teammate_rules:
                teammate_rules[k] = merge_rule(teammate_rules[k], v)
        for k, v in rr_b.items():
            role_rules.setdefault(k, v)
            if k in role_rules:
                role_rules[k] = merge_rule(role_rules[k], v)
    return team_rules, teammate_rules, role_rules


def create_team_teammate_role_rules_mp(
    cooked_teams: dict, cooked_players: dict, raw_rosters: list, write=True
):
    manager = Manager()
    pk_cache = manager.dict()
    plr_cache = manager.dict()
    pk_cache_lock = manager.Lock()

    batch_size = 5000
    batches = []
    for i in range(0, len(raw_rosters), batch_size):
        batch = raw_rosters[i : i + batch_size]
        batches.append((cooked_teams, cooked_players, batch))

    with Pool(
        cpu_count() // 2,
        initializer=init_shared_objects,
        initargs=(pk_cache, pk_cache_lock, plr_cache),
    ) as pool:
        results = pool.starmap(process_rosters_mp, batches)

    a, b, c = merge_results(results)

    # Remove secondary people
    b = {k: v for k, v in b.items() if plr_cache[k] == "Primary"}

    return a, b, c
