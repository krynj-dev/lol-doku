import json

player_set = None
team_set = None
raw_roster_data = None

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
        teams_to_add = [k for k in team_set.keys() if team_name == k or team_name in team_set[k]["other_names"] or team_name in team_set[k]["sister_teams"]]
        print(teams_to_add)