# Generated by Django 5.0.4 on 2024-05-12 01:39
import json
from django.db import migrations, transaction, IntegrityError

def int_or_none(n):
    if n == '' or n is None:
        return None
    return int(n)

def load_teams(apps, schema_editor):
    missing_plr = set()
    Team = apps.get_model("teams", "Team")
    TeamAlternateName = apps.get_model("teams", "TeamAlternateName")
    TeamSisterTeam = apps.get_model("teams", "TeamSisterTeam")
    data = None
    with open("db_data/teams.json", 'r+', encoding='utf-8') as f:
        data = json.load(f)
    if data is None:
        return
    for k in data.keys():
        team = data[k]
        try:
            with transaction.atomic():
                db_team = Team.objects.create(
                    becomes=team["becomes"],
                    came_from=team["came_from"],
                    highest_level=team["highest_level"],
                    image=team["image"],
                    name=team["name"],
                    op=team["op"],
                    region=team["region"],
                    short=team["short"],
                    )
                db_team.save()
                for other_name in team["other_names"]:
                    try:
                        db_oname = TeamAlternateName.objects.create(
                            team_op=db_team,
                            alternate_name=other_name
                        )
                        db_oname.save()
                    except:
                        pass
                for sister_team in team["sister_teams"]:
                    try:
                        db_sister = TeamSisterTeam.objects.create(
                            team_op=db_team,
                            sister_team_name=sister_team
                        )
                        db_sister.save()
                    except:
                        pass
                db_team.save()
        except IntegrityError as e:
            print(e)
            db_team.delete()
    print(f"missing players {missing_plr}")


class Migration(migrations.Migration):

    dependencies = [
        ('teams', '0002_alter_team_becomes_alter_team_came_from_and_more'),
    ]

    operations = [
        migrations.RunPython(load_teams)
    ]