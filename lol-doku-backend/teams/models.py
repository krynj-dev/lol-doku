from django.db import models

class Team(models.Model):
    becomes = models.CharField(max_length=100, blank=True, null=True)
    came_from = models.CharField(max_length=100, blank=True, null=True)
    highest_level = models.CharField(max_length=30)
    image = models.CharField(max_length=150, blank=True, null=True)
    name = models.CharField(max_length=100)
    op = models.CharField(max_length=100)
    region = models.CharField(max_length=30, blank=True, null=True)
    short = models.CharField(max_length=5, blank=True, null=True)

class TeamAlternateName(models.Model):
    team_op = models.ForeignKey(Team, on_delete=models.CASCADE, related_name='alternate_names')
    alternate_name = models.CharField(max_length=50)

class TeamSisterTeam(models.Model):
    team_op = models.ForeignKey(Team, on_delete=models.CASCADE, related_name='sister_teams')
    sister_team_name = models.CharField(max_length=50)