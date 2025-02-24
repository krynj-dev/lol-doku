from django.db import models
from players.models import Player

class Rule(models.Model):
    key = models.CharField(max_length=50, unique=True)
    rule_type = models.CharField(max_length=50)
    valid_players = models.ManyToManyField(Player, related_name='valid_rules')
    active = models.BooleanField(default=True, db_default=True)

    def __str__(self):
        return f'{self.key}'


class ValidCrosses(models.Model):
    rule = models.OneToOneField(Rule, on_delete=models.CASCADE, related_name='rule_cross')
    crosses = models.ManyToManyField(Rule, related_name='valid_crosses')
