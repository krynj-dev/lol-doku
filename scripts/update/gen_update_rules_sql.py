from collections import Counter

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

def generate_rules_sql(old_rules, new_rules):
    adds: dict = new_rules["add"]
    evos: dict = new_rules["evo"]

    valid_players = {k:v["valid_players"] for k,v in adds.items()}

    sql = ""
    undo_sql = ""
    ## Handle Adds
    sql += "INSERT INTO rules_rule (key, rule_type) VALUES\n"
    add_rules_sql = "({}, {})"
    add_rules_restore_sql = "DELETE FROM rules_rule WHERE key={};\n"
    adds_sql = []
    for k,v in adds.items():
        adds_sql.append(add_rules_sql.format(parse_varchar(k), parse_varchar(v["type"])))
        undo_sql = add_rules_restore_sql.format(parse_varchar(k)) + undo_sql
    sql += ",\n".join(adds_sql) + ";\n"
    ## Handle easy evos
    easy_evos = {k:v for k,v in evos.items() if k==v[0]}
    for k,v in easy_evos.items():
        valid_players[k] = v[1]["valid_players"]
    ## calc hardest evos
    count = Counter([v[0] for v in evos.values()])
    hard_evos = {k:v for k,v in evos.items() if k!=v[0] and count[v[0]] > 1 and v[0] not in old_rules}
    hardest_evos = {k:v for k,v in evos.items() if k!=v[0] and v[0] in old_rules}
    medium_evos = {k:v for k,v in evos.items() if k!=v[0] and count[v[0]] == 1 and v[0] not in old_rules and k not in hard_evos | hardest_evos}
    ## hard evos
    seen = {}
    for k,v in hard_evos.items():
        if v[0] not in seen: # upgrade this one
            medium_evos[k] = v
            seen[v[0]] = old_rules[k]
        else:
            nv = v
            nv[1]["regions"] = set(old_rules[k]["regions"]) - set(seen[v[0]]["regions"]) - set(v[1]["regions"])
            nv[1]["valid_players"] = set(old_rules[k]["valid_players"]) - set(seen[v[0]]["valid_players"]) - set(v[1]["valid_players"])
            hardest_evos[k] = nv
    ## medium evo
    medium_sql = "UPDATE rules_rule SET key={} WHERE key={};\n"
    for k,v in medium_evos.items():
        sql += medium_sql.format(parse_varchar(v[0]), parse_varchar(k))
        undo_sql = medium_sql.format(parse_varchar(k), parse_varchar(v[0])) + undo_sql
        valid_players[v[0]] = v[1]["valid_players"]
    
    ## hardest evos
    done = set()
    for k,v in hardest_evos.items():
        pass

    ## Add valid players
    valid_player_sql = "((SELECT id FROM players_player WHERE display_name={}), (SELECT id FROM rules_rule WHERE key={}))"
    valid_player_restore_sql = '''DELETE FROM rules_rule_valid_players WHERE 
    player_id=(SELECT id FROM players_player WHERE display_name={}) AND rule_id=(SELECT id FROM rules_rule WHERE key={});\n'''
    sql += "INSERT INTO rules_rule_valid_players (player_id, rule_id) VALUES\n"
    vps = []
    for k, vs in valid_players.items():
        for n in vs:
            vps.append(valid_player_sql.format(parse_varchar(n), parse_varchar(k)))
            undo_sql = valid_player_restore_sql.format(parse_varchar(n), parse_varchar(k)) + undo_sql
    sql += ",\n".join(vps) + ";\n"

    return sql, undo_sql
