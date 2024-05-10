from players.models import Player, PlayerAlternateName
from rest_framework import serializers


class PlayerSerializer(serializers.ModelSerializer):
    alternate_names = serializers.SlugRelatedField(
        many=True,
        read_only=True,
        slug_field='alternate_name'
    )

    class Meta:
        model = Player
        fields = ['url', 'display_name', 'real_name', 'country', 'age', 'residency', 'alternate_names']



class PlayerAlternateNameSerializer(serializers.ModelSerializer):
    class Meta:
        model = PlayerAlternateName
        fields = ['url', 'alternate_name', 'player_name']