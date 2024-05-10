from stats.models import CorrectPlayerGuess
from game.models import GameRoster
from players.models import Player
from puzzles.util import is_valid_guess
from puzzles.models import PuzzleRule

def update_stats(roster: GameRoster, x: int, y: int, player: Player):
        x_rule = roster.puzzle.assoc_rules.get(index=x, axis=PuzzleRule.RuleAxis.X).rule
        y_rule = roster.puzzle.assoc_rules.get(index=y, axis=PuzzleRule.RuleAxis.Y).rule

        if is_valid_guess(x_rule, y_rule, player):
            guess, created = CorrectPlayerGuess.objects.get_or_create(
                roster=roster,
                x = x_rule,
                y = y_rule,
                player=player
            )
            guess.guess_count += 1
            guess.save()
