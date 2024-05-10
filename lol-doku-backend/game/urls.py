from django.urls import path

from . import views

urlpatterns = [
    path("session", views.get_session, name="initgame"),
    path("today", views.get_or_create_game, name="get_today"),
    path("guess/today", views.make_guess, name="guess_today"),
    path("finalise/today", views.finalise, name="finalise_today"),
]