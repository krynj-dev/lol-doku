from django.urls import path

from . import views

urlpatterns = [
    path("today", views.StatsAPIView.as_view(), name="slot_stats"),
]