import json, os
from datetime import datetime

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
    new_val = new_val.replace('\'', '\'\'')
    return f"'{new_val}'"

def generate_players_sql_new(new_players: dict, old_players: dict):
    migrate_sql = """BEGIN;
-- Update metadata --
INSERT INTO meta_dataupdate (date, app) VALUES ({date}, 'players');
-- Adding new players --
INSERT INTO players_player (display_name, real_name, age, country, residency) VALUES
{sql_adds};
-- Updating players --
{sql_updates}
-- Inserting all new alternate names --
INSERT INTO players_playeralternatename (alternate_name, player_name_id) VALUES
{sql_alt_names};
COMMIT;"""
    restore_sql = """BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='players' ORDER BY date DESC LIMIT 1);
-- Removing all new alternate names --
DELETE FROM players_playeralternatename WHERE id in (SELECT id FROM players_playeralternatename WHERE (
{sql_alt_names}));
-- Downdating players --
{sql_downdates}
-- Removing new players --
DELETE FROM players_player WHERE display_name in (
{sql_removes}
);
COMMIT;"""
    ## Pre-prepare alternate names
    alt_names: dict = {}
    ## Prepare sql_adds
    added_players: dict = new_players["add"]
    insertion_sql = "({}, {}, {}, {}, {})"
    insertions = []
    for k,v in added_players.items():
        insertions.append(insertion_sql.format(
            parse_varchar(k), parse_varchar(v["name"]), parse_int(v["age"]), parse_varchar(v["country"], True), parse_varchar(v["residency"], True)
        ))
        alt_names[k] = v["alternate_names"]
    sql_adds = ",\n".join(insertions)
    sql_removes = ',\n'.join([parse_varchar(k) for k in added_players.keys()])
    ## Prepare sql_updates
    updated_players: dict = new_players["evo"]
    update_sql = "UPDATE players_player SET {changes} WHERE display_name={old_key};"
    updates = []
    downdates = []
    for k,v in updated_players.items():
        updating_fields = {(a, "real_name")[a=="name"]:b for a,b in v.items() if a != "alternate_names"}
        if len(updating_fields) > 0:
            set_sql = ["{field}={value}".format(field=k, value=parse_varchar(v, True)) if k != "age" else "{field}={value}".format(field=k, value=parse_int(v)) for k,v in updating_fields.items()]
            unset_sql = ["{field}={value}".format(field=a, value=parse_varchar(old_players[k][(a, "name")[a=="real_name"]], True)) if a != "age" else "{field}={value}".format(field=a, value=parse_int(old_players[k][a])) for a,_ in updating_fields.items()]
            updates.append(update_sql.format(
                changes=', '.join(set_sql), old_key=parse_varchar(k)
            ))
            downdates.append(update_sql.format(
                changes=', '.join(unset_sql), old_key=parse_varchar(k if "display_name" not in v else v["display_name"])
            ))
        if "alternate_names" in v:
            alt_names[k if "display_name" not in v else v["display_name"]] = v["alternate_names"]
    sql_updates = "\n".join(updates)
    sql_downdates = "\n".join(downdates)
    ## Prepare sql_alt_names
    name_insertion_sql = "({alt_name}, (SELECT id FROM players_player WHERE display_name={main_key}))"
    name_deletion_sql = "(player_name_id=(SELECT id FROM players_player WHERE display_name={main_key}) AND alternate_name IN ({alt_names}))"
    new_names = []
    del_names = []
    for k,v in alt_names.items():
        for n in v:
            new_names.append(name_insertion_sql.format(alt_name=parse_varchar(n), main_key=parse_varchar(k)))
        del_names.append(name_deletion_sql.format(main_key=parse_varchar(k), alt_names=", ".join([
            parse_varchar(n) for n in v
        ])))
    sql_alt_names = ",\n".join(new_names)
    sql_del_names = " OR\n".join(del_names)
    return (migrate_sql.format(sql_adds=sql_adds, sql_updates=sql_updates, sql_alt_names=sql_alt_names, date=parse_varchar(datetime.now().strftime("%Y-%m-%d"))),
        restore_sql.format(sql_removes=sql_removes, sql_downdates=sql_downdates, sql_alt_names=sql_del_names))

