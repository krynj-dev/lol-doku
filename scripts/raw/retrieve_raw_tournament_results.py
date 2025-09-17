import json
from shared import read_all_from_table, write_to_json_file, format_raw_data
from mwrogue.esports_client import EsportsClient

def get_tournament_results(site: EsportsClient, write=True, write_loc=None):
    responses = read_all_from_table(
        site=site,
        tables="TournamentRosters=TRosters, TournamentResults=TResults, Tournaments=T",
        join_on="TRosters.PageAndTeam=TResults.PageAndTeam, TRosters.OverviewPage=T.OverviewPage",
        fields="T.League, TRosters.PageAndTeam, TResults.Event, TResults.Tier, TResults.Place, TResults.Team, TResults.GroupName, T.TournamentLevel, TRosters.OverviewPage, TRosters.RosterLinks, TRosters.Roles",
        where="TResults.Event LIKE '%Worlds%' AND T.TournamentLevel='Primary'"
    )
    if write:
        dest = "data/raw" if write_loc is None else write_loc
        loc = write_to_json_file(dest, "raw_results", responses, delimit=True, list_delimiter=';;', list_fields=["RosterLinks", "Roles"])
        with open(loc, 'r+', encoding='utf-8') as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return format_raw_data(responses, True, ';;', ["RosterLinks", "Roles"])

def get_all_tournament_results(site: EsportsClient, write=True, write_loc=None):
    responses = read_all_from_table(
        site=site,
        tables="LeagueGroups=LG, Leagues=L, Tournaments=T, TournamentRosters=R, TournamentResults=TR, ScoreboardTeams=S",
        join_on="LG.Leagues HOLDS L.League, L.League=T.League, T.OverviewPage=R.OverviewPage, R.PageAndTeam=TR.PageAndTeam, T.OverviewPage=S.OverviewPage",
        fields="LG.LongName, LG.ShortName, L.Level, T.Name, TR.Team, T.IsQualifier, T.EventType, R.RosterLinks, R.Roles, TR.Place_Number, L.Region, L.League, T.IsPlayoffs, TR.GroupName, TR.IsAchievement, S.UniqueGame",
        where="R.RosterLinks !='' AND L.Level='Primary' AND LG.LongName!='' AND (((T.IsPlayoffs=TRUE OR TR.GroupName LIKE '%Playoff%' OR S.UniqueGame LIKE '%Finals%' OR S.UniqueGame LIKE '%Playoffs%' OR S.UniqueGame LIKE '%Bracket%' OR S.UniqueGame LIKE '%Knockout%')"
            " AND TR.Place_Number=1 AND T.Name NOT LIKE '%Play-In%' AND L.Region!='International') OR (T.IsQualifier=FALSE AND L.Region='International' AND T.Name NOT LIKE '%Regional Final%'))"
            " AND LG.ShortName!='RR'"
        # where="R.RosterLinks !='' AND L.Level='Primary' AND LG.LongName!='' AND T.IsQualifier=FALSE AND ((TR.Place_Number=1 AND T.Name NOT LIKE '%Play-In%') OR (L.Region='International' AND T.Name NOT LIKE '%Regional Final%'))"
        # where="R.RosterLinks !='' AND L.Level='Primary' AND LG.LongName!=''"
        , group_by="LG.LongName, LG.ShortName, T.Name, TR.Team, L.League, R.RosterLinks"
    )
    if write:
        dest = "data/raw" if write_loc is None else write_loc
        loc = write_to_json_file(dest, "raw_results_all", responses, delimit=True, list_delimiter=';;', list_fields=["RosterLinks", "Roles"])
        with open(loc, 'r+', encoding='utf-8') as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return format_raw_data(responses, True, ';;', ["RosterLinks", "Roles"])
