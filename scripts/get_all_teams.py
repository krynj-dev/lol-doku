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
        tables="TeamRenames=TR",
        fields="TR.OriginalName, TR.NewName, TR.Verb, TR.Date",
        offset=offset_renames,
        order_by="TR.Date ASC",
        limit=500
    )
    if len(response) == 0:
        break
    res_renames += response
    offset_renames += 500
    print("Sleeping 0.5s")
    time.sleep(0.5)

##########################################
# Collecting Team Data
##########################################
    
res_rosters = []
offset_rosters = 0

today = dt.date.today()

while True:
    response = site.cargo_client.query(
        tables="TournamentRosters=TR, Tournaments=T",
        join_on="TR.OverviewPage=T.OverviewPage",
        fields="T.Name, TR.Team, TR.RosterLinks, T.League, T.Region, TR.Roles, T.Date",
        where="T.Region IN ('Europe', 'EMEA', 'North America', 'Korea') AND T.TournamentLevel='Primary' AND T.Date < '{}'".format(today),
        order_by="T.Date ASC",
        offset=offset_rosters,
        limit=500
    )
    if len(response) == 0:
        break
    res_rosters += response
    offset_rosters += 500
    time.sleep(0.5)

team_chains = []
seen = []

i_rename = 0
i_team = 0
while i_team < len(res_rosters):
    team = res_rosters[i_team]
    rename = None
    if i_rename < len(res_renames):
        rename = res_renames[i_rename]
    if team["Date"] is None or team["RosterLinks"] is None or team["Roles"] is None or i_team in seen:
        pass
    elif rename is None or team["Date"] < rename["Date"]: # If next to handle is a roster
        i_chain = next((i for i, v in enumerate(team_chains) if team["Team"] == v[-1]["Team"]), None)
        players = []
        for plr, rl in zip(team["RosterLinks"].split(";;"),team["Roles"].split(";;")):
            if (rl in ['Top', 'Jungle', 'Mid', 'Bot', 'Support']):
                players.append(plr)
        if i_chain is None:
            team_chains.append([{
                "Team": team["Team"],
                "Players": players,
                "Date": team["Date"].split("-")[0]
            }])
        else:
            j_team = next((i for i, v in enumerate(team_chains[i_chain]) if team["Team"] == v["Team"]), None)
            for plr in players:
                if j_team is not None and plr.lower() not in [s.lower() for s in team_chains[i_chain][j_team]["Players"]]:
                    team_chains[i_chain][j_team]["Players"].append(plr)
    else: # If next to handle is a rename
        i_chain = next((i for i, v in enumerate(team_chains) if rename["OriginalName"] == v[-1]["Team"]), None)
        j_chain = next((i for i, v in enumerate(team_chains) if rename["NewName"] == v[-1]["Team"]), None)
        players = []        
        if i_chain is not None: # Regular rename
            j_team = i_team + 1 # Starting with next roster in list
            while j_team < len(res_rosters):
                if res_rosters[j_team]["Date"] is not None and res_rosters[j_team]["Team"] == rename["NewName"]: # Find first roster under new name
                    for plr, rl in zip(res_rosters[j_team]["RosterLinks"].split(";;"), res_rosters[j_team]["Roles"].split(";;")):
                        if (rl in ['Top', 'Jungle', 'Mid', 'Bot', 'Support']): # Collect the players from the first new roster
                            players.append(plr) 
                    team_chains[i_chain].append({
                            "Team": res_rosters[j_team]["Team"],
                            "Players": players,
                            "Date": res_rosters[j_team]["Date"].split("-")[0]
                        }) # Add roster to the chain
                    seen.append(j_team) # Add to seen list to avoid duplicates
                    break # End loop
                j_team += 1
            if j_chain is not None: # Rename is changing to existing team name (e.g. NiP ... FNCA->NiP)
                team_chains[j_chain] += team_chains[i_chain]
                del(team_chains[i_chain])
        i_rename += 1
        continue
    i_team += 1

with codecs.open('teams.json', 'w+', 'utf-8') as f:
    # f.writelines('\n'.join([', '.join([team["Team"] for team in chain]) + ": " + ' | '.join([', '.join(team["Players"]) for team in chain]) for chain in team_chains]))
    json_obj = {
        "chains": []
    }
    for chain in team_chains:
        uniq_players = []
        for team in chain:
            for plr in team["Players"]:
                if plr.lower() not in [s.lower() for s in uniq_players]:
                    uniq_players.append(plr)
        json_obj["chains"].append({
            "team_names": [team["Team"] for team in chain],
            "players": uniq_players,
            "team_dates": [team["Date"] for team in chain]
        })
    json.dump(json_obj, f, ensure_ascii=False, indent=4)
        
        
