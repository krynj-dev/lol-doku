from players.models import Player
from stats.models import CorrectPlayerGuess
from rest_framework import serializers

class CorrectPlayerGuessSerializer(serializers.ModelSerializer):
    guesses = serializers.IntegerField(source='guess_count')
    player = serializers.SlugRelatedField(
        queryset=Player.objects.all(),
        slug_field='display_name'
    )

    class Meta:
        model = CorrectPlayerGuess
        fields = ['player', 'guesses']
