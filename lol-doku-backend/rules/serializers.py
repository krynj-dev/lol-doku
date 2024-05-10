from rules.models import Rule, TieredValidPlayers, TieredValidCrosses
from players.models import Player
from rest_framework import serializers

class TieredValidCrossesSerializer(serializers.ModelSerializer):
    primary = serializers.SlugRelatedField(
        many=True,
        slug_field='key',
        queryset=Rule.objects.all()
    )

    secondary = serializers.SlugRelatedField(
        many=True,
        slug_field='key',
        queryset=Rule.objects.all()
    )
   
    class Meta:
        model = TieredValidCrosses
        fields = ['url', 'primary', 'secondary']

class TieredValidPlayersSerializer(serializers.ModelSerializer):
    primary = serializers.SlugRelatedField(
        many=True,
        slug_field='display_name',
        queryset=Player.objects.all()
    )

    secondary = serializers.SlugRelatedField(
        many=True,
        slug_field='display_name',
        queryset=Player.objects.all()
    )
   
    class Meta:
        model = TieredValidPlayers
        fields = ['url', 'primary', 'secondary']

class RuleSerializer(serializers.ModelSerializer):
    valid_players = TieredValidPlayersSerializer()
    valid_crosses = TieredValidCrossesSerializer(source='parent_rule')

    def create(self, validated_data):
        valid_players_data = validated_data.pop('valid_players')
        valid_players = TieredValidPlayers.objects.create()
        for pp in valid_players_data.pop('primary'):
            valid_players.primary.add(pp)
        for sp in valid_players_data.pop('secondary'):
            valid_players.secondary.add(sp)
        valid_players.save()
        rule = Rule.objects.create(**validated_data, valid_players=valid_players)

        return rule    

    class Meta:
        model = Rule
        fields = ['url', 'key', 'rule_type', 'valid_players', 'valid_crosses']