def generate_teams_sql_new(new_teams: dict, old_teams: dict):
    migrate_sql = """BEGIN;
-- Update metadata --
INSERT INTO meta_dataupdate (date, app) VALUES ({date}, 'teams');
-- Adding new teams --
INSERT INTO teams_team (becomes, came_from, highest_level, image, name, op, region, short) VALUES
{sql_adds};
-- Updating teams --
{sql_updates}
-- Inserting all new alternate names --
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES
{sql_alt_names};
-- Inserting all new sister teams --
INSERT INTO teams_teamsisterteam (sister_team_name, team_op_id) VALUES
{sql_sister_teams};
-- Deactivate redendant teams
UPDATE teams_team SET active=FALSE WHERE op in (
{sql_deactivate}
);
COMMIT;"""
    restore_sql = """BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='teams' ORDER BY date DESC LIMIT 1);
-- Reactivate redendant teams
UPDATE teams_team SET active=TRUE WHERE op in (
{sql_reactivate}
);
-- Removing all new sister teams --
DELETE FROM teams_teamsisterteam WHERE id in (SELECT id FROM teams_teamsisterteam WHERE (
{sql_del_sisters}));
-- Removing all new alternate names --
DELETE FROM teams_teamalternatename WHERE id in (SELECT id FROM teams_teamalternatename WHERE (
{sql_alt_names}));
-- Downdating teams --
{sql_downdates}
-- Removing new teams --
DELETE FROM teams_team WHERE op in (
{sql_removes}
);
COMMIT;"""
    ## Pre-prepare alternate names
    alt_names: dict = {}
    sister_teams: dict = {}
    ## Prepare sql_adds
    added_teams: dict = new_teams["add"]
    insertion_sql = "({}, {}, {}, {}, {}, {}, {}, {})"
    insertions = []
    for k,v in added_teams.items():
        insertions.append(insertion_sql.format(
            parse_varchar(v["becomes"]), parse_varchar(v["came_from"]), parse_varchar(v["highest_level"], True), 
            parse_varchar(v["image"]), parse_varchar(v["name"]), parse_varchar(k), parse_varchar(v["region"]), parse_varchar(v["short"])
        ))
        alt_names[k] = v["other_names"]
        sister_teams[k] = v["sister_teams"]
    sql_adds = ",\n".join(insertions)
    sql_removes = ',\n'.join([parse_varchar(k) for k in added_teams.keys()])
    ## Prepare sql_updates
    updated_teams: dict = new_teams["evo"]
    update_sql = "UPDATE teams_team SET {changes} WHERE op={old_key};"
    updates = []
    downdates = []
    for k,v in updated_teams.items():
        updating_fields = {a:b for a,b in v.items() if a not in ["other_names", "sister_teams"]}
        if len(updating_fields) > 0:
            set_sql = ["{field}={value}".format(field=a, value=parse_varchar(b, True)) for a,b in updating_fields.items()]
            unset_sql = ["{field}={value}".format(field=a, value=parse_varchar(old_teams[k][a], True)) for a,_ in updating_fields.items()]
            updates.append(update_sql.format(
                changes=', '.join(set_sql), old_key=parse_varchar(k)
            ))
            downdates.append(update_sql.format(
                changes=', '.join(unset_sql), old_key=parse_varchar(k if "op" not in v else v["op"])
            ))
        if "other_names" in v:
            alt_names[k if "op" not in v else v["op"]] = v["other_names"]
        if "sister_teams" in v:
            sister_teams[k if "op" not in v else v["op"]] = v["sister_teams"]
    sql_updates = "\n".join(updates)
    sql_downdates = "\n".join(downdates)
    ## Prepare sql_alt_names
    name_insertion_sql = "({alt_name}, (SELECT id FROM teams_team WHERE op={main_key}))"
    name_deletion_sql = "(team_op_id=(SELECT id FROM teams_team WHERE op={main_key}) AND {field_name} IN ({alt_names}))"
    new_names = []
    del_names = []
    for k,v in alt_names.items():
        for n in v:
            new_names.append(name_insertion_sql.format(alt_name=parse_varchar(n), main_key=parse_varchar(k)))
        if len(v) > 0:
            del_names.append(name_deletion_sql.format(main_key=parse_varchar(k), alt_names=", ".join([
                parse_varchar(n) for n in v
            ]), field_name="alternate_name"))
    sql_alt_names = ",\n".join(new_names)
    sql_del_names = " OR\n".join(del_names)
    ## Prepare sql_sister_teams
    new_sisters = []
    del_sisters = []
    for k,v in sister_teams.items():
        for n in v:
            new_sisters.append(name_insertion_sql.format(alt_name=parse_varchar(n), main_key=parse_varchar(k)))
        if len(v) > 0:
            del_sisters.append(name_deletion_sql.format(main_key=parse_varchar(k), alt_names=", ".join([
                parse_varchar(n) for n in v
            ]), field_name="sister_team_name"))
    sql_sister_teams = ",\n".join(new_sisters)
    sql_del_sisters = " OR\n".join(del_sisters)
    ## Prepare deactivations
    removed_teams = ""
    if "rem" in new_teams:
        removed_teams = ",\n".join([parse_varchar(k) for k in new_teams["rem"]])
    
    return (migrate_sql.format(sql_adds=sql_adds, sql_updates=sql_updates, sql_alt_names=sql_alt_names,
    date=parse_varchar(datetime.now().strftime("%Y-%m-%d")), sql_sister_teams=sql_sister_teams, sql_deactivate=removed_teams),
        restore_sql.format(sql_removes=sql_removes, sql_downdates=sql_downdates,
        sql_alt_names=sql_del_names, sql_del_sisters=sql_del_sisters, sql_reactivate=removed_teams))

