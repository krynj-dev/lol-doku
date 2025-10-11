import json, os
from datetime import datetime, timedelta
from update.fetch_update_data import load_most_recent_data

## TODO Add code to clean up puzzles, rosters, stats etc. when reversing the SQL update

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

def parse_bool(val: bool):
    if val:
        return "TRUE"
    else:
        return "FALSE"

def parse_varchar_with_blank(val):
    return parse_varchar(val, True)

_parse_map_player = {
    "age": parse_int,
    "active": parse_bool
}

def get_parse_func(key: str):
    if key in _parse_map_player:
        return _parse_map_player[key]
    return parse_varchar_with_blank

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
INSERT INTO players_playeralternatename (alternate_name, player_name_id)
SELECT v.alt, p.id
FROM players_player p
JOIN (
    VALUES
        {sql_alt_names}
) AS v(alt, display_name)
  ON p.display_name = v.display_name;
COMMIT;"""
    restore_sql = """BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='players' ORDER BY date DESC LIMIT 1);
-- Removing all new alternate names --
DELETE FROM players_playeralternatename pa
USING players_player p,
     (VALUES
        {sql_alt_names}
     ) AS v(display_name, alt)
WHERE pa.alternate_name = v.alt
  AND p.display_name = v.display_name
  AND pa.player_name_id = p.id;
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
            parse_varchar(k), parse_varchar(v["name"], True), parse_int(v["age"]), parse_varchar(v["country"], True), parse_varchar(v["residency"], True)
        ))
        alt_names[k] = set(v["alternate_names"])
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
            # set_sql = ["{field}={value}".format(field=k, value=parse_varchar(v, True)) if k != "age" else "{field}={value}".format(field=k, value=parse_int(v)) for k,v in updating_fields.items()]
            # unset_sql = ["{field}={value}".format(field=a, value=parse_varchar(old_players[k][(a, "name")[a=="real_name"]], True)) if a != "age" else "{field}={value}".format(field=a, value=parse_int(old_players[k][a])) for a,_ in updating_fields.items()]
            set_sql = ["{field}={value}".format(field=k, value=get_parse_func(k)(v)) for k,v in updating_fields.items()]
            unset_sql = ["{field}={value}".format(field=a, value=get_parse_func(a)(old_players[k][(a, "name")[a=="real_name"]])) for a,_ in updating_fields.items()]
            updates.append(update_sql.format(
                changes=', '.join(set_sql), old_key=parse_varchar(k)
            ))
            downdates.append(update_sql.format(
                changes=', '.join(unset_sql), old_key=parse_varchar(k if "display_name" not in v else v["display_name"])
            ))
        if "alternate_names" in v:
            alt_names[k if "display_name" not in v else v["display_name"]] = set(v["alternate_names"])
    sql_updates = "\n".join(updates)
    sql_downdates = "\n".join(downdates)
    ## Prepare sql_alt_names
    name_insertion_sql = "({alt_name}, {main_key})"
    name_deletion_sql = "({main_key},{alt_name})"
    new_names = []
    del_names = []
    for k,v in alt_names.items():
        for n in v:
            new_names.append(name_insertion_sql.format(alt_name=parse_varchar(n), main_key=parse_varchar(k)))
            del_names.append(name_deletion_sql.format(alt_name=parse_varchar(n), main_key=parse_varchar(k)))
    sql_alt_names = ",\n".join(new_names)
    sql_del_names = ",\n".join(del_names)
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
-- Deactivate redundant teams
UPDATE teams_team SET active=FALSE WHERE op in (
{sql_deactivate}
);
-- Reactivate readded teams
UPDATE teams_team SET active=TRUE WHERE op in (
{sql_reactivate}
);
COMMIT;"""
    restore_sql = """BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='teams' ORDER BY date DESC LIMIT 1);
