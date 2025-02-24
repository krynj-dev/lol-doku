import json, os
from .gen_update_rules_sql import generate_rules_sql

def blank_or_none_to_null(val, allow_blank=False):
    if val is None or (not allow_blank and val == ""):
        return "NULL"
    return val

def parse_int(val):
    new_val = blank_or_none_to_null(val)
    if new_val == "NULL":
        return new_val
    return int(new_val)

def parse_varchar(val, allow_blank=False):
    new_val: str = blank_or_none_to_null(val, allow_blank)
    if new_val == "NULL":
        return new_val
    new_val = new_val.replace('\'', '\\\'')
    return f"'{new_val}'"

def generate_players_sql(old_players, new_players):
    adds: dict = new_players["add"]
    evos: dict = new_players["evo"]
    sql = "INSERT INTO players_player (display_name, real_name, country, age, residency) VALUES\n"
    undo_sql = "DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='players' ORDER BY date DESC LIMIT 1);"
    ## Handle adds
    updates = []
    alt_names = {}
    undo_sql = "SELECT setval('players_player_id_seq', {}, true);\n".format(len(old_players)) + undo_sql
    for k,v in adds.items():
        alt_names[k] = v["alternate_names"]
        updates.append("({}, {}, {}, {}, {})".format(
            parse_varchar(k), parse_varchar(v["name"], True), parse_varchar(v["country"], True),
            parse_int(v["age"]), parse_varchar(v["residency"])
        ))
        undo_sql = "DELETE FROM players_player WHERE display_name={};\n".format(parse_varchar(k)) + undo_sql
    sql += ",\n".join(updates) + ";\n"
    ## Handle evos
    for k,v in evos.items():
        nk = v[0]
        ov = old_players[k]
        alt_names[nk] = v[1]["alternate_names"]
        sql += "UPDATE players_player SET display_name={}, real_name={}, country={}, age={}, residency={} WHERE display_name={};\n".format(
            parse_varchar(nk), parse_varchar(v[1]["name"], True), parse_varchar(v[1]["country"], True),
            parse_int(v[1]["age"]), parse_varchar(v[1]["residency"]), parse_varchar(k)
        )
        undo_sql = "UPDATE players_player SET display_name={}, real_name={}, country={}, age={}, residency={} WHERE display_name={};\n".format(
            parse_varchar(k), parse_varchar(ov["name"], True), parse_varchar(ov["country"], True),
            parse_int(ov["age"]), parse_varchar(ov["residency"]), parse_varchar(nk)
        ) + undo_sql
    ## Handle new alt names
    undo_sql = "SELECT setval('players_playeralternatename_id_seq', (SELECT MAX(id) FROM players_playeralternatename), true);\n" + undo_sql
    alt_name_sql = '''INSERT INTO players_playeralternatename (alternate_name, player_name_id) VALUES ({}, (SELECT id FROM players_player WHERE display_name={}));\n'''
    alt_name_sql_restore = '''DELETE FROM players_playeralternatename WHERE alternate_name={} AND player_name_id=(SELECT id FROM players_player WHERE display_name={});\n'''
    for k,v in alt_names.items():
        if len(v) == 0:
            continue
        for n in v:
            sql += alt_name_sql.format(parse_varchar(n), parse_varchar(k))
            undo_sql = alt_name_sql_restore.format(parse_varchar(n), parse_varchar(k)) + undo_sql
    sql += '''INSERT INTO meta_dataupdate (date, app) VALUES (date('now'), 'players');'''
    return f"BEGIN;\n{sql}\nCOMMIT;", f"BEGIN;\n{undo_sql}\nCOMMIT;"

