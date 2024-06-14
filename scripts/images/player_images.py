from PIL import Image
from mwrogue.esports_client import EsportsClient
from shared import write_to_json_file, get_player_key, get_filename_url_to_open
import urllib.request
import os, json, time
from datetime import datetime as dt

def image_sort_key(img):
    if img["DateStart"] == "" and img["SortDate"] != "":
        return dt.strptime(img["SortDate"], '%Y-%m-%d')
    if img["SortDate"] == "" and img["DateStart"] != "":
        return dt.strptime(img["DateStart"], '%Y-%m-%d')
    if img["DateStart"] == "" and img["SortDate"] == "":
        return dt.strptime("1930-01-01", '%Y-%m-%d')
    ds = dt.strptime(img["DateStart"], '%Y-%m-%d')
    sd = dt.strptime(img["SortDate"], '%Y-%m-%d')
    return max([ds, sd])
     

def retrieve_player_images(site: EsportsClient, cooked_players: dict, raw_player_images: list):
    image_objs = {}
    i = 1
    for img in raw_player_images:
        print(f"\rImage {i}/{len(raw_player_images)}", flush=True, sep="", end="")
        link_key = get_player_key(cooked_players, img["Link"])
        if link_key is not None:
            if link_key not in image_objs.keys():
                image_objs[link_key] = []
            image_objs[link_key].append(img)
        i += 1
    for missed_key in [k for k in cooked_players.keys() if k not in image_objs.keys()]:
        image_objs[missed_key] = [{
            "FileName": cooked_players[missed_key]["image"],
            "Link": missed_key,
            "SortDate": "2024-05-14",
            "SortDate__precision": "",
            "DateStart": ""
        }]
    i = 1
    for player_key in cooked_players.keys():
        print(f"\r{i+1}/{len(cooked_players.keys())}", sep=" ", end="", flush=True)
        if player_key not in image_objs.keys() or len(image_objs[player_key]) == 0:
            continue
        most_recent = max(image_objs[player_key], key=image_sort_key)
        player_file_name = f'data/images/players/{player_key}.webp'
        if os.path.isfile(player_file_name):
            continue
        try:
            url = get_filename_url_to_open(site, most_recent["FileName"])
            if url is not None:
                url = url.split("/revision/")[0]
                os.makedirs("data/images/temp", exist_ok=True)
                os.makedirs("data/images/players", exist_ok=True)
                temp_file = f"data/images/temp/{player_key}.{url.split('.')[-1]}"
                urllib.request.urlretrieve(url, temp_file)

                im = Image.open(temp_file)

                im.thumbnail((500, 500))

                im.save(player_file_name, 'webp')

                cooked_players[player_key]["image"] = f"{player_key}.webp"

                im.close()

                os.remove(temp_file)
            else:
                # print(f"failed for {player_key}")
                pass
        except Exception as e:
            print(f"\rfailed for {player_key}", str(e), flush=True)
            cooked_players[player_key]["image"] = None
        i += 1

    return cooked_players