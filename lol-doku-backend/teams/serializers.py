from teams.models import Team, TeamAlternateName, TeamSisterTeam
from rest_framework import serializers

class TeamAlternateNameSerializer(serializers.ModelSerializer):
    class Meta:
        model = TeamAlternateName
        fields = ['url', 'alternate_name', 'team_op']

class TeamSisterTeamSerializer(serializers.ModelSerializer):
    class Meta:
        model = TeamSisterTeam
        fields = ['url', 'sister_team_name', 'team_op']

class TeamSerializer(serializers.ModelSerializer):
    other_names = serializers.SlugRelatedField(
        many=True,
        read_only=True,
        slug_field='alternate_name',
        source="alternate_names"
    )

    sister_teams = serializers.SlugRelatedField(
        many=True,
        read_only=True,
        slug_field='sister_team_name'
    )

    class Meta:
        model = Team
        fields = ['url', 'name', 'op', 'region', 'becomes', 'came_from', 'other_names', 'sister_teams', 'highest_level', 'image', 'short']
