import json
from shared.util import write_to_json_file

def populate_crosses(type_dicts: list):
    all_together = {}
    # Combine
    for dictt in type_dicts:
        all_together.update(dictt)

    key_no = 0
    for key_cur in list(all_together.keys()):
        key_no += 1
        print(f"\rRule {key_no}/{len(all_together.keys())}", sep=' ', end='', flush=True)
        for key_other in list(all_together.keys()):
            if key_cur == key_other:
                continue
            crossed_players = set(all_together[key_cur]["valid_players"]).intersection(set(all_together[key_other]["valid_players"]))
            
            if len(crossed_players) > 0:
                # print(key_cur, key_other, crossed_players)
                if "valid_crosses" not in all_together[key_cur].keys():
                    all_together[key_cur]["valid_crosses"] = set()
                all_together[key_cur]["valid_crosses"].add(key_other)
                if "valid_crosses" not in all_together[key_other].keys():
                    all_together[key_other]["valid_crosses"] = set()
                all_together[key_other]["valid_crosses"].add(key_cur)
    
    all_loc = write_to_json_file("data/rules", "all", all_together, format=False)
    with open(all_loc, 'r+', encoding='utf-8') as f:
        saved_obj = json.load(f)
    return saved_obj
