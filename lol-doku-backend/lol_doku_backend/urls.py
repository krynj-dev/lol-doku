"""
URL configuration for lol_doku_backend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import path, include
from django.contrib.auth.models import User
from django.contrib import admin
from rest_framework import routers
from players.views import PlayerViewSet, PlayerAlternateNameViewSet
from teams.views import TeamViewSet, TeamAlternateNameViewSet, TeamSisterTeamViewSet
from rules.views import RuleViewSet, ValidCrossesViewSet
from puzzles.views import PuzzleViewSet
from game.views import GameRosterViewSet, GameViewSet

# Routers provide an easy way of automatically determining the URL conf.
router = routers.DefaultRouter()
router.register(r'players', PlayerViewSet)
router.register(r'playersalternatenames', PlayerAlternateNameViewSet)
router.register(r'teams', TeamViewSet)
router.register(r'teamsalternamenames', TeamAlternateNameViewSet)
router.register(r'sisterteams', TeamSisterTeamViewSet)
router.register(r'rules', RuleViewSet)
router.register(r'validcrosses', ValidCrossesViewSet)
router.register(r'puzzles', PuzzleViewSet)
router.register(r'game/daily', GameRosterViewSet)
router.register(r'game', GameViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('admin/', admin.site.urls),
    path('puzzles/', include("puzzles.urls")),
    path('game/', include("game.urls")),
    path('stats/', include("stats.urls")),
]
