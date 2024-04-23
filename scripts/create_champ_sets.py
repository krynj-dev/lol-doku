import html, json

from mwrogue.esports_client import EsportsClient

site = EsportsClient("lol")

champs = site.cargo_client.query(
        tables="Champions=C",
        fields="C.Name",
    )

player_champs = {}

for champ in [html.unescape(c["Name"]) for c in champs]:
    if champ == "Nunu & Willump":
        champ = "Nunu"
    data = None
    with open(f'raw/champs/champ_players_{champ.lower()}.json', 'r+', encoding='utf-8') as f:
        data = json.load(f)
    for datum in data:
        op = datum["OverviewPage"]
        champion = datum["Champion"]
        tlevel = datum["TournamentLevel"]
        games = int(datum["GameCount"])
        name_link = datum["Link"]
        key = op
        if op == "":
            key = name_link
        if key not in player_champs.keys():
            player_champs[key] = {
                "Primary": {},
                "Secondary": {}
            }
        if champion not in player_champs[key][tlevel].keys():
            player_champs[key][tlevel][champion] = games
        else:
            player_champs[key][tlevel][champion] += games

champ_to_player = {
    "Any": {
        "Primary": {
            "100+": set(),
            "75+": set(),
            "50+": set(),
            "25+": set()
        },
        "Secondary": {
            "100+": set(),
            "75+": set(),
            "50+": set(),
            "25+": set()
        }
    }
}
for player in player_champs.keys():
    for champ in player_champs[player]["Primary"].keys():
        if champ not in champ_to_player.keys():
            champ_to_player[champ] = {
                "Primary": {
                    "100+": set(),
                    "75+": set(),
                    "50+": set(),
                    "25+": set()
                },
                "Secondary": {
                    "100+": set(),
                    "75+": set(),
                    "50+": set(),
                    "25+": set()
                }
            }
        if player_champs[player]["Primary"][champ] >= 25:
            champ_to_player[champ]["Primary"]["25+"] |= {player}
            champ_to_player["Any"]["Primary"]["25+"] |= {player}
        if player_champs[player]["Primary"][champ] >= 50:
            champ_to_player[champ]["Primary"]["50+"] |= {player}
            champ_to_player["Any"]["Primary"]["50+"] |= {player}
        if player_champs[player]["Primary"][champ] >= 75:
            champ_to_player[champ]["Primary"]["75+"] |= {player}
            champ_to_player["Any"]["Primary"]["75+"] |= {player}
        if player_champs[player]["Primary"][champ] >= 100:
            champ_to_player[champ]["Primary"]["100+"] |= {player}
            champ_to_player["Any"]["Primary"]["100+"] |= {player}
    for champ in player_champs[player]["Secondary"].keys():
        if champ not in champ_to_player.keys():
            champ_to_player[champ] = {
                "Primary": {
                    "100+": set(),
                    "75+": set(),
                    "50+": set(),
                    "25+": set()
                },
                "Secondary": {
                    "100+": set(),
                    "75+": set(),
                    "50+": set(),
                    "25+": set()
                }
            }
        if (
            champ in player_champs[player]["Primary"].keys() and player_champs[player]["Primary"][champ] + player_champs[player]["Secondary"][champ] >= 25
            ) or (
            player_champs[player]["Secondary"][champ] >= 25
            ):
            champ_to_player[champ]["Secondary"]["25+"] |= {player}
            champ_to_player["Any"]["Secondary"]["25+"] |= {player}
        if (
            champ in player_champs[player]["Primary"].keys() and player_champs[player]["Primary"][champ] + player_champs[player]["Secondary"][champ] >= 50
            ) or (
            player_champs[player]["Secondary"][champ] >= 50
            ):
            champ_to_player[champ]["Secondary"]["50+"] |= {player}
            champ_to_player["Any"]["Secondary"]["50+"] |= {player}
        if (
            champ in player_champs[player]["Primary"].keys() and player_champs[player]["Primary"][champ] + player_champs[player]["Secondary"][champ] >= 75
            ) or (
            player_champs[player]["Secondary"][champ] >= 75
            ):
            champ_to_player[champ]["Secondary"]["75+"] |= {player}
            champ_to_player["Any"]["Secondary"]["75+"] |= {player}
        if (
            champ in player_champs[player]["Primary"].keys() and player_champs[player]["Primary"][champ] + player_champs[player]["Secondary"][champ] >= 100
            ) or (
            player_champs[player]["Secondary"][champ] >= 100
            ):
            champ_to_player[champ]["Secondary"]["100+"] |= {player}
            champ_to_player["Any"]["Secondary"]["100+"] |= {player}

empties = []
for champ in champ_to_player.keys():
    is_empty = True
    for level in champ_to_player[champ].keys():
        empty_counts = []
        for threshold in champ_to_player[champ][level].keys():
            if len(champ_to_player[champ][level][threshold]) > 0:
                is_empty = False
            else:
                empty_counts.append(threshold)
        for t in empty_counts:
            del(champ_to_player[champ][level][t])
    if is_empty:
        empties.append(champ)

for c in empties:
    del(champ_to_player[c])

with open('cooked/pcm.json', 'w+', encoding='utf-8') as f:
    json.dump(champ_to_player, f, ensure_ascii=False, indent=4, default=lambda o: list(o))
    
    