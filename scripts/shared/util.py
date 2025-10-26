import json, os, time
from mwrogue.esports_client import EsportsClient
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
            file_object = open(filepath, "a", buffer_size)
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


def get_filename_url_to_open(site: EsportsClient, filename, width=None):
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


def none_to_blank(str):
    if str is None:
        return ""
    return str


def get_team_key(cooked_teams: dict, team_name: str):
    if team_name in cooked_teams:
        return team_name
    return next(
        (
            k
            for k, v in cooked_teams.items()
            if team_name.lower() in [name.lower() for name in v["other_names"]]
        ),
        None,
    )


def get_player_key(cooked_players, player_name):
    keys = [
        k
        for k in cooked_players.keys()
        if player_name.lower()
        in [
            n.lower()
            for n in [cooked_players[k]["display_name"]]
            + cooked_players[k]["alternate_names"]
        ]
    ]
    if len(keys) > 1:
        keys = [
            k
            for k in keys
            if player_name
            in [cooked_players[k]["display_name"]]
            + cooked_players[k]["alternate_names"]
        ]
        if len(keys) > 1:
            return None
        else:
            return keys[0]
    elif len(keys) == 0:
        return None
    else:
        return keys[0]


def get_player_key_cached(cooked_players: dict, player_name: str, cache: dict):
    if player_name in cache:
        return cache[player_name]
    res = get_player_key(cooked_players, player_name)
    cache[player_name] = res
    return res


def get_team_key_cached(cooked_teams: dict, team_name: str, cache: dict):
    if team_name in cache:
        return cache[team_name]
    res = get_team_key(cooked_teams, team_name)
    cache[team_name] = res
    return res


def format_raw_data(objects, delimit=False, list_delimiter=",", list_fields=[]):
    res_copy = []
    for obj in objects:
        obj_copy = {}
        for key in obj:
            val = none_to_blank(obj[key])
            if delimit and key in list_fields:
                obj_copy[key] = val.split(list_delimiter)
            else:
                obj_copy[key] = val
        res_copy.append(obj_copy)
    return res_copy


def write_to_json_file(
    dir,
    file_name,
    objects,
    format=True,
    delimit=False,
    list_delimiter=",",
    list_fields=[],
):
    object_to_save = objects
    if format:
        object_to_save = format_raw_data(objects, delimit, list_delimiter, list_fields)
    os.makedirs(dir, exist_ok=True)
    file_loc = f"{dir}/{file_name}.json"
    with open(file_loc, "w+", encoding="utf-8") as f:
        json.dump(
            object_to_save,
            f,
            ensure_ascii=False,
            indent=4,
            sort_keys=True,
            default=lambda o: sorted(o) if isinstance(o, set) else list(o),
        )
    return file_loc


def get_response(
    site: EsportsClient,
    tables: str,
    fields: str,
    offset: int,
    join_on: str = None,
    group_by: str = None,
    where: str = None,
    having: str = "",
):
    if join_on is not None and group_by is not None and where is not None:  # 1 1 1
        return site.cargo_client.query(
            tables=tables,
            join_on=join_on,
            fields=fields,
            group_by=group_by,
            where=where,
            offset=offset,
            having=having,
            limit=500,
        )
    elif join_on is not None and group_by is not None and where is None:  # 1 1 0
        return site.cargo_client.query(
            tables=tables,
            join_on=join_on,
            fields=fields,
            group_by=group_by,
            offset=offset,
            having=having,
            limit=500,
        )
    elif join_on is not None and group_by is None and where is None:  # 1 0 0
        return site.cargo_client.query(
            tables=tables,
            join_on=join_on,
            fields=fields,
            offset=offset,
            having=having,
            limit=500,
        )
    elif join_on is None and group_by is None and where is None:  # 0 0 0
        return site.cargo_client.query(
            tables=tables, fields=fields, offset=offset, having=having, limit=500
        )
    elif join_on is not None and group_by is None and where is not None:  # 1 0 1
        return site.cargo_client.query(
            tables=tables,
            join_on=join_on,
            fields=fields,
            where=where,
            offset=offset,
            having=having,
            limit=500,
        )
    elif join_on is None and group_by is not None and where is not None:  # 0 1 1
        return site.cargo_client.query(
            tables=tables,
            join_on=join_on,
            fields=fields,
            group_by=group_by,
            where=where,
            offset=offset,
            having=having,
            limit=500,
        )
    elif join_on is None and group_by is None and where is not None:  # 0 0 1
        return site.cargo_client.query(
            tables=tables,
            join_on=join_on,
            fields=fields,
            where=where,
            offset=offset,
            having=having,
            limit=500,
        )
    elif join_on is None and group_by is not None and where is None:  # 0 1 0
        return site.cargo_client.query(
            tables=tables,
            join_on=join_on,
            fields=fields,
            group_by=group_by,
            offset=offset,
            having=having,
            limit=500,
        )
    raise Exception("Could not determine which query to make")


def read_all_from_table(
    site: EsportsClient,
    tables: str,
    fields: str,
    join_on: str = None,
    group_by: str = None,
    where: str = None,
    having: str = "",
    display_progress=True,
):
    responses = []
    offset = 0
    page = 1
    sleep_time = 0.01
    while True:
        if display_progress:
            print("\rPage {}".format(page), sep=" ", end="", flush=True)
        try:
            response = get_response(
                site, tables, fields, offset, join_on, group_by, where, having
            )
            if len(response) == 0:
                break
            responses += response
            offset += 500
            page += 1
            sleep_time = max(0.01, sleep_time / 2)
        except Exception as ex:
            if ex.code != "ratelimited":
                print(ex)
            sleep_time *= 2
        time.sleep(sleep_time)

    if display_progress:
        print("\n")
    return responses