-- Deactivate readded teams
UPDATE teams_team SET active=FALSE WHERE op in (
{sql_deactivate}
);
-- Reactivate redundant teams
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
    reactivated = set()
    updated_teams: dict = new_teams["evo"]
    update_sql = "UPDATE teams_team SET {changes} WHERE op={old_key};"
    updates = []
    downdates = []
    for k,v in updated_teams.items():
        key_to_be = k if "op" not in v else v["op"]
        updating_fields = {a:b for a,b in v.items() if a not in ["other_names", "sister_teams", "active"]}
        if len(updating_fields) > 0:
            set_sql = ["{field}={value}".format(field=a, value=get_parse_func(a)(b)) for a,b in updating_fields.items()]
            unset_sql = ["{field}={value}".format(field=a, value=get_parse_func(a)(old_teams[k][a])) for a,_ in updating_fields.items()]
            updates.append(update_sql.format(
                changes=', '.join(set_sql), old_key=parse_varchar(k)
            ))
            downdates.append(update_sql.format(
                changes=', '.join(unset_sql), old_key=parse_varchar(key_to_be)
            ))
        if "other_names" in v:
            alt_names[key_to_be] = v["other_names"]
        if "sister_teams" in v:
            sister_teams[key_to_be] = v["sister_teams"]
        if "active" in v and v["active"]:
            reactivated.add(key_to_be)
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
    readded_teams = ",\n".join([parse_varchar(k) for k in reactivated])
    
    return (migrate_sql.format(sql_adds=sql_adds, sql_updates=sql_updates, sql_alt_names=sql_alt_names,
    date=parse_varchar(datetime.now().strftime("%Y-%m-%d")), sql_sister_teams=sql_sister_teams, sql_deactivate=removed_teams, sql_reactivate=readded_teams),
        restore_sql.format(sql_removes=sql_removes, sql_downdates=sql_downdates,
        sql_alt_names=sql_del_names, sql_del_sisters=sql_del_sisters, sql_reactivate=removed_teams, sql_deactivate=readded_teams))

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
INSERT INTO rules_rule_valid_players (player_id, rule_id) 
SELECT p.id, r.id
FROM (
    VALUES
    {sql_alt_names}
)AS v(display_name, rule_key)
JOIN players_player p ON p.display_name = v.display_name
JOIN rules_rule r ON r.key = v.rule_key;
-- Deactivate redundant teams
UPDATE rules_rule SET active=FALSE WHERE key in (
{sql_deactivate}
);
-- Reactivate readded teams
UPDATE rules_rule SET active=TRUE WHERE key in (
{sql_reactivate}
);
COMMIT;"""
    restore_sql = """BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='rules' ORDER BY date DESC LIMIT 1);
-- Deactivate teams
UPDATE rules_rule SET active=FALSE WHERE key in (
{sql_deactivate}
);
-- Reactivate teams --
UPDATE rules_rule SET active=TRUE WHERE key in (
{sql_reactivate}
);
-- Delete all new valid players --
DELETE FROM rules_rule_valid_players rp
USING (
    VALUES
        {sql_del_players}
) AS v(rule_key, display_name)
JOIN rules_rule r ON r.key = v.rule_key
JOIN players_player p ON p.display_name = v.display_name
WHERE rp.rule_id = r.id
  AND rp.player_id = p.id;
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
    readded_rules = set()
    updated_rules: dict = new_rules["evo"]
    update_sql = "UPDATE rules_rule SET {changes} WHERE key={old_key};"
    updates = []
    downdates = []
    for k,v in updated_rules.items():
        key_to_be = k if "key" not in v else v["key"]
        updating_fields = {a:b for a,b in v.items() if a not in ["exclusive_crosses", "valid_players", "active"]}
        if len(updating_fields) > 0:
            set_sql = ["{field}={value}".format(field=k, value=get_parse_func(k)(v)) for k,v in updating_fields.items()]
            unset_sql = ["{field}={value}".format(field=a, value=get_parse_func(a)(old_rules[k][a])) for a,_ in updating_fields.items()]
            updates.append(update_sql.format(
                changes=', '.join(set_sql), old_key=parse_varchar(k)
            ))
            downdates.append(update_sql.format(
                changes=', '.join(unset_sql), old_key=parse_varchar(key_to_be)
            ))
        if "valid_players" in v:
            valid_players[key_to_be] = v["valid_players"]
        if "active" in v:
            readded_rules.add(key_to_be)
    sql_updates = "\n".join(updates)
    sql_downdates = "\n".join(downdates)
    ## Prepare valid players
    player_insertion_sql = "({player_name}, {rule_key})"
    player_deletion_sql = "({rule_key}, {player_name})"
    new_players = []
    del_players = []
    for k,v in valid_players.items():
        for n in v:
            new_players.append(player_insertion_sql.format(player_name=parse_varchar(n), rule_key=parse_varchar(k)))
            del_players.append(player_deletion_sql.format(player_name=parse_varchar(n), rule_key=parse_varchar(k)))
    sql_alt_names = ",\n".join(new_players)
    sql_del_names = ",\n".join(del_players)
    ## Prepare deactivations
    removed_rules = ""
    if "rem" in new_rules:
        removed_rules = ",\n".join([parse_varchar(k) for k in new_rules["rem"]])
    readd_rules = ",\n".join([parse_varchar(k) for k in readded_rules])
    
    return (migrate_sql.format(sql_adds=sql_adds, sql_updates=sql_updates, sql_alt_names=sql_alt_names,
    date=parse_varchar(datetime.now().strftime("%Y-%m-%d")), sql_deactivate=removed_rules, sql_reactivate=readd_rules),
        restore_sql.format(sql_removes=sql_removes, sql_downdates=sql_downdates,
        sql_alt_names=sql_del_names, sql_del_players=sql_del_names, sql_reactivate=removed_rules, sql_deactivate=readd_rules))

