import time, codecs, datetime as dt, json, os

from mwrogue.esports_client import EsportsClient

def none_to_blank(str):
    if str is None:
        return ''
    return str

def write_to_json_file(file_name, responses, list_delimiter=','):
    print("\nWriting to /raw/{}.json...".format(file_name))
    res_copy = []
    for obj in responses:
        obj_copy = {}
        for key in obj:
            val = none_to_blank(obj[key])
            if list_delimiter in val:
                obj_copy[key] = val.split(list_delimiter)
            else:
                obj_copy[key] = val
        res_copy.append(obj_copy)
    with open('raw/{}.json'.format(file_name), 'w+', encoding='utf-8') as f:
        json.dump(res_copy, f, ensure_ascii=False, indent=4)


site = EsportsClient("lol")

os.makedirs("raw", exist_ok=True)

##########################################
# Collecting Player Data
##########################################

# responses_players = []
# offset_players = 0
# while True:
#     response = site.cargo_client.query(
#         tables="Players=P, PlayerRedirects=PR",
#         join_on="P.OverviewPage=PR.OverviewPage",
#         fields="PR.AllName, PR.ID, PR.OverviewPage, P.Name, P.Country, P.Age, P.Residency",
#         offset=offset_players,
#         limit=500
#     )
#     if len(response) == 0:
#         break
#     responses_players += response
#     offset_players += 500
#     print("\rPage {}".format(offset_players // 500), sep=' ', end='', flush=True)
#     time.sleep(0.1)

# write_to_json_file('players', responses_players, list_delimiter='\n')

# ##########################################
# # Collecting Sister Team Data
# ##########################################

# responses_sister = []
# offset_sister = 0
# while True:
#     response = site.cargo_client.query(
#         tables="SisterTeams=S",
#         fields="S.Team, S.AllTeams",
#         offset=offset_sister,
#         limit=500
#     )
#     if len(response) == 0:
#         break
#     responses_sister += response
#     offset_sister += 500
#     print("\rPage {}".format(offset_sister // 500), sep=' ', end='', flush=True)
#     time.sleep(0.1)

# write_to_json_file('sister_teams', responses_sister)

# ##########################################
# # Collecting Team Data
# ##########################################

# responses_teams = []
# offset_teams = 0
# while True:
#     response = site.cargo_client.query(
#         tables="Teams=T",
#         fields="T.Name, T.OverviewPage, T.Short, T.Region, T.Image, T.RenamedTo",
#         offset=offset_teams,
#         limit=500
#     )
#     if len(response) == 0:
#         break
#     responses_teams += response
#     offset_teams += 500
#     print("\rPage {}".format(offset_teams // 500), sep=' ', end='', flush=True)
#     time.sleep(0.1)

# write_to_json_file('teams', responses_teams, "\n")

# ##########################################
# # Collecting Team Rename Data
# ##########################################

# responses_team_renames = []
# offset_team_renames = 0
# while True:
#     response = site.cargo_client.query(
#         tables="TeamRenames=T",
#         fields="T.Date, T.OriginalName, T.NewName, T.Verb, T.Slot, T.IsSamePage",
#         offset=offset_team_renames,
#         limit=500
#     )
#     if len(response) == 0:
#         break
#     responses_team_renames += response
#     offset_team_renames += 500
#     print("\rPage {}".format(offset_team_renames // 500), sep=' ', end='', flush=True)
#     time.sleep(0.1)

# write_to_json_file('team_renames', responses_team_renames)

# ##########################################
# # Collecting Team Redirect Data
# ##########################################

responses_team_redirects = []
offset_team_redirects = 0
while True:
    response = site.cargo_client.query(
        tables="TeamRedirects=TR",
        fields="TR._pageName=PageName, TR.AllName",
        offset=offset_team_redirects,
        limit=500
    )
    if len(response) == 0:
        break
    responses_team_redirects += response
    offset_team_redirects += 500
    print("\rPage {}".format(offset_team_redirects // 500), sep=' ', end='', flush=True)
    time.sleep(0.1)

write_to_json_file('team_redirects', responses_team_redirects, list_delimiter='\n')

##########################################
# Collecting Tournament Player Data
##########################################

# responses_tournament_players = []
# offset_tournament_players = 0
# while True:
#     response = site.cargo_client.query(
#         tables="TournamentPlayers=T, Tournaments=TA",
#         join_on="T.OverviewPage,TA.OverviewPage",
#         fields="T.Team, T.Link, T.Player, T.Role, T.Flag, T.OverviewPage",
#         offset=offset_tournament_players,
#         limit=500
#     )
#     if len(response) == 0:
#         break
#     responses_tournament_players += response
#     offset_tournament_players += 500
#     print("\rPage {}".format(offset_tournament_players // 500), sep=' ', end='', flush=True)
#     time.sleep(0.1)

# write_to_json_file('tournament_players', responses_tournament_players)

##########################################
# Collecting Tournament Roster Data
##########################################

# responses_rosters = []
# offset_rosters = 0
# while True:
#     response = site.cargo_client.query(
#         tables="TournamentRosters=TR, Tournaments=T",
#         join_on="TR.OverviewPage=T.OverviewPage",
#         fields="TR.OverviewPage, TR.Team, TR.Region, TR.RosterLinks, TR.Roles, TR.Flags, T.TournamentLevel, T.Date",
#         offset=offset_rosters,
#         limit=500
#     )
#     if len(response) == 0:
#         break
#     responses_rosters += response
#     offset_rosters += 500
#     print("\rPage {}".format(offset_rosters // 500), sep=' ', end='', flush=True)
#     time.sleep(0.1)

# write_to_json_file('team_rosters', responses_rosters, ";;")

##########################################
# Collecting Tournament Data
##########################################

# responses_tournaments = []
# offset_tournaments = 0
# while True:
#     response = site.cargo_client.query(
#         tables="Tournaments=T",
#         fields="T.OverviewPage, T.Name, T.DateStart, T.Date, T.League, T.Region, T.Organizer, T.Organizers, T.StandardName, T.Split, T.SplitNumber, T.SplitMainPage, T.TournamentLevel, T.IsQualifier, T.IsPlayoffs, T.IsOfficial, T.Year",
#         offset=offset_tournaments,
#         limit=500
#     )
#     if len(response) == 0:
#         break
#     responses_tournaments += response
#     offset_tournaments += 500
#     print("\rPage {}".format(offset_tournaments // 500), sep=' ', end='', flush=True)
#     time.sleep(0.1)

# write_to_json_file('tournaments', responses_tournaments)
