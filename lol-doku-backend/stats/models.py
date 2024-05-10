from django.db import models
from game.models import GameRoster
from rules.models import Rule
from players.models import Player

class CorrectPlayerGuess(models.Model):
    roster = models.ForeignKey(GameRoster, on_delete=models.CASCADE, related_name='correct_guesses_roster')
    x = models.ForeignKey(Rule, on_delete=models.CASCADE, related_name='x_correct_guesses')
    y = models.ForeignKey(Rule, on_delete=models.CASCADE, related_name='y_correct_guesses')
    player = models.ForeignKey(Player, on_delete=models.CASCADE, related_name='correct_guesses_player')
    guess_count = models.IntegerField(default=0)

    class Meta:
        unique_together = ('x', 'y', 'player', 'roster')
