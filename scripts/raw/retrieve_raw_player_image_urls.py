import json, html
from shared import read_all_from_table, write_to_json_file, format_raw_data
from mwrogue.esports_client import EsportsClient

def get_player_image_urls(site: EsportsClient, names_to_get: list, write=True):
    responses = site.cargo_client.query(
        tables="PlayerImages=PI, Tournaments=T",
        join_on="T.OverviewPage=PI.Tournament",
        fields="PI.FileName, PI.Link, PI.SortDate, T.DateStart",
        order_by="PI.SortDate DESC, T.DateStart DESC",
    )
    if write:
        loc = write_to_json_file("data/raw", "raw_player_images", responses, delimit=False)
        with open(loc, 'r+', encoding='utf-8') as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return format_raw_data(responses, False)
