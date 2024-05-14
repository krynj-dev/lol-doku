from rules.models import Rule, ValidCrosses
from players.models import Player
from rest_framework import serializers

class ValidCrossesSerializer(serializers.ModelSerializer):
    crosses = serializers.SlugRelatedField(
        many=True,
        slug_field='key',
        queryset=Rule.objects.all()
    )
   
    class Meta:
        model = ValidCrosses
        fields = ['url', 'crosses']

class RuleSerializer(serializers.ModelSerializer):
    valid_crosses = ValidCrossesSerializer(source='rule_cross')
    valid_players = serializers.SlugRelatedField(many=True, slug_field="display_name", queryset=Player.objects.all())
    # Todo, continue propagation of rule format change
    def create(self, validated_data):
        valid_players_data = validated_data.pop('valid_players')
        rule = Rule.objects.create(**validated_data)
        for pp in valid_players_data:
            rule.valid_players.add(Player.objects.get(display_name=pp))
        rule.save()
        return rule    

    class Meta:
        model = Rule
        fields = ['url', 'key', 'rule_type', 'valid_players', 'valid_crosses']