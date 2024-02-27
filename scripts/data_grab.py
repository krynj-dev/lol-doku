from mwrogue.esports_client import EsportsClient
site = EsportsClient("lol")

response = site.cargo_client.query(
    tables="TournamentRosters=TR, Tournaments=T",
    join_on="TR.OverviewPage=T.OverviewPage",
    fields="T.Name, TR.Team, TR.RosterLinks, T.League, T.Region, TR.Roles",
    where="T.Region='Europe' AND T.TournamentLevel='Primary'",
    offset=0,
    limit=500
)

print(response)

player_dict = {}

for team in response:
    # print("{}: {}".format(team["Name"], team["Team"]))   
    if team["RosterLinks"] is not None:
        for plr, rl in zip(team["RosterLinks"].split(";;"),team["Roles"].split(";;")):
            if (rl in ['Top', 'Jungle', 'Mid', 'Bot', 'Support']):
                # print("\t{} - {}".format(plr, rl))
                if plr not in player_dict:
                    player_dict[plr] = {
                        "Tournaments": [team["Name"]],
                        "Teams": [team["Team"]]
                    }
                else:
                    player_dict[plr]["Tournaments"].append(team["Name"])
                    player_dict[plr]["Teams"].append(team["Team"])


for name in list(player_dict.keys())[:10]:
    print("{}:\n\t".format(name) + "\n\t".join(["{}|{}".format(a, b) for a, b in zip(player_dict[name]["Tournaments"], player_dict[name]["Teams"])]))