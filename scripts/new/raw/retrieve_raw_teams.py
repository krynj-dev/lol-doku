import json
from shared import read_all_from_table, write_to_json_file
from mwrogue.esports_client import EsportsClient

def get_sister_teams(site: EsportsClient):
    responses = read_all_from_table(
        site=site,
        tables="SisterTeams=S",
        fields="S.Team, S.AllTeams",
    )
    loc = write_to_json_file("data/raw", "raw_teams_sister", responses, delimit=True, list_delimiter=',')
    with open(loc, 'r+', encoding='utf-8') as f:
        saved_obj = json.load(f)
    return saved_obj

def get_teams(site: EsportsClient):
    responses = read_all_from_table(
        site=site,
        tables="Teams=T",
        fields="T.Name, T.OverviewPage, T.Short, T.Region, T.Image, T.RenamedTo",
    )
    loc = write_to_json_file("data/raw", "raw_teams", responses)
    with open(loc, 'r+', encoding='utf-8') as f:
        saved_obj = json.load(f)
    return saved_obj

def get_team_renames(site: EsportsClient):
    responses = read_all_from_table(
        site=site,
        tables="TeamRenames=T",
        fields="T.Date, T.OriginalName, T.NewName, T.Verb, T.Slot, T.IsSamePage",
    )
    loc = write_to_json_file("data/raw", "raw_teams_renames", responses)
    with open(loc, 'r+', encoding='utf-8') as f:
        saved_obj = json.load(f)
    return saved_obj

def get_team_redirects(site: EsportsClient):
    responses = read_all_from_table(
        site=site,
        tables="TeamRedirects=TR",
        fields="TR._pageName=PageName, TR.AllName",
    )
    loc = write_to_json_file("data/raw", "raw_teams_redirects", responses)
    with open(loc, 'r+', encoding='utf-8') as f:
        saved_obj = json.load(f)
    return saved_obj