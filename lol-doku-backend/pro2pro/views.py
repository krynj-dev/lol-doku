from django.shortcuts import render
from rest_framework import permissions, viewsets, generics
from pro2pro.models import RosterLink, Roster, Tournament
from pro2pro.serializers import RosterLinkSerializer, RosterSerializer, TournamentSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import OrderingFilter
import django_filters

#########################
#       Filters         #
#########################
class RosterLinkPlayerFilter(django_filters.FilterSet):
    player__display_name = django_filters.CharFilter(lookup_expr='iexact')

    class Meta:
        model = RosterLink
        fields = ['player__display_name',
        #  'team', 'tournament', 'team__alternate_name'
         ]

class RosterFilter(django_filters.FilterSet):
    # tournament__name = django_filters.CharFilter(lookup_expr='iexact')

    class Meta:
        model = Roster
        fields = ['tournament__name', 'team__alternate_name']

#########################
#       Viewsets        #
#########################
class RosterLinkViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = RosterLink.objects.all()
    serializer_class = RosterLinkSerializer
    permission_classes = [permissions.DjangoModelPermissionsOrAnonReadOnly]
    filter_backends = [DjangoFilterBackend, OrderingFilter]
    filterset_class = RosterLinkPlayerFilter
    ordering_fields = [ 'roster__tournament__date' ]

class RosterViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Roster.objects.all()
    serializer_class = RosterSerializer
    permission_classes = [permissions.DjangoModelPermissionsOrAnonReadOnly]
    filter_backends = [DjangoFilterBackend, OrderingFilter]
    filterset_class = RosterFilter
    ordering_fields = ['tournament__date']

class TournamentViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Tournament.objects.all()
    serializer_class = TournamentSerializer
    permission_classes = [permissions.DjangoModelPermissionsOrAnonReadOnly]