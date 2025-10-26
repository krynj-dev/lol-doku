import json
from django.db.models import Q
from django.db import migrations, models, transaction, IntegrityError


def init_data(apps, schema_editor):
    Tournament: models.Model = apps.get_model("pro2pro", "Tournament")
    Roster: models.Model = apps.get_model("pro2pro", "Roster")
    RosterLink: models.Model = apps.get_model("pro2pro", "RosterLink")
    Player: models.Model = apps.get_model("players", "Player")
    TeamAlternateName: models.Model = apps.get_model("teams", "TeamAlternateName")
    # Open file
    with open("db_data/pro2pro/initial/roster_links.json", "r+", encoding="utf-8") as f:
        data: list[dict] = json.load(f)
    if data is None:
        return
    # Make links
    i = 1
    print("")
    for link in data:
        perc = int((i * 100 // len(data)) // 5)
        print(
            "\r[{}] {}/{}".format("-" * perc + " " * (20 - perc), i, len(data)),
            flush=True,
            end="",
            sep="",
        )
        i += 1
        try:
            created_objects = []
            with transaction.atomic():
                player_one = link["player_one"]
                date = link["date"]
                role_one = link["role_one"]
                team_name = link["team"]
                tournament_name = link["tournament"]
                try:
                    p1 = Player.objects.get(display_name=player_one)
                    team = TeamAlternateName.objects.filter(
                        Q(alternate_name=team_name)
                        | Q(alternate_name__iexact=team_name)
                    ).get(team_op__active=True)
                except Exception as e:
                    print("Exception processing", link, e, sep="\n")
                # Get or create the relevant tournament
                tournament, created = Tournament.objects.get_or_create(
                    name=tournament_name, date=date if date != "" else None
                )
                if created:
                    created_objects.append(tournament)
                # Get or create the relevant roster
                roster, created = Roster.objects.get_or_create(
                    team=team, tournament=tournament
                )
                if created:
                    created_objects.append(roster)
                # Create the link
                roster_link, created = RosterLink.objects.get_or_create(
                    player=p1, role=role_one, roster=roster
                )
                if created:
                    created_objects.append(roster_link)
        except IntegrityError as e:
            print(e)
            for obj in created_objects:
                obj.delete()
    print("")
    return


def reverse_data(apps, schema_editor):
    Tournament: models.Model = apps.get_model("pro2pro", "Tournament")
    Roster: models.Model = apps.get_model("pro2pro", "Roster")
    RosterLink: models.Model = apps.get_model("pro2pro", "RosterLink")
    Tournament.objects.all().delete()
    Roster.objects.all().delete()
    RosterLink.objects.all().delete()
    pass


class Migration(migrations.Migration):

    dependencies = [
        ("pro2pro", "0001_initial"),
    ]

    operations = [migrations.RunPython(init_data, reverse_code=reverse_data)]
