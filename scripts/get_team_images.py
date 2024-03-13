from mwrogue.esports_client import EsportsClient
import urllib.request, json, os

os.makedirs("img", exist_ok=True)

def get_filename_url_to_open(site: EsportsClient, filename, team, width=None):
    response = site.client.api(
        action="query",
        format="json",
        titles=f"File:{filename}",
        prop="imageinfo",
        iiprop="url",
        iiurlwidth=width,
    )

    image_info = next(iter(response["query"]["pages"].values()))["imageinfo"][0]

    if width:
        url = image_info["thumburl"]
    else:
        url = image_info["url"]

    #In case you would like to save the image in a specific location, you can add the path after 'url,' in the line below.
    urllib.request.urlretrieve(url, 'img/' + team + '.png')

team_json = None

with open('cooked/teams.json', 'r+', encoding='utf-8') as f:
    team_json = json.load(f)

teams = [x for x in team_json.keys()]

site = EsportsClient("lol")
for team in teams:
    url = f"{team}logo square.png"
    get_filename_url_to_open(site, url, team)