from raw import *
from cooked import cook_players_data
from images import retrieve_player_images, retrieve_team_images
from datetime import datetime

def fetch_player_images(site: EsportsClient, rosters):
    player_set = set()
    acceptable_roles = [ "Top", "Jungle", "Mid", "Bot", "Support" ]
    for roster in rosters:
        if roster["Roles"] is not None and roster["RosterLinks"]:
            if len(roster["Roles"]) != len(roster["RosterLinks"]):
                continue
            players = [roster["RosterLinks"][i] for i in range(len(roster["RosterLinks"])) if any(r in acceptable_roles for r in roster["Roles"][i].split(','))]
            for plr in players:
                player_set.add(plr)

    players = get_players(site, list(player_set), write=False)

    player_imgs = get_player_image_urls(site, list(player_set), write=False)

    # get only the most recent
    # revised_images = {}
    # for k in player_imgs:
    #     if k["Link"] not in revised_images:
    #         revised_images[k["Link"]] = k
    #     else:
    #         ok = revised_images[k["Link"]]
    #         if k["SortDate"] > ok["SortDate"] or k["DateStart"] > ok["DateStart"]:
    #             revised_images[k["Link"]] = k
    
    return players, player_imgs


def update_images(site: EsportsClient, time=datetime(datetime.now().year-1, 1, 1)):

    teams = get_teams(site, write=False)
    with open("data/cooked/teams.json", "r+", encoding='utf-8') as f:
        old_teams = json.load(f)
    team_names = set(old_teams.keys()) | set([t["OverviewPage"] for t in teams])
    for t in old_teams.values():
        for n in t["other_names"] + t["sister_teams"]:
            team_names.add(n)
    retrieve_team_images(site, team_names)
    # all_rosters = get_rosters(site, write=False)
    # new_rosters = list(filter(lambda x: x['Date'] == '' or datetime.strptime(x['Date'], "%Y-%m-%d")>=time, all_rosters))
    # players, images = fetch_player_images(site, new_rosters)
    # new_players = cook_players_data(site, players, images, write=False)
    return
