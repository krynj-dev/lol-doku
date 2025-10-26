import json, html
from shared import read_all_from_table, write_to_json_file, format_raw_data
from mwrogue.esports_client import EsportsClient
from multiprocessing import Pool, cpu_count


def get_players(site: EsportsClient, names_to_get: list, write=True, write_loc=None):
    where = (
        ""
        if names_to_get is None
        else "PR.AllName IN ({})".format(",".join([f"'{n}'" for n in names_to_get]))
    )
    responses = read_all_from_table(
        site=site,
        tables="Players=P, PlayerRedirects=PR",
        join_on="P.OverviewPage=PR.OverviewPage",
        fields="PR.AllName, PR.ID, PR.OverviewPage, P.Name, P.Country, P.Age, P.Residency, P.Image",
        where=where,
    )
    if write:
        dest = "data/raw" if write_loc is None else write_loc
        loc = write_to_json_file(
            dest, "raw_players", responses, delimit=True, list_delimiter="\n"
        )
        with open(loc, "r+", encoding="utf-8") as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return format_raw_data(responses, True, "\n")


def get_players_champs(
    site: EsportsClient, champions_to_get: list, names_to_get: list, write=True
):
    all_responses = []
    name_str = ",".join([f"'{n}'" for n in names_to_get])
    for champ in [html.unescape(c["Name"]) for c in champions_to_get]:
        if champ == "Nunu & Willump":
            champ = "Nunu"
        print(f"\r{champ}         ", sep="", end="", flush=True)
        champ_sql = champ.replace("'", "''")
        responses = read_all_from_table(
            site=site,
            tables="Tournaments=To, ScoreboardPlayers=SP, PlayerRedirects=PR,Players=P",
            join_on="To.OverviewPage=SP.OverviewPage, SP.Link=PR.AllName, PR.OverviewPage=P.OverviewPage",
            fields="P.OverviewPage, SP.Champion, To.TournamentLevel, COUNT(SP.Champion)=GameCount, SP.Link",
            group_by="SP.Champion, PR.OverviewPage, SP.Link",
            where=f"To.TournamentLevel IN ('Primary', 'Secondary') AND SP.Champion='{champ_sql}'",
            having="COUNT(SP.Champion)>=25",
            display_progress=False,
        )
        all_responses += responses
        print("\r", flush=True)
    # for i in range(ord("A"), ord("Z")+1):
    #     c = chr(i)
    #     print(f"\rChampions starting with {c}", sep="", flush=True)
    #     responses = read_all_from_table(
    #         site=site,
    #         tables="Tournaments=To, ScoreboardPlayers=SP, PlayerRedirects=PR,Players=P",
    #         join_on="To.OverviewPage=SP.OverviewPage, SP.Link=PR.AllName, PR.OverviewPage=P.OverviewPage",
    #         fields="P.OverviewPage, SP.Champion, To.TournamentLevel, COUNT(SP.Champion)=GameCount, SP.Link",
    #         group_by="SP.Champion, PR.OverviewPage, SP.Link",
    #         where=f"To.TournamentLevel IN ('Primary', 'Secondary') AND SP.Champion LIKE '{c}%'",
    #         having="COUNT(SP.Champion)>=25",
    #         display_progress=False
    #     )
    #     all_responses += responses
    if write:
        loc = write_to_json_file("data/raw", "raw_player_champions", all_responses)
        with open(loc, "r+", encoding="utf-8") as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return format_raw_data(all_responses)


def get_pentakills(
    site: EsportsClient, levels=["Primary", "Secondary"], write=True, write_loc=None
):
    responses = read_all_from_table(
        site=site,
        tables="Pentakills=P, Tournaments=T",
        join_on="P.OverviewPage=T.OverviewPage",
        fields="P.Name, P.Link, T.OverviewPage, T.TournamentLevel, COUNT(P.Link)",
        where="T.TournamentLevel IN ({})".format(", ".join([f"'{l}'" for l in levels])),
        group_by="P.Link",
        # having="COUNT(P.Link)>2"
    )
    if write:
        dest = "data/raw" if write_loc is None else write_loc
        loc = write_to_json_file(
            dest, "raw_pentas", responses, delimit=True, list_delimiter="\n"
        )
        with open(loc, "r+", encoding="utf-8") as f:
            saved_obj = json.load(f)
        return saved_obj
    else:
        return format_raw_data(responses, True, "\n")


def get_champ_counts_mp(
    site: EsportsClient, champions_to_get: list, names_to_get: list, write=True
):
    size = 25
    # split into chunks
    k, m = divmod(len(champions_to_get), size)
    chunks = []
    s = 0
    for i in range(size):
        c_size = k + (1 if i < m else 0)
        chunks.append(champions_to_get[s : s + c_size])
        s += c_size
    # Submit for work
    with Pool(cpu_count() // 2) as pool:
        results = pool.map(process_batch, chunks)
    return [item for sublist in results for item in sublist]


def process_batch(champs: list):
    site = EsportsClient("lol")
    champ_names = [map_champion_name(c["Name"]) for c in champs]
    champ_list_sql = ",".join([f"'{c}'" for c in champ_names])
    responses = read_all_from_table(
        site=site,
        tables="Tournaments=To, ScoreboardPlayers=SP, PlayerRedirects=PR,Players=P",
        join_on="To.OverviewPage=SP.OverviewPage, SP.Link=PR.AllName, PR.OverviewPage=P.OverviewPage",
        fields="P.OverviewPage, SP.Champion, To.TournamentLevel, COUNT(SP.Champion)=GameCount, SP.Link",
        group_by="SP.Champion, PR.OverviewPage, SP.Link",
        where=f"To.TournamentLevel IN ('Primary', 'Secondary') AND SP.Champion IN ({champ_list_sql})",
        having="COUNT(SP.Champion)>=25",
        display_progress=False,
    )
    return responses


def map_champion_name(champ: str):
    c = html.unescape(champ)
    if c == "Nunu & Willump":
        return "Nunu"
    return c.replace("'", "''")
