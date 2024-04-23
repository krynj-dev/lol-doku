import json

def read_rule(key):
    rule_set = None
    with open("cooked/rules/rules_{}.json".format(key.lower()[0]), encoding='utf-8') as f:
        rule_set = json.load(f)
    if rule_set is not None:
        return rule_set[key]
    return None

def read_team(key):
    team_set = None
    with open("cooked/teams.json", encoding='utf-8') as f:
        team_set = json.load(f)
    if team_set is not None:
        return team_set[key]
    return None

def read_player(key):
    player_set = None
    with open("cooked/players.json", encoding='utf-8') as f:
        player_set = json.load(f)
    if player_set is not None:
        return player_set[key]
    return None

def rate_difficulty(columns: set, rows: set):
    score = 0
    # Add penalty for rule types
    rule_type_cross_penalty_mult = [
        [1, 3, 4, 2],
        [1, 4, 3, 2],
        [1, 3, 4, 2],
        [2, 3, 4, 1]
    ]
    rule_type_penalty_mult = [2, 3, 4, 1]
    types_rows = [0, 0, 0, 0]
    types_columns = [0, 0, 0, 0]
    type_strings = ["team", "teammate", "champion", "role"]
    column_rules = [read_rule(c) for c in columns]
    row_rules = [read_rule(r) for r in rows]
    for cr in column_rules:
        types_columns[type_strings.index(cr["type"])] += 1
    for rr in row_rules:
        types_rows[type_strings.index(rr["type"])] += 1
    for i in range(len(types_rows)):
        score += sum([types_rows[i] * rule_type_cross_penalty_mult[i][j] * types_columns[j] for j in range(len(types_columns))])
    score += sum([rule_type_penalty_mult[i] * types_rows[i] for i in range(len(types_rows))])
    score += sum([rule_type_penalty_mult[i] * types_columns[i] for i in range(len(types_columns))])

    ## Add penalty for regions
    region_count = {}
    highest_level_count = {}
    for r in column_rules + row_rules:
        if r["type"] == "team":
            t = read_team(r["key"])
            if t is not None:
                reg = t["region"]
                if reg == "Europe":
                    reg = "EMEA"
                lvl = t["highest_level"]
                if reg not in region_count.keys():
                    region_count[reg] = 0
                if lvl not in highest_level_count.keys():
                    highest_level_count[lvl] = 0
                region_count[reg] += 1
                highest_level_count[lvl] += 1
        elif r["type"] == "teammate":
            p = read_player(r["key"])
            if p is not None:
                reg = p["residency"]
                if reg == "Europe":
                    reg = "EMEA"
                if reg not in region_count.keys():
                    region_count[reg] = 0
                region_count[reg] += 1
    
    for r in region_count.keys():
        if r in ["EMEA", "North America"]:
            score += 5 * region_count[r]
        elif r in ["Korea", "China"]:
            score += 10 * region_count[r]
        else:
            score += 20 * region_count[r]
    
    ## Add penalty for perfect squares
    perfect_players = set()
    for c in column_rules:
        for r in row_rules:
            options = set(c["valid_players"]["Primary"]).intersection(set(r["valid_players"]["Primary"])).difference(perfect_players)
            if len(options) == 1:
                perfect_players.add(list(options)[0])
            elif len(options) <= 5:
                score += 20
            elif len(options) <= 10:
                score += 10
            elif len(options) <= 15:
                score += 5
            elif len(options) > 30:
                score -= 20
    score += 2 ** len(perfect_players)
    
    return score