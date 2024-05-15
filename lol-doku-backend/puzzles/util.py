from rules.models import Rule, ValidCrosses
from teams.models import Team
from players.models import Player
from django.db.models import Count, F
from rules.serializers import RuleSerializer
from numpy import random
import time

def read_rule(key):
    qs = Rule.objects.all().filter(key=key)
    if len(qs) > 0:
        return qs.get()
    return None

def read_team(key):
    qs = Team.objects.all().filter(name=key)
    if len(qs) > 0:
        return qs.get()
    return None

def read_player(key):
    qs = Player.objects.all().filter(display_name=key)
    if len(qs) > 0:
        return qs.get()
    return None

def is_valid_guess(rule_1: Rule, rule_2: Rule, player: Player):
    options = set(rule_1.valid_players.all()).intersection(set(rule_2.valid_players.all()))
    return player in options

def rate_difficulty(columns: set, rows: set):
    return 0
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
    type_strings = ["team", "teammate", "champion", "role", "finalist", "tournament"]
    column_rules = [read_rule(c.key) for c in columns]
    row_rules = [read_rule(r.key) for r in rows]
    for cr in column_rules:
        types_columns[type_strings.index(cr.rule_type)] += 1
    for rr in row_rules:
        types_rows[type_strings.index(rr.rule_type)] += 1
    for i in range(len(types_rows)):
        score += sum([types_rows[i] * rule_type_cross_penalty_mult[i][j] * types_columns[j] for j in range(len(types_columns))])
    score += sum([rule_type_penalty_mult[i] * types_rows[i] for i in range(len(types_rows))])
    score += sum([rule_type_penalty_mult[i] * types_columns[i] for i in range(len(types_columns))])

    ## Add penalty for regions
    region_count = {}
    highest_level_count = {}
    for r in column_rules + row_rules:
        if r.rule_type == "team":
            t = read_team(r.key)
            if t is not None:
                reg = t.region
                if reg == "Europe":
                    reg = "EMEA"
                lvl = t.highest_level
                if reg not in region_count.keys():
                    region_count[reg] = 0
                if lvl not in highest_level_count.keys():
                    highest_level_count[lvl] = 0
                region_count[reg] += 1
                highest_level_count[lvl] += 1
        elif r.rule_type == "teammate":
            p = read_player(r.key)
            if p is not None:
                reg = p.residency
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
            cvp = set([x.display_name for x in c.valid_players.all()])
            rvp = set([x.display_name for x in r.valid_players.all()])
            options = cvp.intersection(rvp).difference(perfect_players)
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

def is_solvable(candidate: str, into_set: list, cross_set: list, min_answers: int = 1):
    perfect_players = set()
    cand_set = into_set + [candidate]
    for c in cand_set:
        for r in cross_set:
            options = get_links(c, r).difference(perfect_players)
            if len(options) < min_answers: # Change to 0 for 1+ answers okay
                return False
            elif len(options) == 1:
                perfect_players.add(list(options)[0])
    return True

def create_puzzle_object(row_set: set, column_set: set):
    rsk = [{
        "key": x.key,
        "type": x.rule_type
    } for x in row_set]
    csk = [{
        "key": x.key,
        "type": x.rule_type
    } for x in column_set]
    return {
        "meta": {
            # "regions": region_counts,
            "difficulty": rate_difficulty(row_set, column_set)
        },
        "rows": list(rsk),
        "columns": list(csk)
    }

def get_links(key_a, key_b):
    r1_prim = set([x.display_name for x in key_a.valid_players.all()])
    r2_prim = set([x.display_name for x in key_b.valid_players.all()])
    common_players = r1_prim.intersection(r2_prim)
    return common_players

def restrict_non_team_rules(key_set: set, into_set: list, cross_set: list):
    new_keys = key_set
    # Ensure at least 2 teams in every puzzle
    min_teams = 1
    comb = into_set + cross_set
    # Count types
    tc = 0
    for r in comb:
        if r.rule_type == "team":
            tc += 1
    if tc < min_teams and (min_teams - tc) == 6-len(comb):
        new_keys = set(filter(lambda r: r.rule_type == "team", new_keys))
    return new_keys

def restrict_non_worlds_rules(key_set: set, into_set: list, cross_set: list):
    new_keys = key_set
    # Ensure at least 1 world in every puzzle
    min_teams = 1
    comb = into_set + cross_set
    # Count types
    tc = 0
    for r in comb:
        if r.rule_type == "champion" or r.rule_type == "champion":
            tc += 1
    if tc < min_teams and (min_teams - tc) == 6-len(comb):
        new_keys = set(filter(lambda r: r.rule_type == "champion" or r.rule_type == "champion", new_keys))
    return new_keys

