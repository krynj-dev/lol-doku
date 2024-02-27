import time, codecs, datetime as dt, json

from mwrogue.esports_client import EsportsClient

site = EsportsClient("lol")

##########################################
# Collecting Rename Data
##########################################

responses = []
offset = 0
while True:
    print("Getting page {}".format(offset // 500 + 1))
    response = site.cargo_client.query(
        tables="TeamRenames=TR",
        fields="TR.OriginalName, TR.NewName, TR.Verb, TR.Date",
        offset=offset,
        order_by="TR.Date ASC",
        limit=500
    )
    if len(response) == 0:
        break
    responses += response
    offset += 500
    print("Sleeping 0.5s")
    time.sleep(0.5)

##########################################
# Collecting Team Data
##########################################
    
r2 = []
o2 = 0

today = dt.date.today()

while True:
    response = site.cargo_client.query(
        tables="TournamentRosters=TR, Tournaments=T",
        join_on="TR.OverviewPage=T.OverviewPage",
        fields="T.Name, TR.Team, TR.RosterLinks, T.League, T.Region, TR.Roles, T.Date",
        where="T.Region IN ('Europe', 'EMEA') AND T.TournamentLevel='Primary' AND T.Date < '{}'".format(today),
        order_by="T.Date ASC",
        offset=o2,
        limit=500
    )
    if len(response) == 0:
        break
    r2 += response
    o2 += 500
    time.sleep(0.5)

team_chains = []
seen = []

i_rename = 0
i_team = 0
while i_team < len(r2):
    team = r2[i_team]
    rename = None
    if i_rename < len(responses):
        rename = responses[i_rename]
    if team["Date"] is None or team["RosterLinks"] is None or team["Roles"] is None or i_team in seen:
        pass
    elif rename is None or team["Date"] < rename["Date"]:
        # Add team if not already present
        i_chain = next((i for i, v in enumerate(team_chains) if team["Team"] == v[-1]["Team"]), None)
        players = []
        for plr, rl in zip(team["RosterLinks"].split(";;"),team["Roles"].split(";;")):
            if (rl in ['Top', 'Jungle', 'Mid', 'Bot', 'Support']):
                players.append(plr)
        if i_chain is None:
            team_chains.append([{
                "Team": team["Team"],
                "Players": players
            }])
        else:
            j_team = next((i for i, v in enumerate(team_chains[i_chain]) if team["Team"] == v["Team"]), None)
            for plr in players:
                if j_team is not None and plr not in team_chains[i_chain][j_team]["Players"]:
                    team_chains[i_chain][j_team]["Players"].append(plr)
    else:
        i_chain = next((i for i, v in enumerate(team_chains) if rename["OriginalName"] == v[-1]["Team"]), None)
        if i_chain is not None:
            j_team = i_team + 1
            while j_team < len(r2):
                if r2[j_team]["Date"] is not None and r2[j_team]["Team"] == rename["NewName"]:
                    players = []
                    for plr, rl in zip(r2[j_team]["RosterLinks"].split(";;"),r2[j_team]["Roles"].split(";;")):
                        if (rl in ['Top', 'Jungle', 'Mid', 'Bot', 'Support']):
                            players.append(plr)
                    team_chains[i_chain].append({
                            "Team": r2[j_team]["Team"],
                            "Players": players
                        })
                    seen.append(j_team)
                    break
                j_team += 1
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
                if plr not in uniq_players:
                    uniq_players.append(plr)
        json_obj["chains"].append({
            "team_names": [team["Team"] for team in chain],
            "players": uniq_players
        })
    json.dump(json_obj, f, ensure_ascii=False, indent=4)
        
        
