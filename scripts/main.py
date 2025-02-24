import sys
from data_update import get_new_data
from update.fetch_update_data import perform_data_update
from update.gen_update_sql import generate_update_sql
import datetime as dt

from raw import *
from cooked import *
from rules import *

from mwrogue.esports_client import EsportsClient


site = EsportsClient("lol")

if "--update" in sys.argv:
    perform_data_update(site, time=dt.datetime(2024, 1, 1))
    quit()

if "--sqlgen" in sys.argv:
    generate_update_sql()
    quit()

if "--raw" in sys.argv:
    rosters = get_rosters(site) #1

    player_set = set()
    acceptable_roles = [ "Top", "Jungle", "Mid", "Bot", "Support" ]
    for roster in rosters:
        if roster["Roles"] is not None and roster["RosterLinks"]:
            if len(roster["Roles"]) != len(roster["RosterLinks"]):
                continue
            players = [roster["RosterLinks"][i] for i in range(len(roster["RosterLinks"])) if any(r in acceptable_roles for r in roster["Roles"][i].split(','))]
            for plr in players:
                player_set.add(plr)

    players = get_players(site, list(player_set)) #2

    player_imgs = get_player_image_urls(site, list(player_set)) # 2.1

    champions = get_champions(site, False) #2.5

    # champ_players = get_players_champs(site, champions, list(player_set)) #3

    sister_teams = get_sister_teams(site) #4

    teams = get_teams(site) #5

    team_redirects = get_team_redirects(site) #6

    team_renames = get_team_renames(site) #7

    #8 TournmamentPlayer

    #9 Tournament

    tournament_results = get_tournament_results(site) #10
else:
    with open("data/raw/raw_rosters.json", "r+", encoding='utf-8') as f:
        rosters = json.load(f)
    with open("data/raw/raw_players.json", "r+", encoding='utf-8') as f:
        players = json.load(f)
        player_set = set([p["AllName"] for p in players])
    with open("data/raw/raw_player_images.json", "r+", encoding='utf-8') as f:
        player_imgs = json.load(f)
    with open("data/raw/raw_player_champions.json", "r+", encoding='utf-8') as f:
        champ_players = json.load(f)
    with open("data/raw/raw_teams_sister.json", "r+", encoding='utf-8') as f:
        sister_teams = json.load(f)
    with open("data/raw/raw_teams.json", "r+", encoding='utf-8') as f:
        teams = json.load(f)
    with open("data/raw/raw_teams_redirects.json", "r+", encoding='utf-8') as f:
        team_redirects = json.load(f)
    with open("data/raw/raw_teams_renames.json", "r+", encoding='utf-8') as f:
        team_renames = json.load(f)
    with open("data/raw/raw_results.json", "r+", encoding='utf-8') as f:
        tournament_results = json.load(f)

# #### NOW COOK DATA ####

if "--cook" in sys.argv:
    players_cooked = cook_players_data(site, players, player_imgs)

    teams_cooked = cook_teams_data(teams, sister_teams, team_renames, team_redirects, rosters)
else:
    with open("data/cooked/players.json", "r+", encoding='utf-8') as f:
        players_cooked = json.load(f)
    with open("data/cooked/teams.json", "r+", encoding='utf-8') as f:
        teams_cooked = json.load(f)

# #### NOW CREATE RULES ####

if "--create-rules" in sys.argv:
    team_rules, teammate_rules, role_rules = create_team_teammate_role_rules(teams_cooked, players_cooked, rosters)
    champion_rules = create_champion_rules(players_cooked, champ_players)
    countries_rules = create_country_rules(players_cooked)
    finalists_rules = create_worlds_finalist_rules(players_cooked, tournament_results)
    worlds_participant_rules = create_worlds_participant_rules(players_cooked, tournament_results)
else:
    with open("data/rules/teams.json", "r+", encoding='utf-8') as f:
        team_rules = json.load(f)
    with open("data/rules/teammates.json", "r+", encoding='utf-8') as f:
        teammate_rules = json.load(f)
    with open("data/rules/roles.json", "r+", encoding='utf-8') as f:
        role_rules = json.load(f)
    with open("data/rules/champion_counts.json", "r+", encoding='utf-8') as f:
        champion_rules = json.load(f)
    with open("data/rules/countries.json", "r+", encoding='utf-8') as f:
        countries_rules = json.load(f)
    with open("data/rules/finalists.json", "r+", encoding='utf-8') as f:
        finalists_rules = json.load(f)
    with open("data/rules/worlds_participants.json", "r+", encoding='utf-8') as f:
        worlds_participant_rules = json.load(f)

# #### NOW POPULATE CROSSES ####
if "--crosses" in sys.argv:
    all_rules = populate_crosses([team_rules, teammate_rules, role_rules, champion_rules, finalists_rules, worlds_participant_rules, countries_rules])
