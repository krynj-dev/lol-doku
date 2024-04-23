from PIL import Image
import urllib.request
import os, json, time

def is_locked(filepath):
    locked = None
    file_object = None
    if os.path.exists(filepath):
        try:
            buffer_size = 8
            # Opening file in append mode and read the first 8 characters.
            file_object = open(filepath, 'a', buffer_size)
            if file_object:
                locked = False
        except IOError as message:
            locked = True
        finally:
            if file_object:
                file_object.close()
    return locked

def wait_for_file(filepath):
    wait_time = 1
    while is_locked(filepath):
        time.sleep(wait_time)

os.makedirs("img/players", exist_ok=True)
os.makedirs("img/temp", exist_ok=True)

image_urls = None

with open("raw/player_images.json", encoding='utf-8') as f:
    image_urls = json.load(f)

failed = []

i = 0
for player_key in image_urls.keys():
    print(f"\r{i+1}/{len(image_urls.keys())}", sep=" ", end="", flush=True)
    try:
        url = image_urls[player_key]["URL"]
        temp_file = f"img/temp/{player_key}.{url.split('.')[-1]}"
        urllib.request.urlretrieve(url, temp_file)

        im = Image.open(temp_file)

        im.thumbnail((500, 500))

        im.save(f'img/players/{player_key}.webp', 'webp')

        im.close()

        os.remove(temp_file)

        i += 1
    except:
        failed.append(player_key)

with open("img/players/failed.json", encoding='utf-8') as f:
    f.write('\n'.join(failed))