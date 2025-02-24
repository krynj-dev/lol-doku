from django.shortcuts import render
from django.http import HttpResponse , HttpRequest, JsonResponse, HttpResponseServerError
import json
from meta.models import DataUpdate
from meta.serializers import DataUpdateSerializer
from django.core import serializers


# Create your views here.
def get_metadata(request: HttpRequest):
    metadata = DataUpdate.objects.all().order_by('-date').first()
    gs = DataUpdateSerializer(metadata, context={'request': request})
    response = JsonResponse(gs.data)  
    return response
