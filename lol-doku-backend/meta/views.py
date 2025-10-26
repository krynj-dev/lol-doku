from django.shortcuts import render
from django.http import HttpRequest, JsonResponse
import datetime
from meta.models import DataUpdate
from meta.serializers import DataUpdateSerializer
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.authtoken.models import Token
from django.contrib.auth import authenticate


# Create your views here.
def get_metadata(request: HttpRequest):
    metadata = DataUpdate.objects.all().order_by("-date").first()
    gs = DataUpdateSerializer(metadata, context={"request": request})
    response = JsonResponse(gs.data | {"server_time": datetime.datetime.now()})
    return response


class UserLoginView(APIView):
    def post(self, request):
        user = authenticate(
            username=request.data["username"], password=request.data["password"]
        )
        if user:
            token, created = Token.objects.get_or_create(user=user)
            return Response({"token": token.key})
        else:
            return Response({"error": "Invalid credentials"}, status=401)
