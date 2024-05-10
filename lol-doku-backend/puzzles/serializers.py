from rules.models import Rule
from puzzles.models import Puzzle, PuzzleRule
from rest_framework import serializers

class SimpleRuleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Rule
        fields = ['url', 'key', 'rule_type']

class PuzzleRuleSerializer(serializers.ModelSerializer):
    rule = SimpleRuleSerializer()

    class Meta:
        model = PuzzleRule
        fields = ['rule', 'axis', 'index']

    def to_representation(self, instance):
        representation =  super().to_representation(instance)
        rule = representation.pop('rule')

        for k, v in rule.items():
            representation[k] = v
        return representation

class PuzzleSerializer(serializers.ModelSerializer):
    rules = PuzzleRuleSerializer(many=True, source="assoc_rules")
   
    class Meta:
        model = Puzzle
        fields = ['url', 'rules']
