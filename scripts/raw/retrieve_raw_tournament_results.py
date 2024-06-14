import json
from shared import read_all_from_table, write_to_json_file, format_raw_data
from mwrogue.esports_client import EsportsClient

def get_tournament_results(site: EsportsClient, write=True):
    responses = read_all_from_table(
        site=site,
        tables="TournamentRosters=TRosters, TournamentResults=TResults, Tournaments=T",
        join_on="TRosters.PageAndTeam=TResults.PageAndTeam, TRosters.OverviewPage=T.OverviewPage",
        fields="TRosters.PageAndTeam, TResults.Event, TResults.Tier, TResults.Place, TResults.Team, TResults.GroupName, T.TournamentLevel, TRosters.OverviewPage, TRosters.RosterLinks, TRosters.Roles",
        where="TResults.Event LIKE '%Worlds%' AND T.TournamentLevel='Primary'"
    )
    if write:
        loc = write_to_json_file("data/raw", "raw_results", responses, delimit=True, list_delimiter=';;')
        with open(loc, 'r+', encoding='utf-8') as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return format_raw_data(responses, True, ';;')
