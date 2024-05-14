import json
from shared import read_all_from_table, write_to_json_file, format_raw_data
from mwrogue.esports_client import EsportsClient

def get_champions(site: EsportsClient, save=True):
    responses = read_all_from_table(
        site=site,
        tables="Champions=C",
        fields="C.Name",
    )
    formatted_object = None
    if save:
        loc = write_to_json_file("data/raw", "raw_players", responses, delimit=True, list_delimiter='\n')
        with open(loc, 'r+', encoding='utf-8') as f:
            formatted_object = json.load(f)
    else:
        formatted_object = format_raw_data(responses, delimit=True, list_delimiter='\n')
    return formatted_object