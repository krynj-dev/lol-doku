from players.models import Player, PlayerAlternateName
from rest_framework import permissions, viewsets, filters

from players.serializers import PlayerAlternateNameSerializer, PlayerSerializer


class PlayerViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = Player.objects.filter(active=True).order_by('display_name')
    serializer_class = PlayerSerializer
    permission_classes = [permissions.AllowAny]
    filter_backends = [filters.SearchFilter]
    search_fields = ['display_name']


class PlayerAlternateNameViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset = PlayerAlternateName.objects.all()
    serializer_class = PlayerAlternateNameSerializer
    permission_classes = [permissions.AllowAny]