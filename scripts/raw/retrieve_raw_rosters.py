import json
from shared import read_all_from_table, write_to_json_file, format_raw_data
from mwrogue.esports_client import EsportsClient

def get_rosters(site: EsportsClient, write=True, date=None):
    where_clause = "T.TournamentLevel='Primary'"
    if (date is not None):
        where_clause = f"{where_clause} AND T.Date IS NULL OR T.Date>'{date}'"
    responses = read_all_from_table(
        site=site,
        tables="TournamentRosters=TR, Tournaments=T",
        join_on="TR.OverviewPage=T.OverviewPage",
        fields="TR.OverviewPage, TR.Team, TR.Region, TR.RosterLinks, TR.Roles, TR.Flags, T.TournamentLevel, T.Date",
        where=where_clause
    )
    if write:
        loc = write_to_json_file("data/raw", "raw_rosters", responses, delimit=True, list_delimiter=';;')
        with open(loc, 'r+', encoding='utf-8') as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return format_raw_data(responses, True, ';;')