def generate_teams_sql(old_teams, new_teams):
    adds: dict = new_teams["add"]
    evos: dict = new_teams["evo"]
    ## Identify merges
    counts = {}
    for a in [v[0] for v in evos.values()]:
        if a not in counts:
            counts[a] = 1
        else:
            counts[a] += 1
    evo_merges = {k:v for k,v in evos.items() if k in old_teams and v[0] in old_teams and k != v[0]} # one team being subsumed by another already existing one
    merge_evos = {k:v for k,v in evos.items() if counts[v[0]] > 1 and k != v[0]} # multiple teams both evolving into a new one
    only_evos = {k:v for k,v in evos.items() if k not in merge_evos and k not in evo_merges}
    ## Handle merge evos
    seen = set([v[0] for _,v in merge_evos.items() if v[0] in old_teams])
    for k,v in merge_evos.items():
        if v[0] in seen:
            evo_merges[k] = v
        else:
            only_evos[k] = v
        seen.add(v[0])
    ## Handle adds
    sql = "INSERT INTO teams_team (becomes, came_from, highest_level, image, name, op, region, short) VALUES\n"
    undo_sql = "DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='teams' ORDER BY date DESC LIMIT 1);"
    updates = []
    alt_names = {}
    sister_names = {}
    undo_sql = "SELECT setval('teams_team_id_seq', {}, true);\n".format(len(old_teams)) + undo_sql
    for k,v in adds.items():
        alt_names[k] = v["other_names"]
        sister_names[k] = v["sister_teams"]
        updates.append("({}, {}, {}, {}, {}, {}, {} ,{})".format(
            parse_varchar(v["becomes"]), parse_varchar(v["came_from"]), parse_varchar(v["highest_level"], True),
            parse_varchar(v["image"], True), parse_varchar(v["name"]), parse_varchar(v["op"]), parse_varchar(v["region"], True), parse_varchar(v["short"], True)
        ))
        undo_sql = "DELETE FROM teams_team WHERE op={};\n".format(parse_varchar(k)) + undo_sql
    sql += ",\n".join(updates) + ";\n"
    ## Handle pure evos
    for k,v in only_evos.items():
        v1 = v[1]
        ov = old_teams[k]
        alt_names[v[0]] = set(v1["other_names"]) - set(old_teams[k]["other_names"])
        sister_names[v[0]] = set(v1["sister_teams"]) - set(old_teams[k]["sister_teams"])
        sql += "UPDATE teams_team SET becomes={}, came_from={}, highest_level={}, image={}, name={}, op={}, region={}, short={} WHERE op={};\n".format(
            parse_varchar(v1["becomes"]), parse_varchar(v1["came_from"]), parse_varchar(v1["highest_level"], True),
            parse_varchar(v1["image"], True), parse_varchar(v1["name"]), parse_varchar(v1["op"]), parse_varchar(v1["region"], True), parse_varchar(v1["short"], True),
            parse_varchar(k)
        )
        undo_sql = "UPDATE teams_team SET becomes={}, came_from={}, highest_level={}, image={}, name={}, op={}, region={}, short={} WHERE op={};\n".format(
            parse_varchar(ov["becomes"]), parse_varchar(ov["came_from"]), parse_varchar(ov["highest_level"], True),
            parse_varchar(ov["image"], True), parse_varchar(ov["name"]), parse_varchar(ov["op"]), parse_varchar(ov["region"], True), parse_varchar(ov["short"], True),
            parse_varchar(v[0])
        ) + undo_sql
    ## Handle evo merges
    evo_merge_sql = '''DELETE FROM teams_{0} WHERE {1}={3} AND team_op_id=(SELECT id FROM teams_team WHERE op={2});\n'''
    evo_merge_sql_restore = '''INSERT INTO teams_{0} ({1}, team_op_id) VALUES ({3}, (SELECT id FROM teams_team WHERE op={2}));\n'''
    restore_deletes = []
    i_list = list(old_teams.keys())
    for k,v in evo_merges.items():
        for n in set(old_teams[k]["other_names"]):
            sql += evo_merge_sql.format("teamalternatename", "alternate_name", parse_varchar(k), parse_varchar(n))
            undo_sql = evo_merge_sql_restore.format("teamalternatename", "alternate_name", parse_varchar(k), parse_varchar(n)) + undo_sql
        for n in set(old_teams[k]["sister_teams"]):
            sql += evo_merge_sql.format("teamsisterteam", "sister_team_name", parse_varchar(k), parse_varchar(n))
            undo_sql = evo_merge_sql_restore.format("teamsisterteam", "sister_team_name",  parse_varchar(k), parse_varchar(n)) + undo_sql
        sql += "DELETE FROM teams_team WHERE op={};\n".format(parse_varchar(k))
        ot = old_teams[k]
        restore_deletes.append("({}, {}, {}, {}, {}, {}, {}, {} ,{})".format(
            parse_int(i_list.index(k)+1), parse_varchar(ot["becomes"]), parse_varchar(ot["came_from"]), parse_varchar(ot["highest_level"], True),
            parse_varchar(ot["image"], True), parse_varchar(ot["name"]), parse_varchar(ot["op"]), parse_varchar(ot["region"], True), parse_varchar(ot["short"], True)
        ))
    undo_sql = '''INSERT INTO teams_team (id, becomes, came_from, highest_level, image, name, op, region, short) VALUES''' + ",\n".join(restore_deletes) + ";\n" + undo_sql
    new_alts = []
    alt_name_sql = "({0}, (SELECT id FROM teams_team WHERE op = {1}))"
    alt_name_sql_restore = '''DELETE FROM teams_team{0} WHERE team_op_id=(SELECT id FROM teams_team WHERE op={2}) AND {1}={3};\n'''
    for k,vs in alt_names.items():
        if len(vs) == 0:
            continue
        for n in vs:
            new_alts.append(alt_name_sql.format(parse_varchar(n), parse_varchar(k)))
            undo_sql = alt_name_sql_restore.format("alternatename", "alternate_name",  parse_varchar(k), parse_varchar(n)) + undo_sql
    sql += "INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES\n" + ",\n".join(new_alts) + ";\n"

    new_sisters = []
    sister_team_sql = "({0}, (SELECT id FROM teams_team WHERE op = {1}))"
    for k,vs in sister_names.items():
        if len(vs) == 0:
            continue
        for n in vs:
            new_sisters.append(sister_team_sql.format(parse_varchar(n), parse_varchar(k)))
            undo_sql = alt_name_sql_restore.format("sisterteam", "sister_team_name",  parse_varchar(k), parse_varchar(n)) + undo_sql
    sql += "INSERT INTO teams_teamsisterteam (sister_team_name, team_op_id) VALUES\n" + ",\n".join(new_sisters) + ";\n"
    
    sql += '''INSERT INTO meta_dataupdate (date, app) VALUES (date('now'), 'teams');'''    
    return f"BEGIN;\n{sql}\nCOMMIT;", f"BEGIN;\n{undo_sql}\nCOMMIT;"

