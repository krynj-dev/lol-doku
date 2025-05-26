import json
from shared import read_all_from_table, write_to_json_file, format_raw_data
from mwrogue.esports_client import EsportsClient

def get_rosters(site: EsportsClient, write=True, write_loc=None, date=None, levels=['Primary']):
    where_clause = "T.TournamentLevel IN ({})".format(', '.join([f"'{l}'" for l in levels]))
    if (date is not None):
        where_clause = f"{where_clause} AND T.Date IS NULL OR T.Date>'{date}'"
    responses = read_all_from_table(
        site=site,
        tables="TournamentRosters=TR, Tournaments=T",
        join_on="TR.OverviewPage=T.OverviewPage",
        fields="TR.OverviewPage, TR.Team, TR.Region, TR.RosterLinks, TR.Roles, TR.Flags, T.TournamentLevel, T.Date, T.Name",
        where=where_clause
    )
    if write:
        dest = "data/raw" if write_loc is None else write_loc
        loc = write_to_json_file(dest, "raw_rosters", responses, delimit=True, list_delimiter=';;', list_fields=["RosterLinks", "Roles", "Flags"])
        with open(loc, 'r+', encoding='utf-8') as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return format_raw_data(responses, True, ';;', ["RosterLinks", "Roles", "Flags"])
