# A script to bulk set a puzzle for many days lazily. Reuses a bunch of puzzles

import os, json
from datetime import date, timedelta
from supabase import create_client, Client
import requests

url: str = os.environ.get("SUPABASE_URL")
key: str = os.environ.get("SUPABASE_KEY")

supabase: Client = create_client(url, key)


days: int = int(input("How many days to set? "))
offset: int = int(input("Puzzle ID offset? "))
days_offset: int = int(input("Days offset? "))
un: str = input("username? ")
pw: str = input("password ")

# Get all puzzles to loop through
puzzles_response = supabase.table("puzzles_puzzle").select("*").execute()

puzzle_ids = [x["id"] for x in puzzles_response.data]

responses = []

base_url = "https://lol-doku-backend-service-s3hl4c5epa-ts.a.run.app"
login = "/meta/login"
token_res = requests.post(base_url + login, json={"username": un, "password": pw})
token = json.loads(token_res.text)["token"]
game_daily = "/game/daily/"
puzzles = "/puzzles/{}/"
for i in range(days):
    day = date.today() + timedelta(days=i) + timedelta(days=days_offset)
    # Ensure day isn't already set
    day_response = (
        supabase.table("game_gameroster").select("*").eq("date", day).execute()
    )
    if len(day_response.data) > 0:
        continue
    body = {
        "date": str(day),
        "puzzle": base_url + puzzles.format(puzzle_ids[(i + offset) % len(puzzle_ids)]),
    }
    insert_response = requests.post(
        base_url + game_daily, json=body, headers={"Authorization": f"Token {token}"}
    )
    responses.append(insert_response)

if any([res.status_code // 100 != 2 for res in responses]):
    print("some failed")