def generate_players_sql_new(new_players):
    adds = new_players["add"]
    change = new_players["evo"]
    rems = new_players["rem"]
    sql = "INSERT INTO players_player (display_name, real_name, country, age, residency) VALUES\n"
    sql_undo = ""
    adds_rem_sql = "DELETE FROM players_player WHERE display_name IN (\n{});\n"
    adds_sql = []
    alt_names = []
    for k,v in adds.items():
        adds_sql.append("({}, {}, {}, {}, {})".format(
            parse_varchar(k), parse_varchar(v["name"]), parse_varchar(v["country"]), parse_int(v["age"]), parse_varchar(v["residency"])
        ))
        for n in v["alternate_names"]:
            alt_names.append("((SELECT id FROM players_player WHERE display_name={}), {})".format(parse_varchar(k), parse_varchar(n)))
    sql += ",\n".join(adds_sql) + ";\n"
    sql += "INSERT INTO players_playeralternatename (player_name_id, alternate_name) VALUES\n{}".format(
        ",\n".join(alt_names)
    ) + ";\n"
    sql_undo = adds_rem_sql.format(',\n'.join([parse_varchar(k) for k in adds.keys()])) + sql_undo
    sql_undo = "DELETE FROM players_playeralternatename WHERE player_name_id IN (SELECT id FROM players_player WHERE display_name IN (\n{}));".format(
        ",\n".join([parse_varchar(k) for k in adds.keys()])
    ) + "\n" + sql_undo
    return sql, sql_undo



def generate_update_sql():
    ## Read in existing files
    with open("data/cooked/players.json", "r+", encoding='utf-8') as f:
        old_players = json.load(f)
    with open("data/cooked/teams.json", "r+", encoding='utf-8') as f:
        old_teams = json.load(f)
    with open("data/rules/all.json", "r+", encoding='utf-8') as f:
        old_rules = json.load(f)
    ## Read in update files
    with open("data/update/cooked/players.json", "r+", encoding='utf-8') as f:
        new_players = json.load(f)
    with open("data/update/cooked/teams.json", "r+", encoding='utf-8') as f:
        new_teams = json.load(f)
    with open("data/update/rules/teams.json", "r+", encoding='utf-8') as f:
        rules_teams = json.load(f)
    with open("data/update/rules/teammates.json", "r+", encoding='utf-8') as f:
        rules_teammates = json.load(f)
    with open("data/update/rules/roles.json", "r+", encoding='utf-8') as f:
        rules_roles = json.load(f)
    with open("data/update/rules/countries.json", "r+", encoding='utf-8') as f:
        rules_countries = json.load(f)
    with open("data/update/rules/finalists.json", "r+", encoding='utf-8') as f:
        rules_finalists = json.load(f)
    with open("data/update/rules/worlds_participants.json", "r+", encoding='utf-8') as f:
        rules_worlds_participants = json.load(f)
    
    new_rules = {
        "add": rules_teams["add"] | rules_teammates["add"] | rules_roles["add"] | rules_countries["add"] | rules_finalists["add"] | rules_worlds_participants["add"],
        "evo": rules_teams["evo"] | rules_teammates["evo"] | rules_roles["evo"] | rules_countries["evo"] | rules_finalists["evo"] | rules_worlds_participants["evo"]
        }
    
    os.makedirs("data/update/scripts", exist_ok=True)
    ## Players
    # players_sql, players_sql_undo = generate_players_sql(old_players, new_players)
    plr_sql, plr_sql_rem = generate_players_sql_new(new_players)

    with open("data/update/scripts/update_players.sql", 'w+', encoding='utf-8') as f:
        f.write(plr_sql)
    with open("data/update/scripts/update_players_restore.sql", 'w+', encoding='utf-8') as f:
        f.write(plr_sql_rem)
    ## Teams
    teams_sql, teams_sql_undo = generate_teams_sql(old_teams, new_teams)
    with open("data/update/scripts/update_teams.sql", 'w+', encoding='utf-8') as f:
        f.write(teams_sql)
    with open("data/update/scripts/update_teams_restore.sql", 'w+', encoding='utf-8') as f:
        f.write(teams_sql_undo)
    ## Rules
    rules_sql, rules_sql_undo = generate_rules_sql(old_rules, new_rules)
    with open("data/update/scripts/update_rules.sql", 'w+', encoding='utf-8') as f:
        f.write(rules_sql)
    with open("data/update/scripts/update_rules_restore.sql", 'w+', encoding='utf-8') as f:
        f.write(rules_sql_undo)
    
    