def generate_rules_sql(new_rules: dict, old_rules: dict):
    migrate_sql = """BEGIN;
-- Update metadata --
INSERT INTO meta_dataupdate (date, app) VALUES ({date}, 'rules');
-- Adding new rules --
INSERT INTO rules_rule (key, rule_type) VALUES
{sql_adds};
-- Updating rules --
{sql_updates}
-- Inserting all new valid players --
INSERT INTO rules_rule_valid_players (player_id, rule_id) VALUES
{sql_alt_names};
-- Deactivate redendant teams
UPDATE rules_rule SET active=FALSE WHERE key in (
{sql_deactivate}
);
COMMIT;"""
    restore_sql = """BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='rules' ORDER BY date DESC LIMIT 1);
-- Reactivate teams --
UPDATE rules_rule SET active=TRUE WHERE key in (
{sql_reactivate}
);
-- Delete all new valid players --
DELETE FROM rules_rule_valid_players WHERE id in (SELECT id FROM rules_rule_valid_players WHERE (
{sql_del_players}));
-- Downdate rules --
{sql_downdates}
-- Remove new rules --
DELETE FROM rules_rule WHERE key in (
{sql_removes}
);
COMMIT;"""
    ## Pre-prepare valid players
    valid_players: dict = {}
    ## Prepare sql_adds
    added_rules: dict = new_rules["add"]
    insertion_sql = "({}, {})"
    insertions = []
    for k,v in added_rules.items():
        insertions.append(insertion_sql.format(
            parse_varchar(k), parse_varchar(v["type"])
        ))
        valid_players[k] = v["valid_players"]
    sql_adds = ",\n".join(insertions)
    sql_removes = ',\n'.join([parse_varchar(k) for k in added_rules.keys()])
    ## Prepare sql_updates
    updated_rules: dict = new_rules["evo"]
    update_sql = "UPDATE rules_rule SET {changes} WHERE key={old_key};"
    updates = []
    downdates = []
    for k,v in updated_rules.items():
        updating_fields = {a:b for a,b in v.items() if a not in ["exclusive_crosses", "valid_players"]}
        if len(updating_fields) > 0:
            set_sql = ["{field}={value}".format(field=k, value=parse_varchar(v, True)) for k,v in updating_fields.items()]
            unset_sql = ["{field}={value}".format(field=a, value=parse_varchar(old_rules[k][a], True)) for a,_ in updating_fields.items()]
            updates.append(update_sql.format(
                changes=', '.join(set_sql), old_key=parse_varchar(k)
            ))
            downdates.append(update_sql.format(
                changes=', '.join(unset_sql), old_key=parse_varchar(k if "key" not in v else v["key"])
            ))
        if "valid_players" in v:
            valid_players[k if "key" not in v else v["key"]] = v["valid_players"]
    sql_updates = "\n".join(updates)
    sql_downdates = "\n".join(downdates)
    ## Prepare valid players
    player_insertion_sql = "((SELECT id FROM players_player WHERE display_name={player_name}), (SELECT id FROM rules_rule WHERE key={rule_key}))"
    player_deletion_sql = "(rule_id=(SELECT id FROM rules_rule WHERE key={rule_key}) AND player_id IN (SELECT id FROM players_player WHERE display_name IN ({player_names})))"
    new_players = []
    del_players = []
    for k,v in valid_players.items():
        for n in v:
            new_players.append(player_insertion_sql.format(player_name=parse_varchar(n), rule_key=parse_varchar(k)))
        if len(v) > 0:
            del_players.append(player_deletion_sql.format(rule_key=parse_varchar(k), player_names=", ".join([
                parse_varchar(n) for n in v
            ])))
    sql_alt_names = ",\n".join(new_players)
    sql_del_names = " OR\n".join(del_players)
    ## Prepare deactivations
    removed_rules = ""
    if "rem" in new_rules:
        removed_rules = ",\n".join([parse_varchar(k) for k in new_rules["rem"]])
    
    return (migrate_sql.format(sql_adds=sql_adds, sql_updates=sql_updates, sql_alt_names=sql_alt_names,
    date=parse_varchar(datetime.now().strftime("%Y-%m-%d")), sql_deactivate=removed_rules),
        restore_sql.format(sql_removes=sql_removes, sql_downdates=sql_downdates,
        sql_alt_names=sql_del_names, sql_del_players=sql_del_names, sql_reactivate=removed_rules))

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
        "evo": rules_teams["evo"] | rules_teammates["evo"] | rules_roles["evo"] | rules_countries["evo"] | rules_finalists["evo"] | rules_worlds_participants["evo"],
        "rem": rules_teams["rem"] + rules_teammates["rem"] + rules_roles["rem"] + rules_countries["rem"] + rules_finalists["rem"] + rules_worlds_participants["rem"],
        }
    
    os.makedirs("data/update/scripts", exist_ok=True)
    ## Players
    # players_sql, players_sql_undo = generate_players_sql(old_players, new_players)
    plr_sql, plr_sql_rem = generate_players_sql_new(new_players, old_players)

    with open("data/update/scripts/update_players.sql", 'w+', encoding='utf-8') as f:
        f.write(plr_sql)
    with open("data/update/scripts/update_players_restore.sql", 'w+', encoding='utf-8') as f:
        f.write(plr_sql_rem)
    ## Teams
    teams_sql, teams_sql_undo = generate_teams_sql_new(new_teams, old_teams)
    with open("data/update/scripts/update_teams.sql", 'w+', encoding='utf-8') as f:
        f.write(teams_sql)
    with open("data/update/scripts/update_teams_restore.sql", 'w+', encoding='utf-8') as f:
        f.write(teams_sql_undo)
    ## Rules
    rules_sql, rules_sql_undo = generate_rules_sql(new_rules, old_rules)
    with open("data/update/scripts/update_rules.sql", 'w+', encoding='utf-8') as f:
        f.write(rules_sql)
    with open("data/update/scripts/update_rules_restore.sql", 'w+', encoding='utf-8') as f:
        f.write(rules_sql_undo)
    
    