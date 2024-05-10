from django.db import models
from puzzles.models import Puzzle
from players.models import Player

# Create your models here.

class GameRoster(models.Model):
    date = models.DateField(unique=True)
    puzzle = models.ForeignKey(Puzzle, on_delete=models.CASCADE, related_name='puzzle_roster')

class Game(models.Model):
    rostered_puzzle = models.ForeignKey(GameRoster, on_delete=models.CASCADE, related_name='games')
    sessionid = models.CharField(max_length=64)
    # Game Resource Fields
    remaining_guesses = models.IntegerField(default=10)
    class Status(models.TextChoices):
        IN_PROGRESS = "in_progress"
        FINALISED = "finalised"

    status = models.CharField(choices=Status, max_length=20, default=Status.IN_PROGRESS)

    class Meta:
        unique_together = ('rostered_puzzle', 'sessionid')

class GameGuess(models.Model):
    game =  models.ForeignKey(Game, on_delete=models.CASCADE, related_name='guesses')
    player = models.ForeignKey(Player, on_delete=models.CASCADE, related_name='guesses', null=True, blank=True)
    correct = models.BooleanField(default=False)
    slot = models.IntegerField()

    class Meta:
        unique_together = ('game', 'slot')

