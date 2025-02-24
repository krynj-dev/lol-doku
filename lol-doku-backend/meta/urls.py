from django.urls import path

from . import views

urlpatterns = [
    path("latest", views.get_metadata, name="getmetadata"),
]