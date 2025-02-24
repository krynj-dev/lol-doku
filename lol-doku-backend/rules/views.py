from rules.models import Rule, ValidCrosses
from rest_framework import permissions, viewsets, filters
from rest_framework.response import Response

from rules.serializers import RuleSerializer, ValidCrossesSerializer


class RuleViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = Rule.objects.filter(active=True).order_by('key')
    serializer_class = RuleSerializer
    permission_classes = [permissions.AllowAny]
    filter_backends = [filters.SearchFilter]
    search_fields = ['^key']

class ValidCrossesViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = ValidCrosses.objects.all()
    serializer_class = ValidCrossesSerializer
    permission_classes = [permissions.AllowAny]
    