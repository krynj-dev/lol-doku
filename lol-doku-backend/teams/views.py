from teams.models import Team, TeamAlternateName, TeamSisterTeam
from rest_framework import permissions, viewsets, filters

from teams.serializers import TeamSerializer, TeamAlternateNameSerializer, TeamSisterTeamSerializer

class TeamViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = Team.objects.filter(active=True).order_by('name')
    serializer_class = TeamSerializer
    permission_classes = [permissions.AllowAny]
    filter_backends = [filters.SearchFilter]
    search_fields = ['^name']


class TeamAlternateNameViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset = TeamAlternateName.objects.all()
    serializer_class = TeamAlternateNameSerializer
    permission_classes = [permissions.AllowAny]

class TeamSisterTeamViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset = TeamSisterTeam.objects.all()
    serializer_class = TeamSisterTeamSerializer
    permission_classes = [permissions.AllowAny]