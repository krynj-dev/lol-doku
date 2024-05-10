from django.db import models
from rules.models import Rule


class Puzzle(models.Model):
    def __str__(self):
        xes = self.assoc_rules.filter(axis='x')
        yes = self.assoc_rules.filter(axis='y')
        xstr = ', '.join([x.rule.key for x in xes])
        ystr = ', '.join([y.rule.key for y in yes])
        return f'{self.id}: [{xstr}] | [{ystr}]'

class PuzzleRule(models.Model):

    class RuleAxis(models.TextChoices):
        X = "x"
        Y = "y"

    puzzle = models.ForeignKey(Puzzle, on_delete=models.CASCADE, related_name='assoc_rules')
    rule = models.ForeignKey(Rule, on_delete=models.CASCADE, related_name='assoc_puzzles')
    axis = models.TextField(max_length=1, choices=RuleAxis)
    index = models.IntegerField(default=0)

