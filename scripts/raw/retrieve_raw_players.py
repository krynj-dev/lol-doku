import json, html
from shared import read_all_from_table, write_to_json_file, format_raw_data
from mwrogue.esports_client import EsportsClient

def get_players(site: EsportsClient, names_to_get: list, write=True):
    name_str = ','.join([f"'{n}'" for n in names_to_get])
    responses = read_all_from_table(
        site=site,
        tables="Players=P, PlayerRedirects=PR",
        join_on="P.OverviewPage=PR.OverviewPage",
        fields="PR.AllName, PR.ID, PR.OverviewPage, P.Name, P.Country, P.Age, P.Residency, P.Image",
        where=f"PR.AllName IN ({name_str})"
    )
    if write:
        loc = write_to_json_file("data/raw", "raw_players", responses, delimit=True, list_delimiter='\n')
        with open(loc, 'r+', encoding='utf-8') as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return format_raw_data(responses, True, '\n')

def get_players_champs(site: EsportsClient, champions_to_get: list, names_to_get: list, write=True):
    all_responses = []
    name_str = ','.join([f"'{n}'" for n in names_to_get])
    for champ in [html.unescape(c["Name"]) for c in champions_to_get]:
        if champ == "Nunu & Willump":
            champ = "Nunu"
        champ_sql = champ.replace('\'', '\'\'')
        responses = read_all_from_table(
            site=site,
            tables="ScoreboardGames=SG,Tournaments=To, ScoreboardPlayers=SP, PlayerRedirects=PR, TeamRedirects=TRed, Players=P",
            join_on="SG.GameId=SP.GameId, To.OverviewPage=SG.OverviewPage, SP.Link=PR.AllName, SP.Team=TRed.AllName, PR.OverviewPage=P.OverviewPage",
            fields="P.OverviewPage, SP.Champion, To.TournamentLevel, COUNT(SP.Champion)=GameCount, SP.Link",
            group_by="SP.Champion, To.TournamentLevel, PR.OverviewPage, SP.Link",
            where=f"To.TournamentLevel='Primary' AND SP.Champion='{champ_sql}' AND PR.OverviewPage IN ({name_str})",
            display_progress=False
        )
        all_responses += responses
    if write:
        loc = write_to_json_file("data/raw", "raw_player_champions", all_responses)
        with open(loc, 'r+', encoding='utf-8') as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return format_raw_data(responses)