import sys, datetime as dt
from raw import *
from shared import get_player_key, get_filename_url_to_open
from update import load_most_recent_data

from mwrogue.esports_client import EsportsClient


def played_match(roster_roles: str):
    return any(
        [
            role in ["Top", "Jungle", "Mid", "Bot", "Support"]
            for role in roster_roles.split(",")
        ]
    )


def images(site: EsportsClient):
    responses = read_all_from_table(
        site=site,
        tables="Tournaments=T",
        fields="T.OverviewPage, T.TournamentLevel, T.Date, T.Name, T.Region, T.League, T.LeagueIconKey",
    )
    found_imgs = {}
    for tournament in responses:
        tname = tournament["Name"]
        league = tournament["League"]
        year = "" if tournament["Date"] is None else tournament["Date"][:4]
        iconkey = (
            "" if tournament["LeagueIconKey"] is None else tournament["LeagueIconKey"]
        )
        x = tournament["OverviewPage"]
        response = site.client.api(
            action="query",
            format="json",
            titles=f"{x}",
            prop="images",
            iiprop="url",
            iiurlwidth=None,
        )

        it = next(iter(response["query"]["pages"].values()))

        # Doesn't always get the right image
        if "images" in it.keys() and len(it["images"]) > 0:
            image_info = it["images"][0]
            url = get_filename_url_to_open(
                site, image_info["title"].replace("File:", "")
            )
            found_imgs[tname] = url
    pass


def main(site: EsportsClient):
    images(site)
    all_rosters = get_rosters(
        site, write=False, levels=["Primary", "Secondary", "Showmatch", ""]
    )
    # all_rosters = get_rosters(site, write=False, levels=["Primary"])
    _, players, _, _, _, _, _, _, _ = load_most_recent_data()
    player_links = []
    i = 1
    for roster in all_rosters:
        print(f"\rRoster {i}/{len(all_rosters)}", flush=True, end="", sep="")
        i += 1
        if len(roster["RosterLinks"]) != len(roster["Roles"]):
            continue
        roster_players = [get_player_key(players, plr) for plr in roster["RosterLinks"]]
        the_zip = [
            (k, r) for k, r in zip(roster_players, roster["Roles"]) if k is not None
        ]
        for key, roles in the_zip:
            if key is None:
                continue
            # if played_match(roles):
            for ok, oroles in the_zip:
                if ok == key:
                    continue
                team = roster["Team"]
                date = roster["Date"]
                name = roster["Name"]
                for role in roles.split(","):
                    for orole in oroles.split(","):
                        player_links.append(
                            {
                                "team": team,
                                "date": date,
                                "tournament": name,
                                "role_one": role,
                                "role_two": orole,
                                "player_one": key,
                                "player_two": ok,
                            }
                        )
    write_to_json_file("data/pro2pro", "roster_links", player_links, format=False)
    return player_links


if __name__ == "__main__":
    site = EsportsClient("lol")
    links = main(site)
