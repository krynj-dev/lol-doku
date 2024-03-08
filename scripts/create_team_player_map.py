import json

player_set = None
team_set = None
raw_roster_data = None

def get_team_key(team_dict, term):
    return next((k for i, k in enumerate(team_dict) if term.lower() == team_dict[k]["op"].lower() or term.lower() == team_dict[k]["name"].lower()), None)

with open('cooked/teams.json', 'r+', encoding='utf-8') as f:
    team_set = json.load(f)
with open('cooked/players.json', 'r+', encoding='utf-8') as f:
    player_set = json.load(f)
with open('raw/team_rosters.json', 'r+', encoding='utf-8') as f:
    raw_roster_data = json.load(f)

team_to_player = {}

if player_set is not None and team_set is not None:
    # preload teams
    for k in team_set.keys():
        team_to_player[k] = []
    
    for raw_roster in raw_roster_data[:50]:
        team_name = raw_roster["Team"]
        teams_to_add = [k for k in team_set.keys() if team_name in team_set[k]["other_names"]]
        print(teams_to_add)