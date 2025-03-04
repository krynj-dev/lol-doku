from django.urls import path

from . import views

urlpatterns = [
    path("gen", views.PuzzleGenerateApiView.as_view(), name="generate"),
]