## Imports ##
import json, os
from string import ascii_lowercase

## Constants ##
prio_order = ["Primary", "Secondary"]

## Function Definitions ##
def add_to_rules(rule_set: dict, rule_object):
    rule_set[rule_object["key"]] = rule_object
    for key in rule_set.keys():
        if key != rule_object["key"]:
            for i in range(len(prio_order)):
                if len(rule_set[rule_object["key"]]["valid_players"][prio_order[i]].intersection(rule_set[key]["valid_players"][prio_order[i]])) > 0:
                    rule_set[rule_object["key"]]["valid_crosses"][prio_order[i]].add(key)
                    rule_set[key]["valid_crosses"][prio_order[i]].add(rule_object["key"])
                for j in range(i):
                    if (len(rule_set[rule_object["key"]]["valid_players"][prio_order[i]].intersection(rule_set[key]["valid_players"][prio_order[j]])) > 0
                    ) or len(rule_set[rule_object["key"]]["valid_players"][prio_order[j]].intersection(rule_set[key]["valid_players"][prio_order[i]])) > 0:
                        rule_set[rule_object["key"]]["valid_crosses"][prio_order[i]].add(key)
                        rule_set[key]["valid_crosses"][prio_order[i]].add(rule_object["key"])
                rule_set[rule_object["key"]]["valid_crosses"][prio_order[i]] -= rule_set[rule_object["key"]]["exclusive_crosses"]
                rule_set[key]["valid_crosses"][prio_order[i]] -= rule_set[key]["exclusive_crosses"]


def create_rule_object(rule_key, o, rule_type):
    if rule_type in ["team", "teammate", "role"]:
        return [{
            "key": rule_key,
            "type": rule_type,
            "valid_players": {
                "Primary": set(o["Primary"]),
                "Secondary": set(o["Secondary"])
            },
            "valid_crosses": {
                "Primary": set(),
                "Secondary": set()
            },
            "exclusive_crosses": set()
        }]
    elif rule_type in ["champion"]:
        thresholds = set(o["Primary"].keys()) | set(o["Secondary"].keys())
        rulez = []
        for threshold in thresholds:
            pset = set()
            sset = set()
            if threshold in o["Primary"].keys():
                pset = set(o["Primary"][threshold])
            if threshold in o["Secondary"].keys():
                sset = set(o["Secondary"][threshold])
            rulez.append({
                "key": f"{rule_key} {threshold}",
                "type": rule_type,
                "valid_players": {
                    "Primary": pset,
                    "Secondary": sset
                },
                "valid_crosses": {
                    "Primary": set(),
                    "Secondary": set()
                },
                "exclusive_crosses": set([f"{rule_key} {tother}" for tother in thresholds if tother != threshold])
            })
        return rulez


## Rule Sources ##
team_rule_source = None
teammate_rule_source = None
role_rule_source = None
champion_rule_source = None

with open('cooked/tpm.json', 'r+', encoding='utf-8') as f:
    team_rule_source = json.load(f)
with open('cooked/ppm.json', 'r+', encoding='utf-8') as f:
    teammate_rule_source = json.load(f)
with open('cooked/rpm.json', 'r+', encoding='utf-8') as f:
    role_rule_source = json.load(f)
with open('cooked/pcm.json', 'r+', encoding='utf-8') as f:
    champion_rule_source = json.load(f)

## Create Team Rules ##
rules = {}
i = 1
if team_rule_source is not None:
    # Create rules
    for key in team_rule_source.keys():
        print("\r{}/{}".format(i, len(team_rule_source)), sep=' ', end='', flush=True)
        if key in rules.keys():
            print("huh?")
        rule_objects = create_rule_object(key, team_rule_source[key], "team")
        for r in rule_objects:
            add_to_rules(rules, r)
        i += 1
print("\nTeams Complete")
i = 1
if teammate_rule_source is not None:
    # Create rules
    for key in teammate_rule_source.keys():
        print("\r{}/{}".format(i, len(teammate_rule_source)), sep=' ', end='', flush=True)
        if key in rules.keys():
            print("huh?")
        rule_objects = create_rule_object(key, teammate_rule_source[key], "teammate")
        for r in rule_objects:
            add_to_rules(rules, r)
        i += 1
print("\nTeammates Complete")
i = 1
if role_rule_source is not None:
    # Create rules
    for key in role_rule_source.keys():
        print("\r{}/{}".format(i, len(role_rule_source)), sep=' ', end='', flush=True)
        if key in rules.keys():
            print("huh?")
        rule_objects = create_rule_object(key, role_rule_source[key], "role")
        for r in rule_objects:
            add_to_rules(rules, r)
        i += 1
print("\nRoles Complete")
i = 1
if champion_rule_source is not None:
    # Create rules
    for key in champion_rule_source.keys():
        print("\r{}/{}".format(i, len(champion_rule_source)), sep=' ', end='', flush=True)
        if key in rules.keys():
            print("huh?")
        rule_objects = create_rule_object(key, champion_rule_source[key], "champion")
        for r in rule_objects:
            add_to_rules(rules, r)
        i += 1
print("\nChampions Complete")


## Save Rules ##
type_letters = { }
seen = []
for cey in rules.keys():
    c = cey[0].lower()
    if rules[cey]["type"] not in type_letters.keys():
        type_letters[rules[cey]["type"]] = set()
    type_letters[rules[cey]["type"]].add(c)
    if c not in seen:
        smaller_rules = {}
        for k in rules.keys():
            if k.lower()[0] == c:
                smaller_rules[k] = rules[k]
            
        os.makedirs('cooked/rules', exist_ok=True)
            
        with open(f'cooked/rules/rules_{c}.json', 'w+', encoding='utf-8') as f:
            json.dump(smaller_rules, f, ensure_ascii=False, indent=4, default=lambda o: list(o))
        seen.append(c)

with open(f'cooked/rules/rule_type_letters.json', 'w+', encoding='utf-8') as f:
    json.dump(type_letters, f, ensure_ascii=False, indent=4, default=lambda o: list(o))