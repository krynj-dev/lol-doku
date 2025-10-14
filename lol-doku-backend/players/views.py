from players.models import Player, PlayerAlternateName
from rest_framework import permissions, viewsets, filters
from django.contrib.postgres.aggregates import ArrayAgg

from players.serializers import PlayerAlternateNameSerializer, PlayerSerializer


class PlayerViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = Player.objects.all()
    serializer_class = PlayerSerializer
    permission_classes = [permissions.DjangoModelPermissionsOrAnonReadOnly]

    def get_queryset(self):
        qs = super().get_queryset()
        term = self.request.query_params.get("search")

        if term:
            qs = qs.search(term)
        return qs


class PlayerAlternateNameViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset = PlayerAlternateName.objects.all()
    serializer_class = PlayerAlternateNameSerializer
    permission_classes = [permissions.DjangoModelPermissionsOrAnonReadOnly]