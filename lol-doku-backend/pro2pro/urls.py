from django.urls import path

from . import views

urlpatterns = [
    path("rosters/", views.TournamentRosterViewSet.as_view(), name="initgame"),
]
