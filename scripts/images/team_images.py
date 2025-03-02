from PIL import Image
from mwrogue.esports_client import EsportsClient
from shared import write_to_json_file, get_player_key, get_filename_url_to_open
import urllib.request
import os, json, time
from datetime import datetime as dt

def retrieve_team_images(site: EsportsClient, teams: list):
    i = 1
    failures = []
    for team in teams:
        team_key = team["OverviewPage"]
        print(f"\r{i+1}/{len(teams)}", sep=" ", end="", flush=True)
        team_file_name = f'data/images/teams/{team["OverviewPage"]}.webp'
        if os.path.isfile(team_file_name):
            continue
        try:
            url = get_filename_url_to_open(site, team["Image"])
            if url is not None:
                url = url.split("/revision/")[0]
                os.makedirs("data/images/temp", exist_ok=True)
                os.makedirs("data/images/teams", exist_ok=True)
                temp_file = f"data/images/temp/{team_key}.{url.split('.')[-1]}"
                urllib.request.urlretrieve(url, temp_file)

                im = Image.open(temp_file)

                im.thumbnail((500, 500))

                im.save(team_file_name, 'webp')

                im.close()

                os.remove(temp_file)
            else:
                # print(f"failed for {player_key}")
                pass
        except Exception as e:
            # print(f"\rfailed for {player_key}", str(e), flush=True)
            failures.append((team_key, e))
        i += 1