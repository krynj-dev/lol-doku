# A script to bulk set a puzzle for many days lazily. Reuses a bunch of puzzles

import os
from datetime import date, timedelta
from supabase import create_client, Client

url: str = os.environ.get("SUPABASE_URL")
key: str = os.environ.get("SUPABASE_KEY")

supabase: Client = create_client(url, key)


days: int = int(input("How many days to set? "))

# Get all puzzles to loop through
puzzles_response = supabase.table("puzzles_puzzle").select("*").execute()

puzzle_ids = [x['id'] for x in puzzles_response.data]

rosters_to_add = []

for i in range(days):
    day = date.today() + timedelta(days=i)
    # Ensure day isn't already set
    day_response = supabase.table("game_gameroster").select("*").eq('date', day).execute()
    if len(day_response.data) > 0:
        continue
    # Now set it
    rosters_to_add.append({"date": str(day), "puzzle_id": puzzle_ids[i % len(puzzle_ids)]})

insert_response = (
    supabase.table("game_gameroster")
    .insert(rosters_to_add)
    .execute()
)

if len(insert_response.data) != days:
    print("Some failed")