def generate_update_sql():
    ## Read in existing files
    time_path = datetime.strftime(datetime.now()-timedelta(days=0), "%Y-%m-%d")
    # Load old data
    (old_teams, old_players, old_team_rules, old_teammates_rules, old_roles_rules, old_finalists_rules,
        old_worlds_participants_rules, old_countries_rules, old_champion_rules, old_pentakill_rules, old_winner_rules) = load_most_recent_data(1)
    old_rules = old_team_rules | old_teammates_rules | old_roles_rules | old_finalists_rules | old_worlds_participants_rules | old_countries_rules | old_champion_rules | old_pentakill_rules | old_winner_rules
    ## Read in update files
    with open(f"data/{time_path}/cooked/players.json", "r+", encoding='utf-8') as f:
        new_players = json.load(f)
    with open(f"data/{time_path}/cooked/teams.json", "r+", encoding='utf-8') as f:
        new_teams = json.load(f)
    with open(f"data/{time_path}/rules/teams.json", "r+", encoding='utf-8') as f:
        rules_teams = json.load(f)
    with open(f"data/{time_path}/rules/teammates.json", "r+", encoding='utf-8') as f:
        rules_teammates = json.load(f)
    with open(f"data/{time_path}/rules/roles.json", "r+", encoding='utf-8') as f:
        rules_roles = json.load(f)
    with open(f"data/{time_path}/rules/countries.json", "r+", encoding='utf-8') as f:
        rules_countries = json.load(f)
    with open(f"data/{time_path}/rules/finalists.json", "r+", encoding='utf-8') as f:
        rules_finalists = json.load(f)
    with open(f"data/{time_path}/rules/worlds_participants.json", "r+", encoding='utf-8') as f:
        rules_worlds_participants = json.load(f)
    with open(f"data/{time_path}/rules/champion_counts.json", "r+", encoding='utf-8') as f:
        rules_champions = json.load(f)
    with open(f"data/{time_path}/rules/pentakills.json", "r+", encoding='utf-8') as f:
        rules_pentakills = json.load(f)
    with open(f"data/{time_path}/rules/winners.json", "r+", encoding='utf-8') as f:
        rules_league_winners = json.load(f)
    
    new_rules = {
        "add": rules_teams["add"] | rules_teammates["add"] | rules_roles["add"] |rules_countries["add"] |
            rules_finalists["add"] | rules_worlds_participants["add"] | rules_champions["add"] | rules_pentakills["add"] | rules_league_winners["add"],
        "evo": rules_teams["evo"] | rules_teammates["evo"] | rules_roles["evo"] | rules_countries["evo"] |
            rules_finalists["evo"] | rules_worlds_participants["evo"] | rules_champions["evo"] | rules_pentakills["evo"] | rules_league_winners["evo"],
        "rem": rules_teams["rem"] + rules_teammates["rem"] + rules_roles["rem"] + rules_countries["rem"] + rules_finalists["rem"] +
            rules_worlds_participants["rem"] + rules_champions["rem"] + rules_pentakills["rem"] + rules_league_winners["rem"], 
        }
    
    os.makedirs(f"data/{time_path}/scripts", exist_ok=True)
    ## Players
    # players_sql, players_sql_undo = generate_players_sql(old_players, new_players)
    plr_sql, plr_sql_rem = generate_players_sql_new(new_players, old_players)

    with open(f"data/{time_path}/scripts/update_players.sql", 'w+', encoding='utf-8') as f:
        f.write(plr_sql)
    with open(f"data/{time_path}/scripts/update_players_restore.sql", 'w+', encoding='utf-8') as f:
        f.write(plr_sql_rem)
    ## Teams
    teams_sql, teams_sql_undo = generate_teams_sql_new(new_teams, old_teams)
    with open(f"data/{time_path}/scripts/update_teams.sql", 'w+', encoding='utf-8') as f:
        f.write(teams_sql)
    with open(f"data/{time_path}/scripts/update_teams_restore.sql", 'w+', encoding='utf-8') as f:
        f.write(teams_sql_undo)
    ## Rules
    rules_sql, rules_sql_undo = generate_rules_sql(new_rules, old_rules)
    with open(f"data/{time_path}/scripts/update_rules.sql", 'w+', encoding='utf-8') as f:
        f.write(rules_sql)
    with open(f"data/{time_path}/scripts/update_rules_restore.sql", 'w+', encoding='utf-8') as f:
        f.write(rules_sql_undo)
    
    