from django.db import models
from players.models import Player
from teams.models import TeamAlternateName

class Tournament(models.Model):
    name = models.CharField(max_length=128, null=False, blank=False)
    date = models.DateField(null=True, blank=True)

    class Meta:
        unique_together = ('name', 'date')

class Roster(models.Model):
    team = models.ForeignKey(TeamAlternateName, on_delete=models.CASCADE, null=False)
    tournament = models.ForeignKey(Tournament, on_delete=models.CASCADE, null=False)

    class Meta:
        unique_together = ('team', 'tournament')

class RosterLink(models.Model):
    class Role(models.TextChoices):
        TOP = "Top"
        JUNGLE = "Jungle"
        MIDDLE = "Mid"
        BOTTOM = "Bot"
        SUPPORT = "Support"
        SUBSTITUTE = "Substitute"
        COACH = "Coach"

    roster = models.ForeignKey(Roster, on_delete=models.CASCADE, related_name='roster_links', null=False)
    player = models.ForeignKey(Player, on_delete=models.CASCADE, related_name='player_links', null=False)
    role = models.CharField(choices=Role, max_length=20)
    
    class Meta:
        unique_together = ('roster', 'player', 'role')

class Pro2ProPlayerPuzzle(models.Model):
    player_from = models.ForeignKey(Player, on_delete=models.CASCADE, related_name='player_from', null=False)
    player_to = models.ForeignKey(Player, on_delete=models.CASCADE, related_name='player_to', null=False)

class Pro2ProRosterPuzzle(models.Model):
    roster_from = models.ForeignKey(Roster, on_delete=models.CASCADE, related_name='roster_from', null=False)
    roster_to = models.ForeignKey(Roster, on_delete=models.CASCADE, related_name='roster_to', null=False)