def restrict_teammate_team_cross(key_set: set, into_set: list, cross_set: list):
    new_keys = key_set
    for r in into_set:
        if r.rule_type == "team":
            new_keys = set(filter(lambda x: x.key not in [p.display_name for p in r.valid_players.all()], new_keys))
        elif r.rule_type == "teammate":
            try:
                team_membership = [x.key for x in Player.objects.get(display_name=r.key).valid_rules.all() if x.rule_type == "team"]
                new_keys = set(filter(lambda x: x.key not in team_membership, new_keys))
            except Player.DoesNotExist as e:
                print(f"Did not find player: {r.key}")
    return new_keys

def get_probability_dist(key_list):
    # Count types
    type_count = {}
    for r in key_list:
        rt = r.rule_type
        if rt not in type_count.keys():
            type_count[rt] = 1
        else:
            type_count[rt] += 1
    p = [1/len(key_list)]*len(key_list)
    type_weights = {
        "team": 1,
        "teammate": 5,
        "champion": 3,
        "role": 3,
    }
    for t in type_count.keys():
        cp = type_weights[t]/sum([type_weights[xt] for xt in type_weights.keys() if xt in type_count])
        m = (cp * len(key_list)) / type_count[t]
        for i in range(len(p)):
            if key_list[i].rule_type == t:
                p[i] *= m
    return p


def get_valid_options(rule_set, into_set: list, cross_set: list, exclusions: list, min_answers: int):
    key_set = set([r for r in rule_set])
    # Filter out existing teams
    key_set = set(filter(lambda x: x not in into_set and x not in cross_set, key_set))
    # Filter out exclusions
    key_set = set(filter(lambda x: x not in exclusions, key_set))
    # Filter so only teams remaining in the cross set are pickable
    for cross_key in cross_set:
        valid_crosses = [y.key for y in ValidCrosses.objects.get(rule=cross_key).crosses.all()]
        key_set = set(filter(lambda x: x.key in valid_crosses, key_set))   
    # Remove restricted types
    key_set = restrict_non_team_rules(key_set, into_set, cross_set)
    key_set = restrict_non_worlds_rules(key_set, into_set, cross_set)
    key_set = restrict_teammate_team_cross(key_set, into_set, cross_set)
    if len(key_set) == 0:
        return None
    key_list = list(key_set)
    # Shuffle then pick first valid rule
    random.shuffle(key_list)
    candidate_i = -1
    for j in range(len(key_list)):
        if is_solvable(key_list[j], into_set, cross_set, min_answers):
            candidate_i = j
            break
    if candidate_i == -1:
        return None
    candidate_key = key_list[candidate_i]
    return candidate_key


def create_puzzle(min_answers=1, allowed_regions=["EU", "EMEA", "", "World", "North America", "Korea", "China", "Europe", "PCS", "LMS", "Oceania", "OCE", "Turkey", "BR", "CIS", "Vietnam", "SEA", "APAC", "TR"]):
    # Read rules once from DB
    rule_set = [x for x in (Rule.objects.annotate(num_crosses=Count('valid_crosses')).filter(num_crosses__gte=3))]

    rows = []
    columns = []
    row_exclude = set()
    column_exclude = set()
    i = 0
    while len(rows) < 3 or len(columns) < 3:
        cc = None
        if (i == 0 and len(columns) < 3) or (i == 1 and len(rows) == 3):
            cc = get_valid_options(rule_set, columns, rows, column_exclude, min_answers)
            if cc is not None:
                columns.append(cc)
                i = 1
            elif len(rows) > 0:
                row_to_remove = rows.pop()
                row_exclude.add(row_to_remove)
                i = 0
            elif len(rows) == 0:
                column_to_remove = columns.pop()
                column_exclude.add(column_to_remove)
                i = 0
        elif (i == 1 and len(rows) < 3) or (i == 0 and len(columns) == 3):
            cc = get_valid_options(rule_set, rows, columns, row_exclude, min_answers)
            if cc is not None:
                rows.append(cc)
                i = 0
            elif len(columns) > 0:
                column_to_remove = columns.pop()
                column_exclude.add(column_to_remove)
                i = 1
            elif len(columns) == 0:
                row_to_remove = rows.pop()
                row_exclude.add(row_to_remove)
                i = 1
        if len(rows) == 0 and len(columns) == 0:
            row_exclude.clear()
            column_exclude.clear()
    return create_puzzle_object(rows, columns)
