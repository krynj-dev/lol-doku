from django.urls import path

from . import views

urlpatterns = [
    path("gen", views.generate, name="generate"),
    path("save", views.save_puzzle, name="save_puzzle"),
]