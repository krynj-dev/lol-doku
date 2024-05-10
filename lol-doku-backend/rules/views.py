from rules.models import Rule, TieredValidPlayers, TieredValidCrosses
from rest_framework import permissions, viewsets, filters
from rest_framework.response import Response

from rules.serializers import RuleSerializer, TieredValidPlayersSerializer, TieredValidCrossesSerializer


class RuleViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = Rule.objects.all().order_by('key')
    serializer_class = RuleSerializer
    permission_classes = [permissions.AllowAny]
    filter_backends = [filters.SearchFilter]
    search_fields = ['^key']

class TieredValidPlayersViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = TieredValidPlayers.objects.all()
    serializer_class = TieredValidPlayersSerializer
    permission_classes = [permissions.AllowAny]

class TieredValidCrossesViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = TieredValidCrosses.objects.all()
    serializer_class = TieredValidCrossesSerializer
    permission_classes = [permissions.AllowAny]
    