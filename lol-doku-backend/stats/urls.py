from django.urls import path

from . import views

urlpatterns = [
    path("today", views.get_puzzle_slot_stats, name="slot_stats"),
]