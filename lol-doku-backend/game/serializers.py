from rules.models import Rule
from puzzles.models import Puzzle, PuzzleRule
from rest_framework import serializers
from puzzles.serializers import PuzzleSerializer
from game.models import GameRoster, Game, GameGuess
from stats.models import CorrectPlayerGuess

class GameRosterSerializer(serializers.ModelSerializer):
    puzzle = serializers.HyperlinkedRelatedField(
        queryset=Puzzle.objects.all(),
        view_name='puzzle-detail'
    )

    class Meta:
        model = GameRoster
        fields = ['url', 'date', 'puzzle']

    def create(self, validated_data):
        instance = super().create(validated_data)
        # create the empty player stats
        puzzle = instance.puzzle
        x_rule = [r.rule for r in puzzle.assoc_rules.filter(axis=PuzzleRule.RuleAxis.X).order_by('index')]
        y_rule = [r.rule for r in puzzle.assoc_rules.filter(axis=PuzzleRule.RuleAxis.Y).order_by('index')]
        for x in range(len(x_rule)):
            for y in range(len(y_rule)):
                valid_players = set(x_rule[x].valid_players.primary.all()) & set(y_rule[y].valid_players.primary.all())
                for plr in valid_players:
                    cpg = CorrectPlayerGuess.objects.create(roster=instance, x=x_rule[x], y=y_rule[y], player=plr)
                    cpg.save()
        return instance

class GameGuessSerializer(serializers.ModelSerializer):
    player = serializers.SlugRelatedField(
        queryset=Puzzle.objects.all(),
        slug_field='display_name'
    )

    class Meta:
        model = GameGuess
        fields = ['player', 'slot', 'correct']

class GameRosterFullSerializer(serializers.ModelSerializer):
    puzzle = PuzzleSerializer()

    class Meta:
        model = GameRoster
        fields = ['date', 'puzzle']

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        puzzle = representation.pop('puzzle')

        for k, v in puzzle.items():
            representation[k] = v
        return representation

class GameSerializer(serializers.ModelSerializer):
    guesses = GameGuessSerializer(many=True)
    
    puzzle = GameRosterFullSerializer(source='rostered_puzzle')

    class Meta:
        model = Game
        fields = ['remaining_guesses', 'puzzle',
         'guesses', 'status']