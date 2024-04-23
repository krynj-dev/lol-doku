from mwrogue.esports_client import EsportsClient
import urllib.request, json, os, time

os.makedirs("img", exist_ok=True)

site = EsportsClient("lol")

def find_player(players, key):
    for player_key in players.keys():
        if any([key == n for n in players[player_key]["alternate_names"]]):
            return players[player_key]
    return None


def get_filename_url_to_open(site: EsportsClient, filename, player, width=None):
    response = site.client.api(
        action="query",
        format="json",
        titles=f"File:{filename}",
        prop="imageinfo",
        iiprop="url",
        iiurlwidth=width,
    )

    it = next(iter(response["query"]["pages"].values()))

    if "imageinfo" in it.keys():
        image_info = it["imageinfo"][0]

        if width:
            return image_info["thumburl"]
        else:
            return image_info["url"]

    return None

player_list = None

with open("cooked/players.json", 'r+', encoding='utf-8') as f:
    player_list = json.load(f)

all_images = []
i = 0
offset = 0
while True:
    print(f"\rPage {i+1}", sep=" ", end="", flush=True)
    response = site.cargo_client.query(
        tables="PlayerImages=PI, PlayerRedirects=PR, Tournaments=T",
        join_on="PI.Link=PR.OverviewPage, T.OverviewPage=PI.Tournament",
        fields="PI.FileName, PI.Link, PR.AllName, PI.SortDate, T.DateStart",
        order_by="PI.SortDate DESC, T.DateStart DESC",
        limit=500,
        offset=offset
    )
    if len(response) == 0:
        break
    all_images += response
    offset += 500
    i += 1

with open('raw/player_images_res.json', 'w+', encoding='utf-8') as f:
    json.dump(all_images, f, ensure_ascii=False, indent=4)

player_images = {}

stats = {
    'link': 0,
    'allname': 0,
    'both': 0,
    'none': 0
}
nones = []
print("")
x = 0
for img in all_images:
    print(f"\rImage {x+1}", sep=" ", end="", flush=True)
    l = find_player(player_list, img["Link"])
    an = find_player(player_list, img["AllName"])
    to_add = None
    if l is not None and an is not None:
        stats['both'] += 1
        to_add = (img["Link"], l)
    elif l is not None:
        stats['link'] += 1
        to_add = (img["Link"], l)
    elif an is not None:
        stats['allname'] += 1
        to_add = (img["AllName"], an)
    else:
        stats['none'] += 1
        nones.append((img["Link"], img["AllName"]))
    if to_add is not None:
        if to_add[1]["display_name"] not in player_images.keys():
            player_images[to_add[1]["display_name"]] = {
                "SortDate": img["SortDate"],
                "DateStart": img["DateStart"],
                "URL": get_filename_url_to_open(site, img["FileName"], None, width=None)
            }
        elif player_images[to_add[1]["display_name"]]["SortDate"] is not None and img["SortDate"] is not None and (
            player_images[to_add[1]["display_name"]]["SortDate"] < img["SortDate"]
        ) or (
            player_images[to_add[1]["display_name"]]["DateStart"] is not None and img["DateStart"] is not None and (
            player_images[to_add[1]["display_name"]]["DateStart"] < img["DateStart"]
        )) or (player_images[to_add[1]["display_name"]]["DateStart"] is None and player_images[to_add[1]["display_name"]]["SortDate"] is None):
            player_images[to_add[1]["display_name"]] = {
                "SortDate": img["SortDate"],
                "DateStart": img["DateStart"],
                "URL": get_filename_url_to_open(site, img["FileName"], None, width=None).split("/revision/")[0]
            }

    x += 1

player_images[""] = {
    "URL": "https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/1/1d/Unknown_Infobox_Image_-_Player.png"
}

with open('raw/player_images_res.json', 'w+', encoding='utf-8') as f:
    json.dump(all_images, f, ensure_ascii=False, indent=4)

with open('raw/player_images.json', 'w+', encoding='utf-8') as f:
    json.dump(player_images, f, ensure_ascii=False, indent=4)