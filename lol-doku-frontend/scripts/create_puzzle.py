import json, os, random
from create_puzzle_util import rate_difficulty, read_rule

os.makedirs("puzzles", exist_ok=True)

rules = None
team_info = None

with open('cooked/rules.json', 'r+', encoding='utf-8') as f:
    rules = json.load(f)
with open('cooked/teams.json', 'r+', encoding='utf-8') as f:
    team_info = json.load(f)

if rules is None or team_info is None:
    quit()

    # # Count number of perfect squares
    # perfect_players = set()
    # for c in column_set:
    #     for r in row_set:
    #         options = set(rules[c]["Primary"][r]).difference(perfect_players)
    #         if len(options) == 1:
    #             perfect_players.add(list(options)[0])
    # difficulty_score += 5 * len(perfect_players)
    # return difficulty_score

def is_solvable(candidate: str, into_set: set, cross_set: set, include_secondary: bool):
    perfect_players = set()
    cand_set = into_set | {candidate}
    for c in cand_set:
        for r in cross_set:
            options = get_links(rules, c, r, include_secondary).difference(perfect_players)
            if len(options) == 0:
                return False
            elif len(options) == 1:
                perfect_players.add(list(options)[0])
    return True

def create_puzzle_object(row_set: set, column_set: set):
    return {
        "meta": {
            # "regions": region_counts,
            "difficulty": rate_difficulty(row_set, column_set)
        },
        "rows": list(row_set),
        "columns": list(column_set)
    }

def get_links(rules_set, key_a, key_b, include_secondary: bool):
    rule_one = rules_set[key_a]
    rule_two = rules_set[key_b]
    common_players = set(rule_one["valid_players"]["Primary"]).intersection(set(rule_two["valid_players"]["Primary"]))
    if include_secondary:
        common_players |= set(rule_one["valid_players"]["Primary"]).intersection(set(rule_two["valid_players"]["Secondary"]))
        common_players |= set(rule_one["valid_players"]["Secondary"]).intersection(set(rule_two["valid_players"]["Primary"]))
        common_players |= set(rule_one["valid_players"]["Secondary"]).intersection(set(rule_two["valid_players"]["Secondary"]))
    return common_players

def get_valid_options(into_set: set, cross_set: set, exclusions: set, include_secondary: bool):
    key_set = set(rules.keys())
    # Filter out existing teams
    key_set = set(filter(lambda x: x not in into_set and x not in cross_set, key_set))
    # Filter out teams with fewer than 3 primary links
    key_set = set(
        filter(
            lambda x: (
                len(rules[x]["valid_crosses"]["Primary"]) >= 3, 
        len(set(rules[x]["valid_crosses"]["Primary"]) | set(rules[x]["valid_crosses"]["Secondary"])) >= 3
        )[include_secondary], key_set
        )
        )
    # Filter out exclusions
    key_set = set(filter(lambda x: x not in exclusions, key_set))
    # Filter so only teams remaining in the cross set are pickable
    for cross_key in cross_set:
        key_set = set(
            filter(
                lambda x: x in (rules[cross_key]["valid_crosses"]["Primary"],
            rules[cross_key]["valid_crosses"]["Primary"] + rules[cross_key]["valid_crosses"]["Secondary"]
            )[include_secondary], key_set
            )
            )
    # Filter invalid additions
    key_set = set(filter(lambda x: is_solvable(x, into_set, cross_set, include_secondary), key_set))
    if len(key_set) == 0:
        return None
    candidate_key = random.choice(list(key_set))
    return candidate_key


def create_puzzle(include_secondary: bool):
    rows = set()
    columns = set()

    row_stack = []
    column_stack = []
    row_exclude = set()
    column_exclude = set()

    i = 0
    while len(rows) < 3 or len(columns) < 3:
        cc = None
        if (i == 0 and len(columns) < 3) or (i == 1 and len(rows) == 3):
            cc = get_valid_options(columns, rows, column_exclude, include_secondary)
            if cc is not None:
                # print("Add column {}".format(cc))
                columns.add(cc)
                column_stack.append(cc)
                i = 1
            elif len(row_stack) > 0:
                row_to_remove = row_stack.pop()
                # print("Remove row {}".format(row_to_remove))
                row_exclude.add(row_to_remove)
                rows.remove(row_to_remove)
                i = 0
            elif len(row_stack) == 0:
                column_to_remove = column_stack.pop()
                # print("Remove column {}".format(column_to_remove))
                column_exclude.add(column_to_remove)
                columns.remove(column_to_remove)
                i = 0
        elif (i == 1 and len(rows) < 3) or (i == 0 and len(columns) == 3):
            cc = get_valid_options(rows, columns, row_exclude, include_secondary)
            if cc is not None:
                # print("Add row {}".format(cc))
                rows.add(cc)
                row_stack.append(cc)
                i = 0
            elif len(column_stack) > 0:
                column_to_remove = column_stack.pop()
                # print("Remove column {}".format(column_to_remove))
                column_exclude.add(column_to_remove)
                columns.remove(column_to_remove)
                i = 1
            elif len(column_stack) == 0:
                row_to_remove = row_stack.pop()
                # print("Remove row {}".format(row_to_remove))
                row_exclude.add(row_to_remove)
                rows.remove(row_to_remove)
                i = 1
        if len(rows) == 0 and len(columns) == 0:
            row_exclude.clear()
            column_exclude.clear()

    return create_puzzle_object(rows, columns)


random.seed("hayden")
puzzles = []
while len(puzzles) < 500:
    print(f"\r{len(puzzles)}/500", sep=" ", end="", flush=True)
    p = create_puzzle(False)
    if p["meta"]["difficulty"] < 300 and p["meta"]["difficulty"] > 150:
        puzzles.append(p)

diff_list = sorted([p["meta"]["difficulty"] for p in puzzles])
print("Avg. Diff: {}\nMedian Diff: {}\nRange: [{}, {}]".format(sum(diff_list)/len(diff_list), diff_list[len(diff_list)//2], diff_list[0], diff_list[-1]))

with open('puzzles/puzzles.json', 'w+', encoding='utf-8') as f:
    json.dump(puzzles, f, ensure_ascii=False, indent=4)
