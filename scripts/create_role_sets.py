import time, codecs, datetime as dt, json, os
from functools import cmp_to_key

os.makedirs("cooked", exist_ok=True)
os.makedirs("cooked/logs", exist_ok=True)

def get_team_key(team_dict, term):
    return next((k for i, k in enumerate(team_dict) if term.lower() == team_dict[k]["op"].lower() or term.lower() == team_dict[k]["name"].lower()), None)

_tpm = None

with open('cooked/tpm_reduced.json', 'r+', encoding='utf-8') as f:
    _tpm = json.load(f)

if _tpm is None:
    quit()

player_roles = {
    "Top": {},
    "Jungle": {},
    "Mid": {},
    "Bot": {},
    "Support": {}
}

for k in _tpm.keys():
    for l in _tpm[k].keys():
        for r in _tpm[k][l]:
            if r in ["Top", "Jungle", "Mid", "Bot", "Support"]:
                if l not in player_roles[r].keys():
                    player_roles[r][l] = set()
                player_roles[r][l] |= set(_tpm[k][l][r])

trm = {
    "Top": {},
    "Jungle": {},
    "Mid": {},
    "Bot": {},
    "Support": {}
}
    
with open('cooked/roles.json', 'w+', encoding='utf-8') as f:
    json.dump(player_roles, f, ensure_ascii=False, indent=4, default=lambda o: list(o))
with open('cooked/trm.json', 'w+', encoding='utf-8') as f:
    json.dump(trm, f, ensure_ascii=False, indent=4, default=lambda o: list(o))

print("Done!")
