import time, codecs, datetime as dt, json

from mwrogue.esports_client import EsportsClient

site = EsportsClient("lol")

##########################################
# Collecting Rename Data
##########################################

res_renames = []
offset_renames = 0
while True:
    print("Getting page {}".format(offset_renames // 500 + 1))
    response = site.cargo_client.query(
        tables="PlayerRenames=PR",
        fields="PR.OriginalName, PR.NewName, PR.Date, PR.IsRestyle",
        offset=offset_renames,
        limit=500
    )
    if len(response) == 0:
        break
    res_renames += response
    offset_renames += 500
    print("Sleeping 0.5s")
    time.sleep(0.5)

##########################################
# Collecting Player Data
##########################################
    
res_redirects = []
offset_redirects = 0

while True:
    response = site.cargo_client.query(
        tables="PlayerRedirects=PR",
        fields="PR.AllName, PR.ID, PR.OverviewPage",
        offset=offset_redirects,
        limit=500
    )
    if len(response) == 0:
        break
    res_redirects += response
    offset_redirects += 500
    time.sleep(0.1)

# with open('plr_redir.txt', 'w+', encoding='utf-8') as f:
#     f.writelines('\n'.join(["{}, {}, {}".format(x["AllName"], x["ID"], x["OverviewPage"]) for x in res_redirects]))

name_chains = []
teams = None
with open('teams.json', 'r+', encoding='utf-8') as f:
    teams = json.load(f)

worthy_players = []
if teams is not None:
    for chain in teams["chains"]:
        for player in chain["players"]:
            i_plr = next((i for i, v in enumerate(worthy_players) if player.lower() in [p.lower() for p in v]), None)
            if i_plr is None:
                worthy_players.append([player])

for redirect in res_redirects:
    i_oldname = next((i for i, v in enumerate(worthy_players) if redirect["AllName"].lower() in [n.lower() for n in v]), None)
    i_curname = next((i for i, v in enumerate(worthy_players) if redirect["OverviewPage"].lower() in [n.lower() for n in v]), None)
    if i_oldname is None and i_curname is None or i_oldname == i_curname: # Renames of players not worthy
        continue
    elif i_oldname is None: # name used pre-worthiness
        worthy_players[i_curname] = [redirect["AllName"]] + worthy_players[i_curname]
    elif i_curname is None: # name changed after no longer being worthy
        worthy_players[i_oldname] = worthy_players[i_oldname] + [redirect["OverviewPage"]]
    else: # Player changed names while being worthy
        worthy_players[i_oldname] = worthy_players[i_oldname] + worthy_players[i_curname]
        del(worthy_players[i_curname])
    

print('\n'.join([' -> '.join(x) for x in worthy_players]))

# with open('renames.txt', 'w+', encoding='utf-8') as f:
#     f.writelines('\n'.join(["{}: {} -> {}".format(x["Date"], x["OriginalName"], x["NewName"]) for x in res_renames]))

with codecs.open('players.json', 'w+', 'utf-8') as f:
    # f.writelines('\n'.join([', '.join([team["Team"] for team in chain]) + ": " + ' | '.join([', '.join(team["Players"]) for team in chain]) for chain in team_chains]))
    data = {}
    for player_names in worthy_players:
        data[player_names[-1]] = player_names
    json.dump(data, f, ensure_ascii=False, indent=4)
        
        
