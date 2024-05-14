from mwrogue.esports_client import EsportsClient
import urllib.request, json, os
from PIL import Image

os.makedirs("img", exist_ok=True)
os.makedirs("img/temp", exist_ok=True)
os.makedirs("img/teams", exist_ok=True)

def get_filename_url_to_open(site: EsportsClient, filename, team, width=None):
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

        #In case you would like to save the image in a specific location, you can add the path after 'url,' in the line below.
        # urllib.request.urlretrieve(url, 'img/' + team + '.png')
        # return url
    return None

team_json = None

with open('cooked/teams.json', 'r+', encoding='utf-8') as f:
    team_json = json.load(f)

teams = [x for x in team_json.keys()]

site = EsportsClient("lol")
i = 1
img_map = {}
failed = []
for team in teams:
    print("\rFetching image for team {}/{}".format(i, len(teams)), sep=' ', end='', flush=True)
    if team_json[team]["image"] is not None:
        img_url = get_filename_url_to_open(site, team_json[team]["image"], team)
        if img_url is not None:
            try:
                image_ext = img_url.split('/revision/')[0].split('.')[-1]
                temp_name = f'img/temp/{team}.{image_ext}'
                img_map[team] = f"img/teams/{team}.webp"
                urllib.request.urlretrieve(img_url, temp_name)

                im = Image.open(temp_name)

                im.thumbnail((500, 500))

                im.save(f'img/teams/{team}.webp', 'webp')

                im.close()

                os.remove(temp_name)
            except:
                failed.append(img_url)

    i += 1

with open('cooked/failed_team_images.txt', 'w+', encoding='utf-8') as f:
    f.write('\n'.join(failed))

with open('cooked/team_images.json', 'w+', encoding='utf-8') as f:
    json.dump(img_map, f, ensure_ascii=False, indent=4, default=lambda o: list(o))