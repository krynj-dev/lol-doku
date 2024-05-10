from django.db import models

class Player(models.Model):
    display_name = models.CharField(max_length=50, unique=True)
    real_name = models.CharField(max_length=100, blank=True)
    country = models.CharField(max_length=100, blank=True)
    age = models.IntegerField(blank=True, null=True)
    residency = models.CharField(max_length=100)

    def __str__(self):
        return f'{self.display_name}'

class PlayerAlternateName(models.Model):
    player_name = models.ForeignKey(Player, on_delete=models.CASCADE, related_name='alternate_names')
    alternate_name = models.CharField(max_length=50)

    def __str__(self):
        return f'{self.alternate_name}'

    class Meta:
        unique_together = ('player_name', 'alternate_name')
