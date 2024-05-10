from django.db import models
from players.models import Player

class TieredValidPlayers(models.Model):
    primary = models.ManyToManyField(Player, related_name='primary_valid_players')
    secondary = models.ManyToManyField(Player, related_name='secondary_valid_players')

class Rule(models.Model):
    key = models.CharField(max_length=50, unique=True)
    rule_type = models.CharField(max_length=50)
    valid_players = models.ForeignKey(TieredValidPlayers, on_delete=models.CASCADE, blank=True, null=True, related_name='valid_playerz')

    def __str__(self):
        return f'{self.key}'


class TieredValidCrosses(models.Model):
    rule = models.OneToOneField(Rule, on_delete=models.CASCADE, related_name='parent_rule')
    primary = models.ManyToManyField(Rule, related_name='primary_valid_crosses')
    secondary = models.ManyToManyField(Rule, related_name='secondary_valid_crosses')
