from pro2pro.models import RosterLink, Roster, Tournament
from players.models import Player
from teams.models import TeamAlternateName, Team
from rest_framework import serializers
from django.urls import reverse
from urllib.parse import quote


class RosterLinkPlayerSerializer(serializers.ModelSerializer):
    link_url = serializers.SerializerMethodField()

    class Meta:
        model = Player
        fields = ["display_name", "url", "link_url"]

    def get_link_url(self, obj):
        request = self.context.get("request")  # Get request from context
        if request:
            return request.build_absolute_uri(
                "/"
            ) + "/roster-links/?ordering=-roster__tournament__date&limit=50&player__display_name={}".format(
                quote(obj.display_name)
            )


class RosterLinkTeamOpSerializer(serializers.ModelSerializer):

    class Meta:
        model = Team
        fields = ["url", "op"]


class RosterLinkTeamSerializer(serializers.ModelSerializer):
    team_name = serializers.CharField(source="alternate_name")
    # redirect_name = serializers.CharField(source="team_op__op")
    redirect_name = RosterLinkTeamOpSerializer(source="team_op")

    class Meta:
        model = TeamAlternateName
        fields = ["url", "team_name", "redirect_name"]


class TournamentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tournament
        fields = ["url", "name", "date"]


class RosterLinkSerializerA(serializers.ModelSerializer):
    player = RosterLinkPlayerSerializer(read_only=True)
    link_url = serializers.SerializerMethodField()

    class Meta:
        model = RosterLink
        fields = ["player", "role", "link_url"]

    def get_link_url(self, obj):
        request = self.context.get("request")  # Get request from context
        if request:
            return request.build_absolute_uri(
                "/"
            ) + "/roster-links/?ordering=-roster__tournament__date&limit=50&player__display_name={}".format(
                quote(obj.player.display_name)
            )


#########################
#   Roster Serializers  #
#########################


class RosterSerializer(serializers.ModelSerializer):
    team = RosterLinkTeamSerializer(read_only=True)
    tournament = TournamentSerializer(read_only=True)
    players = RosterLinkSerializerA(many=True, read_only=True, source="roster_links")

    class Meta:
        model = Roster
        fields = ["url", "team", "tournament", "players"]


class ReducedRosterSerializer(serializers.ModelSerializer):
    team = RosterLinkTeamSerializer(read_only=True)
    tournament = TournamentSerializer(read_only=True)

    class Meta:
        model = Roster
        fields = [
            "url",
            "team",
            "tournament",
        ]


##############################


class RosterLinkSerializer(serializers.ModelSerializer):
    player = RosterLinkPlayerSerializer(read_only=True)
    roster = ReducedRosterSerializer(read_only=True)

    class Meta:
        model = RosterLink
        fields = [
            "player",
            "role",
            "roster",
        ]
