from django.urls import path

from . import views

urlpatterns = [
    path("latest", views.get_metadata, name="getmetadata"),
    path("login", views.UserLoginView.as_view(), name="userapilogin"),
]
